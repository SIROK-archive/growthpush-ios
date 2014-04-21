//
//  GPDevice.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/14.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GPDevice.h"

@implementation GPDevice

+ (NSString *) device {

    return [[UIDevice currentDevice] model];

}

+ (NSString *) os {

    NSString *version = [[UIDevice currentDevice] systemVersion];

    if (!version || [version length] == 0)
        return nil;

    return [NSString stringWithFormat:@"iOS %@", version];

}

+ (NSString *) language {

    NSArray *languages = [NSLocale preferredLanguages];

    if (!languages || [languages count] == 0)
        return nil;

    return [languages objectAtIndex:0];

}

+ (NSString *) timeZone {

    return [[NSTimeZone systemTimeZone] name];

}

+ (NSString *) version {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *) build {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

@end
