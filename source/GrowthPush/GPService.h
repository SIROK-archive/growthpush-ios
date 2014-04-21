//
//  GPService.h
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/03.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPHttpClient.h"

@interface GPService : NSObject

- (void)httpRequest:(GPHttpRequest *)httpRequest success:(void(^) (GPHttpResponse * httpResponse)) success fail:(void(^) (GPHttpResponse * httpResponse))fail;

@end
