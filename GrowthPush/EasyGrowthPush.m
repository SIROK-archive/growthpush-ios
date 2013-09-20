//
//  EasyGrowthPush.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/14.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GrowthPush.h"
#import "GPAppDelegateWrapper.h"
#import "GPDevice.h"

@interface GrowthPush ()

+ (id) sharedInstance;

- (void) setApplicationId:(NSInteger)newApplicationId secret:(NSString *)newSecret environment:(GPEnvironment)newEnvironment debug:(BOOL)newDebug;

@end

@interface EasyGrowthPushAppDelegateIntercepter : NSObject <GPAppDelegateWrapperDelegate>

@end

@interface EasyGrowthPush () {
    
    GPAppDelegateWrapper *appDelegateWrapper;
    EasyGrowthPushAppDelegateIntercepter *appDelegateIntercepter;
    EGPOption option;
    
}

@property (nonatomic, retain) GPAppDelegateWrapper *appDelegateWrapper;
@property (nonatomic, retain) EasyGrowthPushAppDelegateIntercepter *appDelegateIntercepter;
@property (nonatomic, assign) EGPOption option;

@end

@implementation EasyGrowthPushAppDelegateIntercepter

- (void) willPerformApplicationDidBecomeActive:(UIApplication *)application {
    
    if([[EasyGrowthPush sharedInstance] option] & EGPOptionTrackLaunch)
        [GrowthPush trackEvent:@"Launch"];
    
}

- (void) willPerformApplication:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [GrowthPush setDeviceToken:deviceToken];
}

- (void) willPerformApplication:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [GrowthPush setDeviceToken:nil];
}

@end

@implementation EasyGrowthPush

@synthesize appDelegateWrapper;
@synthesize appDelegateIntercepter;
@synthesize option;

+ (void) setApplicationId:(NSInteger)applicationId secret:(NSString *)secret environment:(GPEnvironment)environment debug:(BOOL)debug {
    [[self sharedInstance] setApplicationId:applicationId secret:secret environment:environment debug:debug];
}

+ (void) setApplicationId:(NSInteger)applicationId secret:(NSString *)secret environment:(GPEnvironment)environment debug:(BOOL)debug option:(EGPOption)option {
    [[self sharedInstance] setApplicationId:applicationId secret:secret environment:environment debug:debug option:option];
}

- (id) init {
    self = [super init];
    if (self){
        self.option = EGPOptionAll;
    }
    return self;
}

- (void) setApplicationId:(NSInteger)applicationId secret:(NSString *)secret environment:(GPEnvironment)environment debug:(BOOL)debug {
    
    [super setApplicationId:applicationId secret:secret environment:environment debug:debug];
    
    self.appDelegateWrapper = [[[GPAppDelegateWrapper alloc] init] autorelease];
    [appDelegateWrapper setOriginalAppDelegate:[[UIApplication sharedApplication] delegate]];
    self.appDelegateIntercepter = [[[EasyGrowthPushAppDelegateIntercepter alloc] init] autorelease];
    [appDelegateWrapper setDelegate:appDelegateIntercepter];
    [[UIApplication sharedApplication] setDelegate:appDelegateWrapper];
    
    [GrowthPush clearBadge];
    [GrowthPush requestDeviceToken];
    
    if ((option & EGPOptionTagDevie) && [GPDevice device])
        [GrowthPush setTag:@"Device" value:[GPDevice device]];
    if ((option & EGPOptionTagOS) && [GPDevice os])
        [GrowthPush setTag:@"OS" value:[GPDevice os]];
    if ((option & EGPOptionTagLanguage) && [GPDevice language])
        [GrowthPush setTag:@"Language" value:[GPDevice language]];
    if ((option & EGPOptionTagTimeZone) && [GPDevice timeZone])
        [GrowthPush setTag:@"Time Zone" value:[GPDevice timeZone]];
    if ((option & EGPOptionTagVersion) && [GPDevice version])
        [GrowthPush setTag:@"Version" value:[GPDevice version]];
    if ((option & EGPOptionTagBuild) && [GPDevice build])
        [GrowthPush setTag:@"Build" value:[GPDevice build]];
    
}

- (void) setApplicationId:(NSInteger)applicationId secret:(NSString *)secret environment:(GPEnvironment)environment debug:(BOOL)debug option:(EGPOption)newOption {
    
    self.option = newOption;
    
    [self setApplicationId:applicationId secret:secret environment:environment debug:debug];
    
}

@end
