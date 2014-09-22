//
//  GPHTTPOperation.m
//  GrowthPush
//
//  Created by Daiki Asahi on 2014/04/10.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import "GPHTTPOperation.h"

@interface GPHTTPOperation () {

    NSURLRequest *request;

    NSMutableData *receiveData;

    NSHTTPURLResponse *receiveResponse;

    void (^success)(GPHttpResponse *);

    void (^fail)(GPHttpResponse *);

}

@property (nonatomic, retain) NSURLRequest *request;
@property (nonatomic, retain) NSMutableData *receiveData;
@property (nonatomic, retain) NSHTTPURLResponse *receiveResponse;
@property (nonatomic, copy) void (^success)(GPHttpResponse *);
@property (nonatomic, copy) void (^fail)(GPHttpResponse *);

@end

@implementation GPHTTPOperation

@synthesize request;
@synthesize receiveData;
@synthesize receiveResponse;
@synthesize success;
@synthesize fail;

+ (instancetype) instanceWithRequest:(NSURLRequest *)request success:(void (^)(GPHttpResponse *))success fail:(void (^)(GPHttpResponse *httpResponse))fail {

    GPHTTPOperation *operation = [[[self alloc] init] autorelease];

    operation.request = request;
    operation.success = success;
    operation.fail = fail;

    return operation;

}

- (instancetype) init {

    self = [super init];
    if (self) {
        self.receiveData = [NSMutableData data];
    }
    return self;

}

- (void) dealloc {

    self.request = nil;
    self.receiveData = nil;
    self.receiveResponse = nil;

    self.success = nil;
    self.fail = nil;

    [super dealloc];

}

- (void) main {

    [[[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES] autorelease];

}

#pragma mark -
#pragma mark NSURLConnectionDataDelegate

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {

    self.receiveResponse = (NSHTTPURLResponse *)response;
    [receiveData setLength:0];

}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {

    [receiveData appendData:data];

}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {

    NSData *data = self.receiveData;
    NSHTTPURLResponse *response = self.receiveResponse;

    id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

    if (response.statusCode >= 200 && response.statusCode < 300) {
        if (success) {
            success([GPHttpResponse instanceWithUrlRequest:request httpUrlResponse:response error:nil body:body]);
        }
    } else {
        if (fail) {
            fail([GPHttpResponse instanceWithUrlRequest:request httpUrlResponse:response error:nil body:body]);
        }
    }

}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {

    if (fail) {
        fail([GPHttpResponse instanceWithUrlRequest:self.request httpUrlResponse:self.receiveResponse error:error body:nil]);
    }

}

@end
