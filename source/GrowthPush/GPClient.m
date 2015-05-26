//
//  GPClient.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/03.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GPClient.h"
#import "GBUtils.h"
#import "GBHttpClient.h"
#import "GrowthPush.h"

@implementation GPClient

@synthesize id;
@synthesize growthbeatClientId;
@synthesize applicationId;
@synthesize code;
@synthesize token;
@synthesize os;
@synthesize environment;
@synthesize created;

+ (GPClient *) createWithClientId:(NSString *)clientId credentialId:(NSString *)credentialId token:(NSString *)token environment:(GPEnvironment)environment {
    
    NSString *path = @"/3/clients";
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    
    if (clientId) {
        [body setObject:clientId forKey:@"clientId"];
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
    GBHttpResponse *httpResponse = [[[GrowthPush sharedInstance] httpClient] httpRequest:httpRequest];
    if(!httpResponse.success){
        [[[GrowthPush sharedInstance] logger] error:@"Filed to create client. %@", httpResponse.error];
        return nil;
    }
    
    return [GPClient domainWithDictionary:httpResponse.body];
    
}

+ (GPClient *) updateWithClientId:(NSString *)clientId credentialId:(NSString *)credentialId token:(NSString *)token environment:(GPEnvironment)environment {
    
    NSString *path = [NSString stringWithFormat:@"/3/clients/%@", clientId];
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    
    if (credentialId) {
        [body setObject:credentialId forKey:@"credentialId"];
    }
    if (token) {
        [body setObject:token forKey:@"token"];
    }
    if (NSStringFromGPEnvironment(environment)) {
        [body setObject:NSStringFromGPEnvironment(environment) forKey:@"environment"];
    }
    
    GBHttpRequest *httpRequest = [GBHttpRequest instanceWithMethod:GBRequestMethodPut path:path query:nil body:body];
    GBHttpResponse *httpResponse = [[[GrowthPush sharedInstance] httpClient] httpRequest:httpRequest];
    if(!httpResponse.success){
        [[[GrowthPush sharedInstance] logger] error:@"Filed to update client. %@", httpResponse.error];
        return nil;
    }
    
    return [GPClient domainWithDictionary:httpResponse.body];

}

- (id) initWithDictionary:(NSDictionary *)dictionary {

    self = [super init];
    if (self) {
        if ([dictionary objectForKey:@"id"] && [dictionary objectForKey:@"id"] != [NSNull null]) {
            self.id = [[dictionary objectForKey:@"id"] longLongValue];
        }
        if ([dictionary objectForKey:@"growthbeatClientId"] && [dictionary objectForKey:@"growthbeatClientId"] != [NSNull null]) {
            self.growthbeatClientId = [dictionary objectForKey:@"growthbeatClientId"];
        }
        if ([dictionary objectForKey:@"applicationId"] && [dictionary objectForKey:@"applicationId"] != [NSNull null]) {
            self.applicationId = [[dictionary objectForKey:@"applicationId"] integerValue];
        }
        if ([dictionary objectForKey:@"code"] && [dictionary objectForKey:@"code"] != [NSNull null]) {
            self.code = [dictionary objectForKey:@"code"];
        }
        if ([dictionary objectForKey:@"token"] && [dictionary objectForKey:@"token"] != [NSNull null]) {
            self.token = [dictionary objectForKey:@"token"];
        }
        if ([dictionary objectForKey:@"os"] && [dictionary objectForKey:@"os"] != [NSNull null]) {
            self.os = GPOSFromNSString([dictionary objectForKey:@"os"]);
        }
        if ([dictionary objectForKey:@"environment"] && [dictionary objectForKey:@"environment"] != [NSNull null]) {
            self.environment = GPEnvironmentFromNSString([dictionary objectForKey:@"environment"]);
        }
        if ([dictionary objectForKey:@"created"] && [dictionary objectForKey:@"created"] != [NSNull null]) {
            // TODO fix time difference
            self.created = [GBDateUtils dateWithString:[dictionary objectForKey:@"created"] format:@"yyyy-MM-dd HH:mm:ss"];
        }
    }
    return self;

}

- (id) initWithCoder:(NSCoder *)aDecoder {

    self = [super init];
    if (self) {
        if ([aDecoder containsValueForKey:@"id"]) {
            self.id = [[aDecoder decodeObjectForKey:@"id"] longLongValue];
        }
        if ([aDecoder containsValueForKey:@"growthbeatClientId"]) {
            self.growthbeatClientId = [aDecoder decodeObjectForKey:@"growthbeatClientId"];
        }
        if ([aDecoder containsValueForKey:@"applicationId"]) {
            self.applicationId = [aDecoder decodeIntegerForKey:@"applicationId"];
        }
        if ([aDecoder containsValueForKey:@"code"]) {
            self.code = [aDecoder decodeObjectForKey:@"code"];
        }
        if ([aDecoder containsValueForKey:@"token"]) {
            self.token = [aDecoder decodeObjectForKey:@"token"];
        }
        if ([aDecoder containsValueForKey:@"os"]) {
            self.os = GPOSFromNSString([aDecoder decodeObjectForKey:@"os"]);
        }
        if ([aDecoder containsValueForKey:@"environment"]) {
            self.environment = GPEnvironmentFromNSString([aDecoder decodeObjectForKey:@"environment"]);
        }
        if ([aDecoder containsValueForKey:@"created"]) {
            self.created = [aDecoder decodeObjectForKey:@"created"];
        }
    }
    return self;

}


- (void) encodeWithCoder:(NSCoder *)aCoder {

    [aCoder encodeObject:@(id) forKey:@"id"];
    [aCoder encodeObject:growthbeatClientId forKey:@"growthbeatClientId"];
    [aCoder encodeInteger:applicationId forKey:@"applicationId"];
    [aCoder encodeObject:code forKey:@"code"];
    [aCoder encodeObject:token forKey:@"token"];
    [aCoder encodeObject:NSStringFromGPOS(os) forKey:@"os"];
    [aCoder encodeObject:NSStringFromGPEnvironment(environment) forKey:@"environment"];
    [aCoder encodeObject:created forKey:@"created"];

}


@end
