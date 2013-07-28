//
//  GPAppDelegateWrapperDelegate.h
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/14.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GPAppDelegateWrapperDelegate <NSObject>

@optional

- (void)willPerformApplicationDidBecomeActive:(UIApplication *)application;
- (void)didPerformApplicationDidBecomeActive:(UIApplication *)application;
- (void)willPerformApplicationWillResignActive:(UIApplication *)application;
- (void)didPerformApplicationWillResignActive:(UIApplication *)application;
- (void)willPerformApplication:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void)didPerformApplication:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void)willPerformApplication:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;
- (void)didPerformApplication:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;
- (void)willPerformApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;
- (void)didPerformApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;
- (void)willPerformApplication:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;
- (void)didPerformApplication:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;
- (void)willPerformApplicationDidEnterBackground:(UIApplication *)application;
- (void)didPerformApplicationDidEnterBackground:(UIApplication *)application;
- (void)willPerformApplicationWillEnterForeground:(UIApplication *)application;
- (void)didPerformApplicationWillEnterForeground:(UIApplication *)application;

@end
