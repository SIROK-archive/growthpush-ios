//
//  GPPreference.h
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/17.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPPreference : NSObject

+ (GPPreference *)sharedInstance;
- (id)objectForKey:(id <NSCopying>)key;
- (void)setObject:(id)object forKey:(id <NSCopying>)key;
- (void)removeObjectForKey:(id <NSCopying>)key;

@end
