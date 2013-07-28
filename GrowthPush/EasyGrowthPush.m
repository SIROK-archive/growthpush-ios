//
//  EasyGrowthPush.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/14.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GrowthPush.h"
#import "GPAppDelegateWrapper.h"

@interface EasyGrowthPushAppDelegateIntercepter : NSObject <GPAppDelegateWrapperDelegate>

@end

@implementation EasyGrowthPushAppDelegateIntercepter

- (void) willPerformApplicationDidBecomeActive:(UIApplication *)application {
    [GrowthPush trackEvent:@"Launch"];
}

- (void) willPerformApplication:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [GrowthPush setDeviceToken:deviceToken];
}

- (void) willPerformApplication:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [GrowthPush setDeviceToken:nil];
}

@end

static EasyGrowthPush *sharedInstance = nil;

@interface EasyGrowthPush () {

    GPAppDelegateWrapper *appDelegateWrapper;
    EasyGrowthPushAppDelegateIntercepter *appDelegateIntercepter;

}

@property (nonatomic, retain) GPAppDelegateWrapper *appDelegateWrapper;
@property (nonatomic, retain) EasyGrowthPushAppDelegateIntercepter *appDelegateIntercepter;

@end

@implementation EasyGrowthPush

@synthesize appDelegateWrapper;
@synthesize appDelegateIntercepter;

+ (EasyGrowthPush *) sharedInstance {
    @synchronized(self) {
        if (!sharedInstance)
            sharedInstance = [[self alloc] init];
        return sharedInstance;
    }
}

+ (void) setApplicationId:(NSInteger)applicationId secret:(NSString *)secret environment:(GPEnvironment)environment debug:(BOOL)debug {
    [[self sharedInstance] setApplicationId:applicationId secret:secret environment:environment debug:debug];
}

- (void) setApplicationId:(NSInteger)applicationId secret:(NSString *)secret environment:(GPEnvironment)environment debug:(BOOL)debug {

    self.appDelegateWrapper = [[[GPAppDelegateWrapper alloc] init] autorelease];
    [appDelegateWrapper setOriginalAppDelegate:[[UIApplication sharedApplication] delegate]];
    self.appDelegateIntercepter = [[[EasyGrowthPushAppDelegateIntercepter alloc] init] autorelease];
    [appDelegateWrapper setDelegate:appDelegateIntercepter];
    [[UIApplication sharedApplication] setDelegate:appDelegateWrapper];

    [GrowthPush setApplicationId:applicationId secret:secret environment:environment debug:debug];
    [GrowthPush requestDeviceToken];
    [GrowthPush setDeviceTags];

}

@end
