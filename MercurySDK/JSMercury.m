//
//  JSMercury.m
//  MercurySDK
//
//  Created by John Setting on 4/19/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSMercury.h"

static NSString *JSMercuryMerchantKey;
static NSString *JSMercuryPasswordKey;
static NSNumber *JSMercuryCoreDataKey;
static NSNumber *JSMercuryProductionKey;

@implementation JSMercury
+ (void)setMerchantID:(NSString *)merchantID password:(NSString *)password coreData:(BOOL)coreData production:(BOOL)production {
    JSMercuryMerchantKey = merchantID;
    JSMercuryPasswordKey = password;
    JSMercuryCoreDataKey = @(coreData);
    JSMercuryProductionKey = @(production);
}

+ (NSString *)mercuryMerchantKey { return JSMercuryMerchantKey; }
+ (NSString *)mercuryPasswordKey { return JSMercuryPasswordKey; }
+ (NSNumber *)mercuryCoreDataKey { return JSMercuryCoreDataKey; }
+ (NSNumber *)mercuryProductionKey { return JSMercuryProductionKey; }
@end

@implementation JSMercuryAPIClient

+ (instancetype)sharedClient {
    static JSMercuryAPIClient *sharedClient;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ sharedClient = [[self alloc] init]; });
    return sharedClient;
}

- (instancetype)init {
    return [self initWithMerchantKey:[JSMercury mercuryMerchantKey]
                         passwordKey:[JSMercury mercuryPasswordKey]
                            coreData:[[JSMercury mercuryCoreDataKey] boolValue]
                          production:[[JSMercury mercuryProductionKey] boolValue]];
}

- (instancetype)initWithMerchantKey:(NSString *)merchantKey passwordKey:(NSString *)passwordKey coreData:(BOOL)coreData production:(BOOL)production {
    if (!(self = [super init])) return nil;
    [self.class validateMerchantKey:merchantKey];
    [self.class validatePasswordKey:passwordKey];
    
    //        _apiURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://%@", apiURLBase]];
    
    _merchantKey = [merchantKey copy];
    _passwordKey = [passwordKey copy];
    _coreDataKey = @(coreData);
    _production = @(production);
    
    //        _operationQueue = [NSOperationQueue mainQueue];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    //        config.HTTPAdditionalHeaders = @{
    //                                         @"Content-Type" : @"application/json"
    //                                         };
    //        _urlSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:_operationQueue];

    return self;
}

#pragma mark - private helpers

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
+ (void)validateMerchantKey:(NSString *)merchantKey {
    NSCAssert(merchantKey != nil && ![merchantKey isEqualToString:@""], @"You must use a valid access key to make transactions. For more info, see https://stripe.com/docs/stripe.js");
    //    BOOL secretKey = [accessKey hasPrefix:@"sk_"];
    //    NSCAssert(!secretKey, @"You are using a secret key to create a token, instead of the publishable one. For more info, see https://stripe.com/docs/stripe.js");
    //#ifndef DEBUG
    //    if ([publishableKey.lowercaseString hasPrefix:@"pk_test"]) {
    //        FAUXPAS_IGNORED_IN_METHOD(NSLogUsed);
    //        NSLog(@"⚠️ Warning! You're building your app in a non-debug configuration, but appear to be using your Stripe test key. Make sure not to submit to "
    //              @"the App Store with your test keys!⚠️");
    //    }
    //#endif
}

+ (void)validatePasswordKey:(NSString *)passwordKey {
    NSCAssert(passwordKey != nil && ![passwordKey isEqualToString:@""], @"You must use a valid access key to make transactions. For more info, see https://stripe.com/docs/stripe.js");
    //    BOOL secretKey = [accessKey hasPrefix:@"sk_"];
    //    NSCAssert(!secretKey, @"You are using a secret key to create a token, instead of the publishable one. For more info, see https://stripe.com/docs/stripe.js");
    //#ifndef DEBUG
    //    if ([publishableKey.lowercaseString hasPrefix:@"pk_test"]) {
    //        FAUXPAS_IGNORED_IN_METHOD(NSLogUsed);
    //        NSLog(@"⚠️ Warning! You're building your app in a non-debug configuration, but appear to be using your Stripe test key. Make sure not to submit to "
    //              @"the App Store with your test keys!⚠️");
    //    }
    //#endif
}

@end
