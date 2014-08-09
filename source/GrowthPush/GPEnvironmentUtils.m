//
//  GPEnvironment.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/15.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GPEnvironment.h"

NSString *NSStringFromGPEnvironment(GPEnvironment environment) {

    switch (environment) {
        case GPEnvironmentDevelopment:
            return @"development";
        case GPEnvironmentProduction:
            return @"production";
        case GPEnvironmentUnknown:
            return nil;
    }

}

GPEnvironment GPEnvironmentFromNSString(NSString *environmentString) {

    if ([environmentString isEqualToString:@"development"]) {
        return GPEnvironmentDevelopment;
    }
    if ([environmentString isEqualToString:@"production"]) {
        return GPEnvironmentProduction;
    }
    return GPEnvironmentUnknown;

}