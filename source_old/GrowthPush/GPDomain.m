//
//  GPDomain.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/03.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GPDomain.h"

@implementation GPDomain

+ (id) domainWithDictionary:(NSDictionary *)dictionary {

    if (!dictionary) {
        return nil;
    }

    return [[[self alloc] initWithDictionary:dictionary] autorelease];

}

- (id) initWithDictionary:(NSDictionary *)dictionary {
    return [self init];
}

@end
