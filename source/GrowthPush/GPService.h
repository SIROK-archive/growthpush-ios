//
//  GPService.h
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/03.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GrowthbeatCore.h"

@interface GPService : NSObject

- (void)httpRequest:(GBHttpRequest *)httpRequest success:(void(^) (GBHttpResponse * httpResponse)) success fail:(void(^) (GBHttpResponse * httpResponse))fail;

@end
