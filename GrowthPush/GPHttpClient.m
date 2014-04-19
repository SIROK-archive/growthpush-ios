//
//  GPHttpClient.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/03.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GPHttpClient.h"
#import "GPHTTPOperation.h"

static GPHttpClient *sharedInstance = nil;

@interface GPHttpClient () {

    NSURL *baseUrl;

}

@property (nonatomic, retain) NSURL *baseUrl;

@end

@implementation GPHttpClient

@synthesize baseUrl;

+ (GPHttpClient *) sharedInstance {
    @synchronized(self) {
        if (!sharedInstance)
            sharedInstance = [[self alloc] init];
        return sharedInstance;
    }
}

- (void) dealloc {

    self.baseUrl = nil;

    [super dealloc];

}

- (void) httpRequest:(GPHttpRequest *)httpRequest success:(void (^)(GPHttpResponse *httpResponse))success fail:(void (^)(GPHttpResponse *httpResponse))fail {

    [[NSOperationQueue mainQueue] addOperation:[GPHTTPOperation instanceWithRequest:[httpRequest urlRequestWithBaseUrl:baseUrl] success:success fail:fail]];

}

@end
