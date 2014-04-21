//
//  GPEvent.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/07.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GPEvent.h"

@implementation GPEvent

@synthesize goalId;
@synthesize timestamp;
@synthesize clientId;
@synthesize value;

- (id) initWithDictionary:(NSDictionary *)dictionary {

    self = [super init];
    if (self) {
        if ([dictionary objectForKey:@"goalId"] && [dictionary objectForKey:@"goalId"] != [NSNull null])
            self.goalId = [[dictionary objectForKey:@"goalId"] integerValue];
        if ([dictionary objectForKey:@"timestamp"] && [dictionary objectForKey:@"timestamp"] != [NSNull null])
            self.timestamp = [[dictionary objectForKey:@"timestamp"] longLongValue];
        if ([dictionary objectForKey:@"clientId"] && [dictionary objectForKey:@"clientId"] != [NSNull null])
            self.clientId = [[dictionary objectForKey:@"clientId"] longLongValue];
        if ([dictionary objectForKey:@"value"] && [dictionary objectForKey:@"value"] != [NSNull null])
            self.value = [dictionary objectForKey:@"value"];
    }
    return self;

}

- (void) dealloc {

    self.value = nil;

    [super dealloc];

}

@end
