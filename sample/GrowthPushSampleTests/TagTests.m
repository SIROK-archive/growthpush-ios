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

    [self waitClient];

}

+ (void) tearDown {
    [super tearDown];
}

- (void) setUp {

    [super setUp];

    [[self class] waitOperation];

}

- (void) tearDown {

    [super tearDown];

}

- (void) testSetDeviceTags {
    NSUInteger tagsCount = [[[GrowthPush sharedInstance] tags] count];

    [GrowthPush setDeviceTags];
    [[self class] waitOperation];
    XCTAssertEqual([[[GrowthPush sharedInstance] tags] count], tagsCount + 6);
    XCTAssertNotNil([[[GrowthPush sharedInstance] tags] objectForKey:@"OS"]);
    XCTAssertNotNil([[[GrowthPush sharedInstance] tags] objectForKey:@"Version"]);
    XCTAssertNotNil([[[GrowthPush sharedInstance] tags] objectForKey:@"Language"]);
    XCTAssertNotNil([[[GrowthPush sharedInstance] tags] objectForKey:@"Time Zone"]);
    XCTAssertNotNil([[[GrowthPush sharedInstance] tags] objectForKey:@"Device"]);
    XCTAssertNotNil([[[GrowthPush sharedInstance] tags] objectForKey:@"Build"]);
}

- (void) testSetTag {
    XCTAssertNil([[[GrowthPush sharedInstance] tags] objectForKey:@"Payed User"]);
    [GrowthPush setTag:@"Payed User"];
    [[self class] waitOperation];
    XCTAssertNotNil([[[GrowthPush sharedInstance] tags] objectForKey:@"Payed User"]);
}

- (void) testSetTagWithInvalidName {
    NSUInteger tagsCount = [[[GrowthPush sharedInstance] tags] count];

    [GrowthPush setTag:nil];
    [[self class] waitOperation];
    XCTAssertEqual([[[GrowthPush sharedInstance] tags] count], tagsCount);

}

- (void) testSetTagWithValue {
    XCTAssertNil([[[GrowthPush sharedInstance] tags] objectForKey:@"Gender"]);
    [GrowthPush setTag:@"Gender" value:@"male"];
    [[self class] waitOperation];
    XCTAssertNotNil([[[GrowthPush sharedInstance] tags] objectForKey:@"Gender"]);
}

@end
