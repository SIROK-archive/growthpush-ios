//
//  GPHttpUtils.h
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/03.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPHttpUtils : NSObject

+ (NSString *)queryStringWithDictionary:(NSDictionary *)params;

@end
