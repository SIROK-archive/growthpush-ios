//
//  GPRequestMethod.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/03.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GPRequestMethod.h"

NSString *NSStringFromGPRequestMethod(GPRequestMethod requestMethod) {

    switch (requestMethod) {
        case GPRequestMethodGet:
            return @"GET";
        case GPRequestMethodPost:
            return @"POST";
        case GPRequestMethodPut:
            return @"PUT";
        case GPRequestMethodDelete:
            return @"DELETE";
        default:
            return nil;
    }

}

GPRequestMethod GPRequestMethodFromNSString(NSString *requestMethodString) {

    if ([requestMethodString isEqualToString:@"GET"])
        return GPRequestMethodGet;
    if ([requestMethodString isEqualToString:@"POST"])
        return GPRequestMethodPost;
    if ([requestMethodString isEqualToString:@"PUT"])
        return GPRequestMethodPut;
    if ([requestMethodString isEqualToString:@"DELETE"])
        return GPRequestMethodDelete;

    return GPRequestMethodUnknown;

}
