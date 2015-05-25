# GrowthPush SDK for iOS

[Growth Push](https://growthpush.com/) is push notification and analysis platform for mobile apps.

## Usage 

1. Install [Growthbeat Core SDK](https://github.com/SIROK/growthbeat-core-ios).

1. Add GrowthPush.framework into your project.

1. Import the framework header.

	```objc
	#import <GrowthPush/GrowthPush.h>
	```

1. Write initialization code.

	```objc
	[GrowthPush initializeWithApplicationId:@"APPLICATION_ID" credentialId:@"CREDENTIAL_ID" environment:kGrowthPushEnvironment];
	```

	GrowthPush instance will get APNS device token, send it to server. You can get the APPLICATION_ID and CREDENTIAL_ID on web site of GrowthPush. 

1. (Optional) If you would like to use analytics platform or segment notification, track events or set tags with following code.

	```objc
	[GrowthPush trackEvent:@"NAME" value:@"VALUE"];
	[GrowthPush setTag:@"NAME" value:@"VALUE"];
	```
	
## Growthbeat Full SDK

You can use Growthbeat SDK instead of this SDK. Growthbeat is growth hack tool for mobile apps. You can use full functions include Growth Push when you use the following SDK.

* [Growthbeat SDK for iOS](https://github.com/SIROK/growthbeat-ios/)
* [Growthbeat SDK for Android](https://github.com/SIROK/growthbeat-android/)

# Building framework

[iOS-Universal-Framework](https://github.com/kstenerud/iOS-Universal-Framework) is required.

```bash
git clone https://github.com/kstenerud/iOS-Universal-Framework.git
cd ./iOS-Universal-Framework/Real\ Framework/
./install.sh
```

Archive the project on Xcode and you will get framework package.

## License

Apache License, Version 2.0


