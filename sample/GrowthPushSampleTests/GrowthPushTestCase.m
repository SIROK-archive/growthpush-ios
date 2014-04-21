//
//  GrowthPushSampleTests.m
//  GrowthPushSampleTests
//
//  Created by Kataoka Naoyuki on 2014/04/22.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import "GrowthPushTestCase.h"

static NSString *const kGPPreferenceFileName = @"growthpush-preferences";

@interface GPClient

@end

@interface GPPreference : NSObject

+ (GPPreference *)sharedInstance;

@end

@implementation GrowthPushTestCase

+ (GrowthPush *)growthPush {
    return [[GrowthPush class] performSelector:@selector(sharedInstance)];
}

+ (GPClient *)client {
    return [[self growthPush] performSelector:@selector(client)];
}

+ (void)initialize {
    
    [self initializePreference];
    [self initializeGrowthPush];
    
}

+ (void)initializePreference {
    
    NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask];
    NSURL *fileUrl = [NSURL URLWithString:kGPPreferenceFileName relativeToURL:[urls lastObject]];
    [[NSFileManager defaultManager] removeItemAtURL:fileUrl error:nil];
    
}

+ (void)initializeGrowthPush {
    
    [[self growthPush] performSelector:@selector(setClient:) withObject:nil];
    [[self growthPush] performSelector:@selector(setTags:) withObject:nil];
    
}

+ (void)waitOperation:(NSInteger)second {
    
    for (int i = 0; i < second; i++) {
        if ([[[NSOperationQueue mainQueue] operations] count] == 0)
            return;
        [self sleep:1];
    }
    
    [[NSException exceptionWithName:@"TimeoutException" reason:@"Waiting client timeout." userInfo:nil] raise];
    
}

+ (void)waitClient:(NSInteger)second {
    
    for (int i = 0; i < second; i++) {
        if ([self client])
            return;
        [self sleep:1];
    }
    
    [[NSException exceptionWithName:@"TimeoutException" reason:@"Waiting client timeout." userInfo:nil] raise];
    
}

+ (void)sleep:(NSTimeInterval)second {
    
    NSDate *begin = [NSDate date];
    
    while ([[NSDate date] timeIntervalSinceDate:begin] < second) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01f]];
    }
    
}

@end
