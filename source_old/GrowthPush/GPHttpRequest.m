//
//  GPHttpRequest.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/03.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GPHttpRequest.h"
#import "GPUtils.h"

@implementation GPHttpRequest

@synthesize requestMethod;
@synthesize path;
@synthesize query;
@synthesize body;

+ (id) instanceWithRequestMethod:(GPRequestMethod)requestMethod path:(NSString *)path {

    GPHttpRequest *httpRequest = [[[self alloc] init] autorelease];

    httpRequest.requestMethod = requestMethod;
    httpRequest.path = path;

    return httpRequest;

}

+ (id) instanceWithRequestMethod:(GPRequestMethod)requestMethod path:(NSString *)path query:(NSDictionary *)query {

    GPHttpRequest *httpRequest = [self instanceWithRequestMethod:requestMethod path:path];

    httpRequest.query = query;

    return httpRequest;

}

+ (id) instanceWithRequestMethod:(GPRequestMethod)requestMethod path:(NSString *)path query:(NSDictionary *)query body:(NSDictionary *)body {

    GPHttpRequest *httpRequest = [self instanceWithRequestMethod:requestMethod path:path query:query];

    httpRequest.body = body;

    return httpRequest;

}

- (void) dealloc {

    self.path = nil;
    self.query = nil;
    self.body = nil;

    [super dealloc];

}

- (NSURLRequest *) urlRequestWithBaseUrl:(NSURL *)baseUrl {

    NSString *requestPath = path ? path : @"";
    NSMutableDictionary *requestQuery = [NSMutableDictionary dictionaryWithDictionary:query];
    NSMutableDictionary *requestBody = [NSMutableDictionary dictionaryWithDictionary:body];

    if (requestMethod == GPRequestMethodGet) {
        [requestQuery addEntriesFromDictionary:requestBody];
        [requestBody removeAllObjects];
    }

    NSString *requestQueryString = [GPHttpUtils queryStringWithDictionary:requestQuery];
    NSString *requestBodyString = [GPHttpUtils queryStringWithDictionary:requestBody];

    if ([requestQueryString length] > 0) {
        requestPath = [NSString stringWithFormat:@"%@?%@", requestPath, requestQueryString];
    }

    NSURL *url = [NSURL URLWithString:requestPath relativeToURL:baseUrl];
    NSMutableURLRequest *urlRequest = [[[NSMutableURLRequest alloc] initWithURL:url] autorelease];

    [urlRequest setHTTPMethod:NSStringFromGPRequestMethod(requestMethod)];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];

    if (requestMethod != GPRequestMethodGet) {
        NSString *contentTypeString = [NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@", CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding))];
        [urlRequest setValue:contentTypeString forHTTPHeaderField:@"Content-Type"];
        [urlRequest setHTTPBody:[requestBodyString dataUsingEncoding:NSUTF8StringEncoding]];
    }

    return urlRequest;

}

@end
