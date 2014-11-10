//
//  GrowthPush.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/03.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GrowthPush.h"
#import "GPClientService.h"
#import "GrowthAnalytics.h"

static GrowthPush *sharedInstance = nil;
static NSString *const kGBLoggerDefaultTag = @"GrowthPush";
static NSString *const kGBHttpClientDefaultBaseUrl = @"https://api.growthpush.com/";
static NSString *const kGBPreferenceDefaultFileName = @"growthpush-preferences";
static NSString *const kGPPreferenceClientKey = @"client";
static NSString *const kGPPreferenceTagsKey = @"tags";
static const NSTimeInterval kGPRegisterPollingInterval = 5.0f;

@interface GrowthPush () {

    GBLogger *logger;
    GBHttpClient *httpClient;
    GBPreference *preference;
    
    NSString *applicationId;
    NSString *credentialId;
    GPEnvironment environment;
    BOOL debug;
    NSString *token;
    GPClient *client;
    NSMutableDictionary *tags;
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
@property (nonatomic, strong) GPClient *client;
@property (nonatomic, strong) NSMutableDictionary *tags;
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
@synthesize client;
@synthesize tags;
@synthesize registeringClient;

+ (GrowthPush *) sharedInstance {
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

+ (void)initializeWithApplicationId:(NSString *)applicationId credentialId:(NSString *)credentialId environment:(GPEnvironment)environment {
    [[self sharedInstance] initializeWithApplicationId:applicationId credentialId:credentialId environment:environment];
}

+ (void) requestDeviceToken {
    [[self sharedInstance] requestDeviceToken];
}

+ (void) setDeviceToken:(NSData *)deviceToken {
    [[self sharedInstance] setDeviceToken:deviceToken];
}

+ (void) trackEvent:(NSString *)name {
    [[self sharedInstance] trackEvent:name value:nil];
}

+ (void) trackEvent:(NSString *)name value:(NSString *)value {
    [[self sharedInstance] trackEvent:name value:value];
}

+ (void) setTag:(NSString *)name {
    [[self sharedInstance] setTag:name value:nil];
}

+ (void) setTag:(NSString *)name value:(NSString *)value {
    [[self sharedInstance] setTag:name value:value];
}

+ (void) setDeviceTags {
    [[self sharedInstance] setDeviceTags];
}

+ (void) clearBadge {
    [[self sharedInstance] clearBadge];
}

- (id) init {
    self = [super init];
    if (self) {
        self.logger = [[GBLogger alloc] initWithTag:kGBLoggerDefaultTag];
        self.httpClient = [[GBHttpClient alloc] initWithBaseUrl:[NSURL URLWithString:kGBHttpClientDefaultBaseUrl]];
        self.preference = [[GBPreference alloc] initWithFileName:kGBPreferenceDefaultFileName];
    }
    return self;
}

- (void)initializeWithApplicationId:(NSString *)newApplicationId credentialId:(NSString *)newCredentialId environment:(GPEnvironment)newEnvironment {
    
    self.applicationId = newApplicationId;
    self.credentialId = newCredentialId;
    self.environment = newEnvironment;
    
    [GrowthbeatCore initializeWithApplicationId:applicationId credentialId:credentialId];
    
    self.tags = [self loadTags];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        GBClient *growthbeatClient = [[GrowthbeatCore sharedInstance] waitClient];
        self.client = [self loadClient];
        if (self.client && self.client.growthbeatClientId && ![self.client.growthbeatClientId isEqualToString:growthbeatClient.id]) {
            [self clearClient];
        }
        [self requestDeviceToken];
    });

}

- (void) requestDeviceToken {

    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];

}

- (void) setDeviceToken:(NSData *)newDeviceToken {

    self.token = [self convertToHexToken:newDeviceToken];
    [self registerClient];

}

- (void) trackEvent:(NSString *)name value:(NSString *)value {
    
    [logger info:@"Tracking event... (name: %@)", name];
    
    NSString *eventId = [NSString stringWithFormat:@"Event:Custom:%@", name];
    NSDictionary *properties = nil;
    if (value) {
        properties = @{
                       @"value":value
                       };
    }
    [[GrowthAnalytics sharedInstance] trackEvent:eventId properties:properties];
    
    // TODO Clear client when response code is 401.
    
}

