//
//  GPHttpClient.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/03.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GPHttpClient.h"
#import "AFNetworking.h"

static GPHttpClient *sharedInstance = nil;

@interface GPHttpClient () {

    AFHTTPClient *httpClient;
    NSURL *baseUrl;

}

@property (nonatomic, retain) AFHTTPClient *httpClient;
@property (nonatomic, retain) NSURL *baseUrl;

@end

@implementation GPHttpClient

@synthesize httpClient;
@synthesize baseUrl;

+ (GPHttpClient *) sharedInstance {
    @synchronized(self) {
        if (!sharedInstance)
            sharedInstance = [[self alloc] init];
        return sharedInstance;
    }
}

- (void) dealloc {

    self.httpClient = nil;
    self.baseUrl = nil;

    [super dealloc];

}

- (void) httpRequest:(GPHttpRequest *)httpRequest success:(void (^)(GPHttpResponse *httpResponse))success fail:(void (^)(GPHttpResponse *httpResponse))fail {

    NSURLRequest *urlRequest = [httpRequest urlRequestWithBaseUrl:baseUrl];

    AFJSONRequestOperation *requestOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:urlRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            if (success)
                success([GPHttpResponse instanceWithUrlRequest:urlRequest httpUrlResponse:response error:nil body:JSON]);
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            if (fail)
                fail([GPHttpResponse instanceWithUrlRequest:urlRequest httpUrlResponse:response error:error body:JSON]);
        }];

    [requestOperation start];

}

@end
