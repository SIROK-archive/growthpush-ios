//
//  GPHttpResponse.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/03.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GPHttpResponse.h"

@implementation GPHttpResponse

@synthesize urlRequest;
@synthesize httpUrlResponse;
@synthesize error;
@synthesize body;

+ (id) instanceWithUrlRequest:(NSURLRequest *)urlRequest httpUrlResponse:(NSHTTPURLResponse *)httpUrlResponse error:(NSError *)error body:(id)body {

    GPHttpResponse *httpResponse = [[[self alloc] init] autorelease];

    httpResponse.urlRequest = urlRequest;
    httpResponse.httpUrlResponse = httpUrlResponse;
    httpResponse.error = error;
    httpResponse.body = body;

    return httpResponse;

}

- (void) dealloc {

    self.urlRequest = nil;
    self.httpUrlResponse = nil;
    self.error = nil;
    self.body = nil;

    [super dealloc];

}

@end