- (void) setTag:(NSString *)name value:(NSString *)value {
    
    [logger info:@"Setting tag... (name: %@)", name];
    
    NSString *tagId = [NSString stringWithFormat:@"Tag:Custom:%@", name];
    [[GrowthAnalytics sharedInstance] setTag:tagId value:value];
    
    // TODO Clear client when response code is 401.
    
}

- (void) setDeviceTags {

    if ([GBDeviceUtils model]) {
        [self setTag:@"Device" value:[GBDeviceUtils model]];
    }
    if ([GBDeviceUtils os]) {
        [self setTag:@"OS" value:[GBDeviceUtils os]];
    }
    if ([GBDeviceUtils language]) {
        [self setTag:@"Language" value:[GBDeviceUtils language]];
    }
    if ([GBDeviceUtils timeZone]) {
        [self setTag:@"Time Zone" value:[GBDeviceUtils timeZone]];
    }
    if ([GBDeviceUtils version]) {
        [self setTag:@"Version" value:[GBDeviceUtils version]];
    }
    if ([GBDeviceUtils build]) {
        [self setTag:@"Build" value:[GBDeviceUtils build]];
    }

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
        [logger info:@"Registering client... (applicationId: %d, environment: %@)", applicationId, NSStringFromGPEnvironment(environment)];
        [[GPClientService sharedInstance] createWithApplicationId:applicationId credentialId:credentialId token:token environment:environment success:^(GPClient *createdClient) {
            [logger info:@"Registering client success. (clientId: %lld)", createdClient.id];
            [logger info:@"See https://growthpush.com/applications/%d/clients to check the client registration.", applicationId];
            self.client = createdClient;
            [self saveClient:client];
            self.registeringClient = NO;
        } fail:^(NSInteger status, NSError *error) {
            [logger info:@"Registering client fail. %@", error];
            self.registeringClient = NO;
        }];
        return;
    }

    if ((token != client.token && ![token isEqualToString:client.token]) || environment != client.environment) {
        [logger info:@"Update client... (id: %d, token: %@, environment: %@)", applicationId, token, NSStringFromGPEnvironment(environment)];
        [[GPClientService sharedInstance] updateWithId:client.id code:client.code token:token environment:environment success:^(GPClient *updatedClient) {
            [logger info:@"Updating client success. (clientId: %lld)", updatedClient.id];
            self.client = updatedClient;
            [self saveClient:client];
            self.registeringClient = NO;
        } fail:^(NSInteger status, NSError *error) {
            [logger info:@"Updating client fail. %@", error];
            self.registeringClient = NO;
        }];
        return;
    }

    [logger info:@"Client already registered."];

}

- (void) runAfterRegister:(void (^)(void))runnable {

    if (client) {
        if (runnable) {
            runnable();
        }
        return;
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kGPRegisterPollingInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
            [self runAfterRegister:runnable];
        });

}

- (GPClient *) loadClient {

    NSData *data = [preference objectForKey:kGPPreferenceClientKey];

    if (!data) {
        return nil;
    }

    return [NSKeyedUnarchiver unarchiveObjectWithData:data];

}

- (void) saveClient:(GPClient *)newClient {

    if (!newClient) {
        return;
    }

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:client];
    [preference setObject:data forKey:kGPPreferenceClientKey];

}

- (void) clearClient {

    self.client = nil;
    [preference removeAll];

}

- (NSMutableDictionary *) loadTags {

    NSDictionary *loadedTags = [preference objectForKey:kGPPreferenceTagsKey];

    if (loadedTags && [loadedTags isKindOfClass:[NSDictionary class]]) {
        return [NSMutableDictionary dictionaryWithDictionary:loadedTags];
    }

    return [NSMutableDictionary dictionary];

}

- (void) saveTags:(NSDictionary *)newTags {

    if (!newTags) {
        return;
    }

    [preference setObject:newTags forKey:kGPPreferenceTagsKey];

}

- (NSString *) convertToHexToken:(NSData *)targetDeviceToken {

    if (!targetDeviceToken) {
        return nil;
    }

    const unsigned *tokenBytes = [targetDeviceToken bytes];

    return [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x", ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]), ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]), ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];

}

@end
