require 'rubygems'

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
	gem "xcodeproj", "~> 0.9.0"
	require 'xcodeproj'
rescue LoadError
	error("xcodeproj gem is required.\nRun \"#{Tty.yellow}gem install xcodeproj#{Tty.reset}\" or \"#{Tty.yellow}sudo gem install xcodeproj#{Tty.reset}\"\nIf it is installed, restart the shell.")
	exit 1
end

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

if ARGV.size < 2 then
  error("Incomplete parameters. Usage: #{$0} <application-id> <secret>")
end

application_id = ARGV[0]
secret = ARGV[1]
initialize_code = "[EasyGrowthPush setApplicationId:#{application_id} secret:@\"#{secret}\" environment:kGrowthPushEnvironment debug:YES];"
framework_url = 'https://growthpush.com/downloads/ios/libraries/latest'
project_file_suffix = '.xcodeproj'
framework_path = 'GrowthPush.framework'
framework_dependencies = ['Security', 'SystemConfiguration', 'MobileCoreServices']

# Search project file
root_directory = `pwd`.chomp
project_files = Dir.glob(root_directory + '/*' + project_file_suffix)
if project_files.size < 1 then
  error(".xcodeproj file not found in current directory. Change directory to project.")
elsif project_files.size > 1 then
  error("Multiple .xcodeproj file found.")
end

project_name = File.basename(project_files[0], project_file_suffix)
project_file = project_name + project_file_suffix
project = Xcodeproj::Project.new("#{root_directory}/#{project_file}")

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
if include_framework?(target, framework_path) then
	error("GrowthPush.framework already added.")
end
file_reference = project.frameworks_group.new_framework("#{root_directory}/#{framework_path}")
target.frameworks_build_phase.add_file_reference(file_reference)

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

app_delegate_files = Dir.glob("#{root_directory}/**/#{app_delegate_file}")
if project_files.size < 1 then
  error("AppDelegate file not found.")
end
app_delegate_file_path = app_delegate_files[0]
app_delegate_contents = File.read(app_delegate_file_path)
app_delegate_contents = app_delegate_contents.sub(/application:[^:]+didFinishLaunchingWithOptions:[^:]+?\{/, "\\0\n    #{initialize_code}")

# Add Framework Search Path Option
add_framework_search_path(target.build_settings('Debug'), '$(inherited)')
add_framework_search_path(target.build_settings('Debug'), '$(SRCROOT)')
add_framework_search_path(target.build_settings('Release'), '$(inherited)')
add_framework_search_path(target.build_settings('Release'), '$(SRCROOT)')

# Add GrowthPush import statement to prefix header
prefix_header_file = target.build_settings('Debug')['GCC_PREFIX_HEADER']
prefix_header_file_path = "#{root_directory}/#{prefix_header_file}"
prefix_header_contents = File.read(prefix_header_file_path)
prefix_header_contents = prefix_header_contents.sub(/#import[^\n]+Foundation.h[^\n]+/, "\\0\n#import <GrowthPush/GrowthPush.h>")

# Apply changes
puts "Project directory: #{root_directory}"
puts "Project file: #{project_file}\n\n"
puts "Project will be applied following changes"
puts "Making a backup of project is recommended."
puts "1. Download, install and link GrowthPush.framework"
puts "2. Link Security.framework, SystemConfiguration.framework and MobileCoreServices.framework"
puts "3. Add $(inherit) and $(SRCROOT) to framework search paths"
puts "4. Import GrowthPush.h in prefix header"
puts "5. Call EasyGrowthPush in AppDelegate\n\n"
if !ask("Is this ok? [y/n]: ") then
	error("Installation was canceled.")
end

puts "Downloading GrowthPush.framework..."
system "mkdir -p /tmp/GrowthPush && curl -fsSL #{framework_url} -o /tmp/GrowthPush/GrowthPush.framework.zip && unzip -qo /tmp/GrowthPush/GrowthPush.framework.zip -d /tmp/GrowthPush/ && mv /tmp/GrowthPush/GrowthPush.framework ./ && rm -rf /tmp/GrowthPush"

puts "Editing source files..."
File.open(app_delegate_file_path, 'w') { |file| file << app_delegate_contents }
File.open(prefix_header_file_path, 'w') { |file| file << prefix_header_contents }

puts "Update project files..."
project.save_as("#{root_directory}/#{project_file}")

puts "\n#{Tty.green}Completed!#{Tty.reset}"
