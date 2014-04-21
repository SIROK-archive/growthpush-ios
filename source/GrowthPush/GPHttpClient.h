//
//  GPHttpClient.h
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/03.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPHttpRequest.h"
#import "GPHttpResponse.h"

@interface GPHttpClient : NSObject

+ (GPHttpClient *)sharedInstance;
- (void)setBaseUrl:(NSURL *)baseUrl;
- (void)httpRequest:(GPHttpRequest *)httpRequest success:(void(^) (GPHttpResponse * httpResponse)) success fail:(void(^) (GPHttpResponse * httpResponse))fail;

@end
