//
//  GPClientService.h
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/03.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GPService.h"
#import "GPClient.h"
#import "GPEnvironment.h"

@interface GPClientService : GPService

+ (GPClientService *)sharedInstance;
- (void)createWithApplicationId:(NSString *)applicationId credentialId:(NSString *)credentialId token:(NSString *)token environment:(GPEnvironment)environment success:(void(^) (GPClient * client)) success fail:(void(^) (NSInteger status, NSError * error))fail;
- (void)updateWithId:(long long)id code:(NSString *)code token:(NSString *)token environment:(GPEnvironment)environment success:(void(^) (GPClient * client)) success fail:(void(^) (NSInteger status, NSError * error))fail;

@end
