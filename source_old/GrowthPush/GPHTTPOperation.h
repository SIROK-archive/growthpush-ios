//
//  GPHTTPOperation.h
//  GrowthPush
//
//  Created by Daiki Asahi on 2014/04/10.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPHttpResponse.h"

@interface GPHTTPOperation : NSOperation <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

+ (instancetype)instanceWithRequest:(NSURLRequest *)request success:(void(^) (GPHttpResponse *)) success fail:(void(^) (GPHttpResponse * httpResponse))fail;

@end
