//
//  GPEvent.h
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/07.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GPDomain.h"

@interface GPEvent : GPDomain {

    NSInteger goalId;
    long long timestamp;
    long long clientId;
    NSString *value;

}

@property (nonatomic, assign) NSInteger goalId;
@property (nonatomic, assign) long long timestamp;
@property (nonatomic, assign) long long clientId;
@property (nonatomic, strong) NSString *value;

@end
