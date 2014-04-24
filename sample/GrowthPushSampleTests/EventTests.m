//
//  EventTests.m
//  GrowthPushSample
//
//  Created by Kataoka Naoyuki on 2014/04/22.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import "EventTests.h"

@implementation EventTests

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

- (void) testTrackEvent {

    [GrowthPush trackEvent:@"Launch"];

}

- (void) testTrackEventWithInvalidName {

    [GrowthPush trackEvent:nil];

}

- (void) testTrackEventWithValue {

    [GrowthPush trackEvent:@"Payment" value:@"500"];

}

@end
