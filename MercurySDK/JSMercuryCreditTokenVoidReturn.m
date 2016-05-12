//
//  JSMercuryCreditTokenVoidReturn.m
//  MercurySDK
//
//  Created by John Setting on 4/25/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSMercuryCreditTokenVoidReturn.h"
#import "JSMercuryUtility.h"
#import "HCMercuryHelper.h"
#import "JSMercury.h"
#import "CreditResponse.h"

@implementation JSMercuryCreditTokenVoidReturn

- (instancetype)initWithToken:(NSString *)token {
    if (!(self = [super initWithToken:token])) return nil;
    _authCode = @"";
    _purchaseAmount = @0;
    _refNo = @"";
    return self;
}

- (void)hcTransactionDidFinish:(NSDictionary *)result {
    if (self.completionBlock) {
        JSMercuryCreditTokenResponse *response = [[JSMercuryCreditTokenResponse alloc] initWithResponse:result action:MERCURY_ACTION_CREDIT_TOKEN_VOID_RETURN];
        NSError *error = nil;
        BOOL coreData = [[[JSMercuryAPIClient sharedClient] coreDataKey] boolValue];
        if (coreData) {
            if (![CreditResponse createCreditResponse:response error:error]) {
                NSLog(@"%@", error);
            }
        }
        self.completionBlock(response, error);
    }
}

- (void)hcTransactionDidFailWithError:(NSError *)error {
    if (self.completionBlock) {
        self.completionBlock(nil, error);
    }
}

- (void)js_mercury_credit_token:(void (^)(JSMercuryCreditTokenResponse * _Nullable, NSError * _Nullable))completion {
    self.completionBlock = [completion copy];
    HCMercuryHelper *mgh = [HCMercuryHelper new];
    mgh.delegate = self;
    NSError *error = nil;
    NSDictionary *params = [self generateParameters:[NSMutableArray array] error:&error];
    if (error) {
        self.completionBlock(nil, error);
        return;
    }
    [mgh tokenFromDictionary:params actionType:MERCURY_ACTION_CREDIT_TOKEN_VOID_RETURN];
}

- (NSMutableDictionary *)generateParameters:(NSMutableArray *)emptyParameters error:(NSError *__autoreleasing  _Nullable *)error {
    
    NSMutableDictionary *parameters = [super generateParameters:emptyParameters error:error];

    if ([[[JSMercuryAPIClient sharedClient] production] boolValue]) {
        
    } else {
        if (![JSMercuryUtility checkField:self.authCode]) [emptyParameters addObject:@"AuthCode"];
        if (![JSMercuryUtility checkField:self.purchaseAmount]) [emptyParameters addObject:@"PurchaseAmount"];
        if (![JSMercuryUtility checkField:self.refNo]) [emptyParameters addObject:@"RefNo"];
        if ([emptyParameters count] > 0) {
            *error = [JSMercuryCreditToken errorWithParameters:emptyParameters];
            return nil;
        }
//        NSAssert([JSMercuryUtility checkField:self.authCode], @"AuthCode is a required field for Token Pre Auth");
//        NSAssert([JSMercuryUtility checkField:self.purchaseAmount], @"PurchaseAmount is a required field for Token Pre Auth");
//        NSAssert([JSMercuryUtility checkField:self.refNo], @"RefNo is a required field for Token Pre Auth");
    }
    
    [parameters setObject:self.authCode forKey:@"AuthCode"];
    [parameters setObject:[JSMercuryUtility convertNumberToStringCurrency:self.purchaseAmount] forKey:@"PurchaseAmount"];
    [parameters setObject:self.refNo forKey:@"RefNo"];
    return parameters;
}

@end
