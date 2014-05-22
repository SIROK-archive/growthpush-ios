#!/usr/bin/env ruby

require 'rubygems'
require 'optparse'

module Tty extend self
	def red; escape 31; end
	def green; escape 32; end
	def yellow; escape 33; end
	def blue; escape 34 end
	def reset; escape 0; end
	def escape n; "\033[#{n}m" if STDOUT.tty?; end
end

def error message
	STDERR.print "#{Tty.red}[ERROR]#{Tty.reset} #{message}\n"
	exit 1
end

begin
	gem 'xcodeproj', '>= 0.5.0'
	require 'xcodeproj'
rescue LoadError
	error("xcodeproj gem is required.\nRun \"#{Tty.yellow}gem install xcodeproj#{Tty.reset}\" or \"#{Tty.yellow}sudo gem install xcodeproj#{Tty.reset}\"\nIf it is installed, restart the shell.")
	exit 1
end

xcodeproj_version = Gem.loaded_specs["xcodeproj"].version.to_s
xcodeproj_version_number = xcodeproj_version.gsub(/(\d+)\.\d+(\.\d+)*/, '\1').to_i * 100 + xcodeproj_version.gsub(/\d+\.(\d+)(\.\d+)*/, '\1').to_i

def include_framework? (target, name)
	target.frameworks_build_phase.files.each { |element|
		if element.display_name.include?(name) then
			return true
		end
	}
	return false
end

def add_framework_search_path (build_settings, path)
	if !build_settings['FRAMEWORK_SEARCH_PATHS'] then
		build_settings['FRAMEWORK_SEARCH_PATHS'] = path
	else
		if !build_settings['FRAMEWORK_SEARCH_PATHS'].include?(path) then
			if build_settings['FRAMEWORK_SEARCH_PATHS'].instance_of?(String) then
				build_settings['FRAMEWORK_SEARCH_PATHS'].concat(" #{path}")
			else
				build_settings['FRAMEWORK_SEARCH_PATHS'].push(path)
			end
		end
	end
end

def ask (question)
	print question
    case(STDIN.gets.chomp)
    when /^y(es)?$/i
      return true
    when /^no?$/i
      return false
    end
	return ask(question)
end

# Parse options parameters
opt = OptionParser.new
skip_confirm = false
opt.on('-y') {|v| skip_confirm = true }
overwrite = false
opt.on('-o') {|v| overwrite = true }
library_path = 'https://growthpush.com/downloads/ios/libraries/latest'
opt.on('-l VAL') {|v| library_path = v }
project_directory = `pwd`
opt.on('-p VAL') {|v| project_directory = v }
application_id = nil
opt.on('-i VAL') {|v| application_id = v }
secret = nil
opt.on('-s VAL') {|v| secret = v }
opt.parse!(ARGV)

library_path = library_path.sub(/(\/|\s)+$/, '')
project_directory = project_directory.sub(/(\/|\s)+$/, '')
edit_source = false
if application_id && secret then
	initialize_code = "[EasyGrowthPush setApplicationId:#{application_id} secret:@\"#{secret}\" environment:kGrowthPushEnvironment debug:YES];"
	edit_source = true
