//
//  TagTests.h
//  GrowthPushSample
//
//  Created by Kataoka Naoyuki on 2014/04/22.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

static const NSInteger kApplicationId = 1070;
static NSString *const kApplicationSecret = @"BhcrsJHoEvWT85437EnSJ1COUhflEg1E";

@interface GrowthPushTestCase : XCTestCase

+ (void)initialize;
+ (void)waitOperation:(NSInteger)second;
+ (void)waitClient:(NSInteger)second;
+ (void)sleep:(NSTimeInterval)second;

@end