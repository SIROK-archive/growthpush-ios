//
//  GPEnvironment.h
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/15.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, GPEnvironment) {
    GPEnvironmentUnknown = 0,
    GPEnvironmentDevelopment,
    GPEnvironmentProduction,
};

NSString *NSStringFromGPEnvironment(GPEnvironment environment);
GPEnvironment GPEnvironmentFromNSString(NSString *environmentString);
