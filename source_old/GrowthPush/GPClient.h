//
//  GPClient.h
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/03.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GPDomain.h"
#import "GPOS.h"
#import "GPEnvironment.h"

@interface GPClient : GPDomain <NSCoding> {

    long long id;
    NSInteger applicationId;
    NSString *code;
    NSString *token;
    GPOS os;
    GPEnvironment environment;
    NSDate *created;

}

@property (nonatomic, assign) long long id;
@property (nonatomic, assign) NSInteger applicationId;
@property (nonatomic, retain) NSString *code;
@property (nonatomic, retain) NSString *token;
@property (nonatomic, assign) GPOS os;
@property (nonatomic, assign) GPEnvironment environment;
@property (nonatomic, retain) NSDate *created;

@end
