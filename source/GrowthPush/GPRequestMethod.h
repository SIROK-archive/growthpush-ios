//
//  GPRequestMethod.h
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/03.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, GPRequestMethod) {
    GPRequestMethodUnknown = 0,
    GPRequestMethodGet,
    GPRequestMethodPost,
    GPRequestMethodPut,
    GPRequestMethodDelete
};

NSString *NSStringFromGPRequestMethod(GPRequestMethod requestMethod);
GPRequestMethod GPRequestMethodFromNSString(NSString *requestMethodString);
