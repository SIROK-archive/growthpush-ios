//
//  TagTests.m
//  GrowthPushSample
//
//  Created by Kataoka Naoyuki on 2014/04/22.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import "TagTests.h"

@implementation TagTests

+ (void) setUp {

    [super setUp];

    [self initialize];

    [EasyGrowthPush setApplicationId:kApplicationId secret:kApplicationSecret environment:GPEnvironmentDevelopment debug:YES];

    [self waitClient:30];

}

- (void) setUp {

    [super setUp];

    [[self class] waitOperation:30];

}

+ (void) tearDown {

    [super tearDown];

}

- (void) testSetDeviceTags {

    [GrowthPush setDeviceTags];

}

- (void) testSetTag {

    [GrowthPush setTag:@"Payed User"];

}

- (void) testSetTagWithInvalidName {

    [GrowthPush setTag:nil];

}

- (void) testSetTagWithValue {

    [GrowthPush setTag:@"Gender" value:@"male"];

}

@end
