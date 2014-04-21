//
//  GPEventService.h
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/07.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GPService.h"
#import "GPEvent.h"

@interface GPEventService : GPService

+ (GPEventService *)sharedInstance;
- (void)createWithClientId:(long long)clientId code:(NSString *)code name:(NSString *)name value:(NSString *)value success:(void(^) (GPEvent * event)) success fail:(void(^) (NSInteger status, NSError * error))fail;

@end
