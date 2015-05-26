//
//  GrowthPush.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/03.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GrowthPush.h"
#import "GPClient.h"
#import "GrowthAnalytics.h"

static GrowthPush *sharedInstance = nil;
static NSString *const kGBLoggerDefaultTag = @"GrowthPush";
static NSString *const kGBHttpClientDefaultBaseUrl = @"https://api.growthpush.com/";
static NSTimeInterval const kGBHttpClientDefaultTimeout = 60;
static NSString *const kGBPreferenceDefaultFileName = @"growthpush-preferences";
static NSString *const kGPPreferenceClientKey = @"client";
static const NSTimeInterval kGPRegisterPollingInterval = 5.0f;

@interface GrowthPush () {

    GBLogger *logger;
    GBHttpClient *httpClient;
    GBPreference *preference;
    
    NSString *applicationId;
    NSString *growthbeatClientId;
    NSString *credentialId;
    GPEnvironment environment;
    BOOL debug;
    NSString *token;
    GBClient *growthbeatClient;
    GPClient *client;
    BOOL registeringClient;

}

@property (nonatomic, strong) GBLogger *logger;
@property (nonatomic, strong) GBHttpClient *httpClient;
@property (nonatomic, strong) GBPreference *preference;

@property (nonatomic, strong) NSString *applicationId;
@property (nonatomic, strong) NSString *credentialId;
@property (nonatomic, assign) GPEnvironment environment;
@property (nonatomic, assign) BOOL debug;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) GBClient *growthbeatClient;
@property (nonatomic, strong) GPClient *client;
@property (nonatomic, assign) BOOL registeringClient;

@end

@implementation GrowthPush

@synthesize logger;
@synthesize httpClient;
@synthesize preference;

@synthesize applicationId;
@synthesize credentialId;
@synthesize environment;
@synthesize debug;
@synthesize token;
@synthesize growthbeatClient;
@synthesize client;
@synthesize registeringClient;

+ (instancetype) sharedInstance {
    @synchronized(self) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 5.0f) {
            return nil;
        }
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
        }
        return sharedInstance;
    }
}

- (id) init {
    self = [super init];
    if (self) {
        self.logger = [[GBLogger alloc] initWithTag:kGBLoggerDefaultTag];
        self.httpClient = [[GBHttpClient alloc] initWithBaseUrl:[NSURL URLWithString:kGBHttpClientDefaultBaseUrl] timeout:kGBHttpClientDefaultTimeout];
        self.preference = [[GBPreference alloc] initWithFileName:kGBPreferenceDefaultFileName];
    }
    return self;
}

- (void)initializeWithApplicationId:(NSString *)newApplicationId credentialId:(NSString *)newCredentialId environment:(GPEnvironment)newEnvironment {
    
    self.applicationId = newApplicationId;
    self.credentialId = newCredentialId;
    self.environment = newEnvironment;
    
    [[GrowthbeatCore sharedInstance] initializeWithApplicationId:applicationId credentialId:credentialId];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        self.growthbeatClient = [[GrowthbeatCore sharedInstance] waitClient];
        self.client = [self loadClient];
        if (self.client && self.client.growthbeatClientId && ![self.client.growthbeatClientId isEqualToString:self.growthbeatClient.id]) {
            [self clearClient];
        }
        [self requestDeviceToken];
    });

}

- (void) requestDeviceToken {
    
    if (![[UIApplication sharedApplication] respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
        return;
    }
    
    UIUserNotificationSettings *userNotificationSettings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:userNotificationSettings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];

}

- (void) setDeviceToken:(NSData *)newDeviceToken {

    self.token = [self convertToHexToken:newDeviceToken];
    [self registerClient];

}

- (void) clearBadge {

    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

}

- (void) registerClient {

    if (registeringClient) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kGPRegisterPollingInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
                [self registerClient];
            });
        return;
    }
    self.registeringClient = YES;

    if (!client) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            
            [logger info:@"Registering client... (applicationId: %d, environment: %@)", applicationId, NSStringFromGPEnvironment(environment)];
            
            GPClient *createdClient = [GPClient createWithClientId:growthbeatClient.id credentialId:credentialId token:token environment:environment];
            if(createdClient) {
                [logger info:@"Registering client success. (clientId: %lld)", createdClient.id];
                [logger info:@"See https://growthpush.com/applications/%d/clients to check the client registration.", applicationId];
                self.client = createdClient;
                [self saveClient:client];
            }
            
            self.registeringClient = NO;
            
        });
        
        return;
        
    }

    if ((token != client.token && ![token isEqualToString:client.token]) || environment != client.environment) {
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            
            [logger info:@"Update client... (id: %d, token: %@, environment: %@)", applicationId, token, NSStringFromGPEnvironment(environment)];
            
            GPClient *updatedClient = [GPClient updateWithClientId:growthbeatClient.id credentialId:credentialId token:token environment:environment];
            if(updatedClient) {
                [logger info:@"Updating client success. (clientId: %lld)", updatedClient.id];
                self.client = updatedClient;
                [self saveClient:client];
            }
            
            self.registeringClient = NO;
            
        });
        
        return;
        
    }

    [logger info:@"Client already registered."];

}

- (GPClient *) loadClient {
    
    return [preference objectForKey:kGPPreferenceClientKey];

}

- (void) saveClient:(GPClient *)newClient {

    [preference setObject:newClient forKey:kGPPreferenceClientKey];

}

- (void) clearClient {

    self.client = nil;
    [preference removeAll];

}

- (NSString *) convertToHexToken:(NSData *)targetDeviceToken {

    if (!targetDeviceToken) {
        return nil;
    }

    const unsigned *tokenBytes = [targetDeviceToken bytes];

    return [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x", ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]), ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]), ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];

}

@end
