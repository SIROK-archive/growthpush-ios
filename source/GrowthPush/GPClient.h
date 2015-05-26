//
//  GPClient.h
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/03.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GBDomain.h"
#import "GPOS.h"
#import "GPEnvironment.h"

@interface GPClient : GBDomain <NSCoding> {

    long long id;
    NSString *growthbeatClientId;
    NSInteger applicationId;
    NSString *code;
    NSString *token;
    GPOS os;
    GPEnvironment environment;
    NSDate *created;

}

@property (nonatomic, assign) long long id;
@property (nonatomic, strong) NSString *growthbeatClientId;
@property (nonatomic, assign) NSInteger applicationId;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, assign) GPOS os;
@property (nonatomic, assign) GPEnvironment environment;
@property (nonatomic, strong) NSDate *created;

+ (GPClient *) createWithClientId:(NSString *)clientId credentialId:(NSString *)credentialId token:(NSString *)token environment:(GPEnvironment)environment;
+ (GPClient *) updateWithClientId:(NSString *)clientId credentialId:(NSString *)credentialId token:(NSString *)token environment:(GPEnvironment)environment;

@end
