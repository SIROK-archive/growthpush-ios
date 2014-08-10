//
//  GPTagService.h
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/08.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GPService.h"

@interface GPTagService : GPService

+ (GPTagService *)sharedInstance;
- (void)updateWithClientId:(long long)clientId code:(NSString *)code name:(NSString *)name value:(NSString *)value success:(void(^) (void)) success fail:(void(^) (NSInteger status, NSError * error))fail;

@end
