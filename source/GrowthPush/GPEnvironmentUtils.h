//
//  GPEnvironmentUtils.h
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/15.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPEnvironment.h"

NSString *NSStringFromGPEnvironment(GPEnvironment environment);
GPEnvironment GPEnvironmentFromNSString(NSString *environmentString);
