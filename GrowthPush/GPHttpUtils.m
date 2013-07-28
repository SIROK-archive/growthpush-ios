//
//  GPHttpUtils.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/03.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GPHttpUtils.h"

@implementation GPHttpUtils

+ (NSString *) queryStringWithDictionary:(NSDictionary *)params {

    NSMutableArray *combinedParams = [NSMutableArray array];

    for (NSString *key in [params keyEnumerator]) {
        NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        id values = [params objectForKey:key];
        if (![values isKindOfClass:[NSArray class]])
            values = [NSArray arrayWithObject:values];
        for (id value in values) {
            NSString *encodedValue = [[NSString stringWithFormat:@"%@", value] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [combinedParams addObject:[NSString stringWithFormat:@"%@=%@", encodedKey, encodedValue]];
        }
    }

    return [combinedParams componentsJoinedByString:@"&"];

}

@end
