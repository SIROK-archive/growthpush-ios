//
//  GPEventService.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/07.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GPEventService.h"

static GPEventService *sharedInstance = nil;

@implementation GPEventService

+ (GPEventService *) sharedInstance {

    @synchronized(self) {
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
        }
        return sharedInstance;
    }

}

- (void) createWithClientId:(long long)clientId code:(NSString *)code name:(NSString *)name value:(NSString *)value success:(void (^)(GPEvent *event))success fail:(void (^)(NSInteger status, NSError *error))fail {

    NSString *path = @"/1/events";
    NSMutableDictionary *body = [NSMutableDictionary dictionary];

    if (clientId) {
        [body setObject:@(clientId) forKey:@"clientId"];
    }
    if (code) {
        [body setObject:code forKey:@"code"];
    }
    if (name) {
        [body setObject:name forKey:@"name"];
    }
    if (value) {
        [body setObject:value forKey:@"value"];
    }

    GPHttpRequest *httpRequest = [GPHttpRequest instanceWithRequestMethod:GPRequestMethodPost path:path query:nil body:body];

    [self httpRequest:httpRequest success:^(GPHttpResponse *httpResponse) {
        GPEvent *event = [GPEvent domainWithDictionary:httpResponse.body];
        if (success) {
            success(event);
        }
    } fail:^(GPHttpResponse *httpResponse) {
        if (fail) {
            fail(httpResponse.httpUrlResponse.statusCode, httpResponse.error);
        }
    }];

}

@end