end
download_library = (/^https?:\/\// =~ library_path)

project_file_suffix = '.xcodeproj'
framework_name = 'GrowthPush.framework'
framework_dependencies = []
import_code = '#import <GrowthPush/GrowthPush.h>'

# Search project file
project_files = Dir.glob(project_directory + '/*' + project_file_suffix)
if project_files.size < 1 then
  error(".xcodeproj file not found in current directory. Change directory to project.")
elsif project_files.size > 1 then
  error("Multiple .xcodeproj file found.")
end

project_name = File.basename(project_files[0], project_file_suffix)
project_file = project_name + project_file_suffix
if xcodeproj_version_number >= 10 then
	project = Xcodeproj::Project.open("#{project_directory}/#{project_file}")
else
	project = Xcodeproj::Project.new("#{project_directory}/#{project_file}")
end

# Search app target
target = nil
project.targets.each { |element|
	if (element.name == project_name)
		target = element
	end
}
if !target then
	error("Build target cannot be specified.")
end

# Add GrowthPush.framework and some frameworks.
if !include_framework?(target, framework_name) then
	file_reference = project.frameworks_group.new_file("#{project_directory}/#{framework_name}")
	target.frameworks_build_phase.add_file_reference(file_reference)
elsif !overwrite then
	error("GrowthPush.framework already added.")
end

framework_dependencies.each{ |element|
	if !include_framework?(target, element) then
		file_reference = project.add_system_framework(element, target)
		target.frameworks_build_phase.add_file_reference(file_reference)
	end
}

# Add EasyGrowthPush call to AppDelegate
app_delegate_file = nil
target.source_build_phase.files.each { |element|
	if element.display_name.include?('AppDelegate') then
		app_delegate_file = element.file_ref.path
	end
}
if !app_delegate_file then
	error("AppDelegate file cannot be specified.")
end

app_delegate_files = Dir.glob("#{project_directory}/**/#{app_delegate_file}")
if project_files.size < 1 then
  error("AppDelegate file not found.")
end
app_delegate_file_path = app_delegate_files[0]
app_delegate_contents = File.read(app_delegate_file_path)
if initialize_code && !app_delegate_contents.include?(initialize_code) then
	app_delegate_contents = app_delegate_contents.sub(/application:[^:]+didFinishLaunchingWithOptions:[^:]+?\{/, "\\0\n    #{initialize_code}")
end

# Add Framework Search Path Option
add_framework_search_path(target.build_settings('Debug'), '$(inherited)')
add_framework_search_path(target.build_settings('Debug'), '$(SRCROOT)')
add_framework_search_path(target.build_settings('Release'), '$(inherited)')
add_framework_search_path(target.build_settings('Release'), '$(SRCROOT)')

# Add GrowthPush import statement to prefix header
prefix_header_file = target.build_settings('Debug')['GCC_PREFIX_HEADER']
prefix_header_file_path = "#{project_directory}/#{prefix_header_file}"
prefix_header_contents = File.read(prefix_header_file_path)
if import_code && !prefix_header_contents.include?(import_code) then
	prefix_header_contents = prefix_header_contents.sub(/#import[^\n]+Foundation.h[^\n]+/, "\\0\n#{import_code}")
end

# Apply changes
puts "Project directory: #{project_directory}"
puts "Project file: #{project_file}\n\n"
puts "Project will be applied following changes"
puts "Making a backup of project is recommended."
if download_library then
	puts "* Download library"
end
puts "* Install and link GrowthPush.framework"
puts "* Add $(inherit) and $(SRCROOT) to framework search paths"
if edit_source then
	puts "* Import GrowthPush.h in prefix header"
	puts "* Call EasyGrowthPush in AppDelegate\n\n"
end
if !skip_confirm && !ask("Is this ok? [y/n]: ") then
	error("Installation was canceled.")
end

if download_library then
	puts "Downloading GrowthPush.framework..."
	system "mkdir -p /tmp/GrowthPush && curl -fsSL #{library_path} -o /tmp/GrowthPush/growthpush-ios.zip && unzip -qo /tmp/GrowthPush/growthpush-ios.zip -d /tmp/GrowthPush/"
	library_path = '/tmp/GrowthPush/growthpush-ios/GrowthPush.framework'
end

puts "Copy GrowthPush.framework to project..."
system "cp -r #{library_path} #{project_directory}/"

if edit_source then
	puts "Editing source files..."
	File.open(app_delegate_file_path, 'w') { |file| file << app_delegate_contents }
	File.open(prefix_header_file_path, 'w') { |file| file << prefix_header_contents }
end

puts "Update project files..."
if xcodeproj_version_number >= 10 then
	project.save("#{project_directory}/#{project_file}")
else
	project.save_as("#{project_directory}/#{project_file}")
end

puts "\n#{Tty.green}Completed!#{Tty.reset}"

