//
//  GPService.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/03.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GPService.h"
#import "GrowthPush.h"

@implementation GPService

- (void) httpRequest:(GBHttpRequest *)httpRequest success:(void (^)(GBHttpResponse *httpResponse))success fail:(void (^)(GBHttpResponse *httpResponse))fail {

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        GBHttpResponse *httpResponse = [[[GrowthPush sharedInstance] httpClient] httpRequest:httpRequest];
        if(httpResponse.success) {
            success(httpResponse);
        } else {
            fail(httpResponse);
        }
    });

}

@end
