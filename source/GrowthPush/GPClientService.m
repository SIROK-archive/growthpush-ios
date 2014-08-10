//
//  GPClientService.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/03.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GPClientService.h"

static GPClientService *sharedInstance = nil;

@implementation GPClientService

+ (GPClientService *) sharedInstance {

    @synchronized(self) {
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
        }
        return sharedInstance;
    }

}

- (void) createWithApplicationId:(NSString *)applicationId credentialId:(NSString *)credentialId token:(NSString *)token environment:(GPEnvironment)environment success:(void (^)(GPClient *client))success fail:(void (^)(NSInteger status, NSError *error))fail {

    NSString *path = @"/1/clients";
    NSMutableDictionary *body = [NSMutableDictionary dictionary];

    if (applicationId) {
        [body setObject:applicationId forKey:@"applicationId"];
    }
    if (credentialId) {
        [body setObject:credentialId forKey:@"credentialId"];
    }
    if (token) {
        [body setObject:token forKey:@"token"];
    }
    if (NSStringFromGPOS(GPOSIos)) {
        [body setObject:NSStringFromGPOS(GPOSIos) forKey:@"os"];
    }
    if (NSStringFromGPEnvironment(environment)) {
        [body setObject:NSStringFromGPEnvironment(environment) forKey:@"environment"];
    }
    
    GBHttpRequest *httpRequest = [GBHttpRequest instanceWithMethod:GBRequestMethodPost path:path query:nil body:body];

    [self httpRequest:httpRequest success:^(GBHttpResponse *httpResponse) {
        GPClient *client = [GPClient domainWithDictionary:httpResponse.body];
        if (success) {
            success(client);
        }
    } fail:^(GBHttpResponse *httpResponse) {
        if (fail) {
            fail(httpResponse.httpUrlResponse.statusCode, httpResponse.error);
        }
    }];

}

- (void) updateWithId:(long long)id code:(NSString *)code token:(NSString *)token environment:(GPEnvironment)environment success:(void (^)(GPClient *client))success fail:(void (^)(NSInteger status, NSError *error))fail {

    NSString *path = [NSString stringWithFormat:@"/1/clients/%lld", id];
    NSMutableDictionary *body = [NSMutableDictionary dictionary];

    if (code) {
        [body setObject:code forKey:@"code"];
    }
    if (token) {
        [body setObject:token forKey:@"token"];
    }
    if (NSStringFromGPEnvironment(environment)) {
        [body setObject:NSStringFromGPEnvironment(environment) forKey:@"environment"];
    }

    GBHttpRequest *httpRequest = [GBHttpRequest instanceWithMethod:GBRequestMethodPut path:path query:nil body:body];

    [self httpRequest:httpRequest success:^(GBHttpResponse *httpResponse) {
        GPClient *client = [GPClient domainWithDictionary:httpResponse.body];
        if (success) {
            success(client);
        }
    } fail:^(GBHttpResponse *httpResponse) {
        if (fail) {
            fail(httpResponse.httpUrlResponse.statusCode, httpResponse.error);
        }
    }];

}

@end
