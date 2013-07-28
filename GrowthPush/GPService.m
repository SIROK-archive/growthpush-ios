//
//  GPService.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/03.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GPService.h"

@implementation GPService

- (void) httpRequest:(GPHttpRequest *)httpRequest success:(void (^)(GPHttpResponse *httpResponse))success fail:(void (^)(GPHttpResponse *httpResponse))fail {

    [[GPHttpClient sharedInstance] httpRequest:httpRequest success:success fail:fail];

}

@end
