//
//  GPDevice.h
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/14.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPDevice : NSObject

+ (NSString *)device;
+ (NSString *)os;
+ (NSString *)language;
+ (NSString *)timeZone;
+ (NSString *)version;
+ (NSString *)build;

@end
