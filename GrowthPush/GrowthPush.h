//
//  GrowthPush.h
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/03.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPEnvironment.h"
#import "EGPOption.h"

#ifdef DEBUG
#define kGrowthPushEnvironment (GPEnvironmentDevelopment)
#else
#define kGrowthPushEnvironment (GPEnvironmentProduction)
#endif

@interface GrowthPush : NSObject

/**
 * Initialize GrowthPush instance and register the client device if not yet been registered
 *
 * @param applicationId Application ID
 * @param secret Secret key for application
 * @param environment Build configuration (debug or release)
 * @param debug Debug mode
 */
+ (void)setApplicationId:(NSInteger)applicationId secret:(NSString *)secret environment:(GPEnvironment)environment debug:(BOOL)debug;

/**
 * Request APNS device token.
 * Internally call UIApplication's registerForRemoteNotificationTypes:
 */
+ (void)requestDeviceToken;

/**
 * Set device token obtained in AppDelegate's application:didRegisterForRemoteNotificationsWithDeviceToken:
 *
 * @param deviceToken Device token
 */
+ (void)setDeviceToken:(NSData *)deviceToken;

/**
 * Track event
 *
 * @param name Event name such as "Launch" (max 64 characters)
 */
+ (void)trackEvent:(NSString *)name;

/**
 * Track event with additional information
 *
 * @param name Event name (max 64 characters)
 * @param value Additional information
 */
+ (void)trackEvent:(NSString *)name value:(NSString *)value;

/**
 * Create a tag for the device
 *
 * @param name Tag name such as "Finished Tutorial" (max 64 characters)
 */
+ (void)setTag:(NSString *)name;

/**
 * Create a tag with value for the device
 *
 * @param name Tag name such as "Gender" (max 64 characters)
 * @param value Tag value such as "male"
 */
+ (void)setTag:(NSString *)name value:(NSString *)value;

/**
 * Create tags including device model, OS version, language, time zone and app version
 */
+ (void)setDeviceTags;

/**
 * Clear badge of app icon
 */
+ (void)clearBadge;

@end

@interface EasyGrowthPush : GrowthPush

/**
 * Initialize GrowthPush instance and register the client device if not yet been registered
 *
 * @param applicationId Application ID
 * @param secret Secret key for application
 * @param environment Build configuration (debug or release)
 * @param debug Debug mode
 * @param option option flags
 */
+ (void) setApplicationId:(NSInteger)applicationId secret:(NSString *)secret environment:(GPEnvironment)environment debug:(BOOL)debug option:(EGPOption)option;

@end
