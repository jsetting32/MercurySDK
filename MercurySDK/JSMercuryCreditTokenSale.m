//
//  JSMercuryCreditTokenSale.m
//  MercurySDK
//
//  Created by John Setting on 4/25/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSMercuryCreditTokenSale.h"
#import "JSMercuryUtility.h"
#import "JSMercury.h"
#import "CreditResponse.h"

@implementation JSMercuryCreditTokenSale

- (instancetype)initWithToken:(NSString *)token {
    if (!(self = [super initWithToken:token])) return nil;
    _address = nil;
    _customerCode = nil;
    _cvv = nil;
    _partialAuth = NO;
    _purchaseAmount = @0;
    _taxAmount = @0;
    _zip = nil;
    return self;
}

- (void)hcTransactionDidFinish:(NSDictionary *)result {
    if (self.completionBlock) {
        JSMercuryCreditTokenResponse *response = [[JSMercuryCreditTokenResponse alloc] initWithResponse:result action:MERCURY_ACTION_CREDIT_TOKEN_SALE];
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
    [mgh tokenFromDictionary:params actionType:MERCURY_ACTION_CREDIT_TOKEN_SALE];
}

- (NSMutableDictionary *)generateParameters:(NSMutableArray *)emptyParameters error:(NSError *__autoreleasing  _Nullable *)error {

    NSMutableDictionary *parameters = [super generateParameters:emptyParameters error:error];

    if ([[[JSMercuryAPIClient sharedClient] production] boolValue]) {
        
    } else {
        if (![JSMercuryUtility checkField:self.purchaseAmount]) [emptyParameters addObject:@"PurchaseAmount"];
        if (![JSMercuryUtility checkField:self.taxAmount]) [emptyParameters addObject:@"TaxAmount"];
        if ([emptyParameters count] > 0) {
            *error = [JSMercuryCreditToken errorWithParameters:emptyParameters];
            return nil;
        }
//        NSAssert([JSMercuryUtility checkField:self.purchaseAmount], @"PurchaseAmount is a required field for Token Sale");
//        NSAssert([JSMercuryUtility checkField:self.taxAmount], @"TaxAmount is a required field for Token Sale");
    }

    
    if ([JSMercuryUtility checkField:self.address]) [parameters setObject:self.address forKey:@"Address"];
    if ([JSMercuryUtility checkField:self.customerCode]) [parameters setObject:self.customerCode forKey:@"CustomerCode"];
    if ([JSMercuryUtility checkField:self.cvv]) [parameters setObject:self.cvv forKey:@"Cvv"];
    [parameters setObject:self.partialAuth ? @"true" : @"false" forKey:@"PartialAuth"];
    [parameters setObject:[JSMercuryUtility convertNumberToStringCurrency:self.purchaseAmount] forKey:@"PurchaseAmount"];
    [parameters setObject:[JSMercuryUtility convertNumberToStringCurrency:self.taxAmount] forKey:@"TaxAmount"];
    if ([JSMercuryUtility checkField:self.zip]) [parameters setObject:self.zip forKey:@"Zip"];
    return parameters;
}

@end
