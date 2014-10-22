//
//  GrowthPushSampleTests.m
//  GrowthPushSampleTests
//
//  Created by Kataoka Naoyuki on 2014/04/22.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import "GrowthPushTestCase.h"

static NSString *const kGPPreferenceFileName = @"growthpush-preferences";

@implementation GrowthPushTestCase

+ (GPClient *) client {
    return [[GrowthPush sharedInstance] client];
}

+ (void) initializeAll {

    [self initializePreference];
    [self initializeGrowthPush];

}

+ (void) initializePreference {

    NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask];
    NSURL *fileUrl = [NSURL URLWithString:kGPPreferenceFileName relativeToURL:[urls lastObject]];

    [[NSFileManager defaultManager] removeItemAtURL:fileUrl error:nil];

}

+ (void) initializeGrowthPush {

    [[GrowthPush sharedInstance] setClient:nil];
    [[GrowthPush sharedInstance] setTags:nil];

}

+ (void) waitOperation {
    [self waitOperation:30];
}

+ (void) waitOperation:(NSInteger)second {

    for (int i = 0; i < second; i++) {
        if ([[[NSOperationQueue mainQueue] operations] count] == 0) {
            return;
        }
        [self sleep:1];
    }

    [[NSException exceptionWithName:@"TimeoutException" reason:@"Waiting operation timeout." userInfo:nil] raise];

}

+ (void) waitClient {
    [self waitClient:30];
    [self sleep:0.01f];
}

+ (void) waitClient:(NSInteger)second {

    for (int i = 0; i < second; i++) {
        if ([self client]) {
            return;
        }
        [self sleep:1];
    }

    [[NSException exceptionWithName:@"TimeoutException" reason:@"Waiting client timeout." userInfo:nil] raise];

}

+ (void) sleep:(NSTimeInterval)second {

    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:second]];

}

@end
