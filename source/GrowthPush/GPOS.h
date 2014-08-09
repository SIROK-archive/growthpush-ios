//
//  GPOS.h
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/15.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, GPOS) {
    GPOSUnknown = 0,
    GPOSIos,
    GPOSAndroid,
};

NSString *NSStringFromGPOS(GPOS os);
GPOS GPOSFromNSString(NSString *osString);
