//
//  GPTagService.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/08.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GPTagService.h"

static GPTagService *sharedInstance = nil;

@implementation GPTagService

+ (GPTagService *) sharedInstance {
    @synchronized(self) {
        if (!sharedInstance)
            sharedInstance = [[self alloc] init];
        return sharedInstance;
    }
}

- (void) updateWithClientId:(long long)clientId code:(NSString *)code name:(NSString *)name value:(NSString *)value success:(void (^)(void))success fail:(void (^)(NSInteger status, NSError *error))fail {

    NSString *path = @"/1/tags";
    NSMutableDictionary *body = [NSMutableDictionary dictionary];

    if (clientId)
        [body setObject:@(clientId) forKey:@"clientId"];
    if (code)
        [body setObject:code forKey:@"code"];
    if (name)
        [body setObject:name forKey:@"name"];
    if (value)
        [body setObject:value forKey:@"value"];

    GPHttpRequest *httpRequest = [GPHttpRequest instanceWithRequestMethod:GPRequestMethodPost path:path query:nil body:body];

    [self httpRequest:httpRequest success:^(GPHttpResponse *httpResponse) {
        if (success)
            success();
    } fail:^(GPHttpResponse *httpResponse) {
        if (fail)
            fail(httpResponse.httpUrlResponse.statusCode, httpResponse.error);
    }];

}

@end
