# Growth Push SDK for iOS

:warning: **This SDK will be depricated** :warning:  

You can use Growthbeat sdk insead:
* [Growthbeat SDK for iOS](https://github.com/SIROK/growthbeat-ios/)
* [Growthbeat SDK for Android](https://github.com/SIROK/growthbeat-android/)

---


GrowthPush is push notification and analysis platform for smart devices.

https://growthpush.com/

## Easy usage

```objc
[EasyGrowthPush setApplicationId:YOUR_APP_ID secret:@"YOUR_APP_SECRET" environment:kGrowthPushEnvironment debug:YES]; 
```

That's all. GrowthPush instance will get APNS device token, send it to server, track launching event and tag the device information. You can get the app ID and secret on web site of GrowthPush. 

You can get furthermore information on [GrowthPush documetations](https://growthpush.com/documents).

## Install with script

Run install script.

```bash
ruby ./install.rb -l ./GrowthPush.framework -p /path/to/your_project -i APPLICATION_ID -s APPLICATION_SECRET
```

## Install with CocoaPods

Add GrowthPush dependency to Podfile.

```bash
pod 'GrowthPush' 
```

Then run pod command

```bash
pod install
```

## Building GrowthPush.framework

[iOS-Universal-Framework](https://github.com/kstenerud/iOS-Universal-Framework) is required.

```shell
git clone https://github.com/kstenerud/iOS-Universal-Framework.git
cd ./iOS-Universal-Framework/Real\ Framework/
./install.sh
```

1. Set the build configuration of "Run" to Release.
2. Select the destination to "iOS device"
3. Build the framework
4. The framework will be generated under "Products"

## License

Licensed under the Apache License.
