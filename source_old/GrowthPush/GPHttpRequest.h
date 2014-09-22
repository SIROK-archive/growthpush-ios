//
//  GPHttpRequest.h
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/03.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPRequestMethod.h"

@interface GPHttpRequest : NSObject {

    GPRequestMethod requestMethod;
    NSString *path;
    NSDictionary *query;
    NSDictionary *body;

}

@property (nonatomic, assign) GPRequestMethod requestMethod;
@property (nonatomic, retain) NSString *path;
@property (nonatomic, retain) NSDictionary *query;
@property (nonatomic, retain) NSDictionary *body;

+ (id)instanceWithRequestMethod:(GPRequestMethod)requestMethod path:(NSString *)path;
+ (id)instanceWithRequestMethod:(GPRequestMethod)requestMethod path:(NSString *)path query:(NSDictionary *)query;
+ (id)instanceWithRequestMethod:(GPRequestMethod)requestMethod path:(NSString *)path query:(NSDictionary *)query body:(NSDictionary *)body;

- (NSURLRequest *)urlRequestWithBaseUrl:(NSURL *)baseUrl;

@end
