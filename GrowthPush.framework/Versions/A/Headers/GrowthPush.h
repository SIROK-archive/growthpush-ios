//
//  GrowthPush.h
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/03.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GrowthbeatCore.h"
#import "GPEnvironment.h"

#ifdef DEBUG
#define kGrowthPushEnvironment (GPEnvironmentDevelopment)
#else
#define kGrowthPushEnvironment (GPEnvironmentProduction)
#endif

@interface GrowthPush : NSObject

/**
 * Get shared instance of GrowthPush
 *
 */
+ (instancetype) sharedInstance;

/**
 * Initialize GrowthPush instance and register the client device if not yet been registered
 *
 * @param applicationId Application ID
 * @param credentialId Credential ID for application
 * @param environment Build configuration (debug or release)
 */
- (void)initializeWithApplicationId:(NSString *)applicationId credentialId:(NSString *)credentialId environment:(GPEnvironment)environment;

/**
 * Request APNS device token.
 * Internally call UIApplication's registerForRemoteNotificationTypes:
 */
- (void)requestDeviceToken;

/**
 * Set device token obtained in AppDelegate's application:didRegisterForRemoteNotificationsWithDeviceToken:
 *
 * @param deviceToken Device token
 */
- (void)setDeviceToken:(NSData *)deviceToken;

/**
 * Clear badge of app icon
 */
- (void)clearBadge;

- (GBLogger *)logger;
- (GBHttpClient *)httpClient;
- (GBPreference *)preference;

@end
