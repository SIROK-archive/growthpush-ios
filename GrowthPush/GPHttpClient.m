//
//  GPHttpClient.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/03.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GPHttpClient.h"

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
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURLRequest *urlRequest = [httpRequest urlRequestWithBaseUrl:baseUrl];
        NSHTTPURLResponse *urlResponse = nil;
        NSError *error = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&urlResponse error:&error];
        
        if (error) {
            GPHttpResponse *httpResponse = [GPHttpResponse instanceWithUrlRequest:urlRequest httpUrlResponse:urlResponse error:error body:nil];
            if (fail) {
                fail(httpResponse);
            }
            return;
        }
        
        id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (urlResponse.statusCode >= 200 && urlResponse.statusCode < 300) {
                if (success)
                    success([GPHttpResponse instanceWithUrlRequest:urlRequest httpUrlResponse:urlResponse error:nil body:body]);
            } else {
                if (fail)
                    fail([GPHttpResponse instanceWithUrlRequest:urlRequest httpUrlResponse:urlResponse error:error body:body]);
            }
        });
        
    });
    
}

@end
