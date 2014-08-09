//
//  GPOS.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/15.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GPOS.h"

NSString *NSStringFromGPOS(GPOS os) {

    switch (os) {
        case GPOSIos:
            return @"ios";
        case GPOSAndroid:
            return @"android";
        case GPOSUnknown:
            return nil;
    }

}

GPOS GPOSFromNSString(NSString *osString) {

    if ([osString isEqualToString:@"ios"]) {
        return GPOSIos;
    }
    if ([osString isEqualToString:@"android"]) {
        return GPOSAndroid;
    }
    return GPOSUnknown;

}