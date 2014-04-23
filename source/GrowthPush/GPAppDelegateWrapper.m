//
//  GPAppDelegateWrapper.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/14.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GPAppDelegateWrapper.h"

@interface GPAppDelegateWrapper () {

    UIResponder <UIApplicationDelegate> *originalAppDelegate;

}

@property (nonatomic, retain) UIResponder <UIApplicationDelegate> *originalAppDelegate;

@end

@implementation GPAppDelegateWrapper

@synthesize delegate;
@synthesize originalAppDelegate;

- (void) forwardInvocation:(NSInvocation *)invocation {

    if (!originalAppDelegate)
        return;

    [invocation setTarget:originalAppDelegate];
    [invocation invoke];

}

- (NSMethodSignature *) methodSignatureForSelector:(SEL)sel {

    if (originalAppDelegate)
        return [originalAppDelegate methodSignatureForSelector:sel];
    else
        return [super methodSignatureForSelector:sel];

}

- (BOOL) respondsToSelector:(SEL)aSelector {
    
    if([super respondsToSelector:aSelector])
        return YES;
    
    if([originalAppDelegate respondsToSelector:aSelector])
        return YES;
    
    return NO;
    
}


- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    BOOL returnValue = YES;
    
    if ([delegate respondsToSelector:@selector(willPerformApplication:willFinishLaunchingWithOptions:)])
        returnValue = returnValue && [delegate willPerformApplication:application willFinishLaunchingWithOptions:launchOptions];
    
    if ([originalAppDelegate respondsToSelector:@selector(application:willFinishLaunchingWithOptions:)])
        returnValue = returnValue && [originalAppDelegate application:application willFinishLaunchingWithOptions:launchOptions];
    
    if ([delegate respondsToSelector:@selector(didPerformApplication:willFinishLaunchingWithOptions:)])
        returnValue = returnValue && [delegate willPerformApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    return returnValue;
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    BOOL returnValue = YES;
    
    if ([delegate respondsToSelector:@selector(willPerformApplication:didFinishLaunchingWithOptions:)])
        returnValue = returnValue && [delegate willPerformApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    if ([originalAppDelegate respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)])
        returnValue = returnValue && [originalAppDelegate application:application didFinishLaunchingWithOptions:launchOptions];
    
    if ([delegate respondsToSelector:@selector(didPerformApplication:didFinishLaunchingWithOptions:)])
        returnValue = returnValue && [delegate willPerformApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    return returnValue;
    
}

- (void) applicationDidBecomeActive:(UIApplication *)application {

    if ([delegate respondsToSelector:@selector(willPerformApplicationDidBecomeActive:)])
        [delegate willPerformApplicationDidBecomeActive:application];

    if ([originalAppDelegate respondsToSelector:@selector(applicationDidBecomeActive:)])
        [originalAppDelegate applicationDidBecomeActive:application];

    if ([delegate respondsToSelector:@selector(didPerformApplicationDidBecomeActive:)])
        [delegate didPerformApplicationDidBecomeActive:application];

}

- (void) applicationWillResignActive:(UIApplication *)application {

    if ([delegate respondsToSelector:@selector(willPerformApplicationWillResignActive:)])
        [delegate willPerformApplicationWillResignActive:application];

    if ([originalAppDelegate respondsToSelector:@selector(applicationWillResignActive:)])
        [originalAppDelegate applicationWillResignActive:application];

    if ([delegate respondsToSelector:@selector(didPerformApplicationWillResignActive:)])
        [delegate didPerformApplicationWillResignActive:application];

}

- (void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

    if ([delegate respondsToSelector:@selector(willPerformApplication:didRegisterForRemoteNotificationsWithDeviceToken:)])
        [delegate willPerformApplication:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];

    if ([originalAppDelegate respondsToSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)])
        [originalAppDelegate application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];

    if ([delegate respondsToSelector:@selector(didPerformApplication:didRegisterForRemoteNotificationsWithDeviceToken:)])
        [delegate didPerformApplication:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];

}

- (void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {

    if ([delegate respondsToSelector:@selector(willPerformApplication:didFailToRegisterForRemoteNotificationsWithError:)])
        [delegate willPerformApplication:application didFailToRegisterForRemoteNotificationsWithError:error];

    if ([originalAppDelegate respondsToSelector:@selector(application:didFailToRegisterForRemoteNotificationsWithError:)])
        [originalAppDelegate application:application didFailToRegisterForRemoteNotificationsWithError:error];

    if ([delegate respondsToSelector:@selector(didPerformApplication:didFailToRegisterForRemoteNotificationsWithError:)])
        [delegate didPerformApplication:application didFailToRegisterForRemoteNotificationsWithError:error];

}

- (void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

    if ([delegate respondsToSelector:@selector(willPerformApplication:didReceiveRemoteNotification:)])
        [delegate willPerformApplication:application didReceiveRemoteNotification:userInfo];

    if ([originalAppDelegate respondsToSelector:@selector(application:didReceiveRemoteNotification:)])
        [originalAppDelegate application:application didReceiveRemoteNotification:userInfo];

    if ([delegate respondsToSelector:@selector(didPerformApplication:didReceiveRemoteNotification:)])
        [delegate didPerformApplication:application didReceiveRemoteNotification:userInfo];

}

- (void) application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {

    if ([delegate respondsToSelector:@selector(willPerformApplication:didReceiveLocalNotification:)])
        [delegate willPerformApplication:application didReceiveLocalNotification:notification];

    if ([originalAppDelegate respondsToSelector:@selector(application:didReceiveLocalNotification:)])
        [originalAppDelegate application:application didReceiveLocalNotification:notification];

    if ([delegate respondsToSelector:@selector(didPerformApplication:didReceiveLocalNotification:)])
        [delegate didPerformApplication:application didReceiveLocalNotification:notification];

}

- (void) applicationDidEnterBackground:(UIApplication *)application {

    if ([delegate respondsToSelector:@selector(willPerformApplicationDidEnterBackground:)])
        [delegate willPerformApplicationDidEnterBackground:application];

    if ([originalAppDelegate respondsToSelector:@selector(applicationDidEnterBackground:)])
        [originalAppDelegate applicationDidEnterBackground:application];

    if ([delegate respondsToSelector:@selector(didPerformApplicationDidEnterBackground:)])
        [delegate didPerformApplicationDidEnterBackground:application];

}

- (void) applicationWillEnterForeground:(UIApplication *)application {

    if ([delegate respondsToSelector:@selector(willPerformApplicationWillEnterForeground:)])
        [delegate willPerformApplicationWillEnterForeground:application];

    if ([originalAppDelegate respondsToSelector:@selector(applicationWillEnterForeground:)])
        [originalAppDelegate applicationWillEnterForeground:application];

    if ([delegate respondsToSelector:@selector(didPerformApplicationWillEnterForeground:)])
        [delegate didPerformApplicationWillEnterForeground:application];

}

@end
