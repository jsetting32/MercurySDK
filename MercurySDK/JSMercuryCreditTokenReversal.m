//
//  JSMercuryCreditTokenReversal.m
//  MercurySDK
//
//  Created by John Setting on 4/25/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSMercuryCreditTokenReversal.h"
#import "JSMercuryUtility.h"
#import "HCMercuryHelper.h"
#import "JSMercury.h"
#import "CreditResponse.h"

@implementation JSMercuryCreditTokenReversal

- (instancetype)initWithToken:(NSString *)token {
    if (!(self = [super initWithToken:token])) return nil;
    _acqRefData = @"";
    _authCode = @"";
    _purchaseAmount = @0;
    _refNo = @"";
    _processData = @"";
    return self;
}

- (instancetype)initWithVerifyPayment:(JSMercuryVerifyPayment *)payment {
    if (!(self = [super init])) return nil;
    _acqRefData = payment.acqRefData;
    _authCode = payment.authCode;
    _purchaseAmount = payment.amount;
    _refNo = payment.refNo;
    _processData = payment.processData;
    self.cardHolderName = payment.cardHolderName;

    JSMercuryUtility *utility = [JSMercuryUtility sharedInstance];
    
    self.frequency = utility.initializer.frequency;
    
//    self.frequency = payment.;
    self.invoice = payment.invoice;
    self.memo = payment.memo;
//    self.operatorId = payment.o;
//    self.terminalName = ;
    self.token = payment.token;
    return self;
}

- (void)hcTransactionDidFinish:(NSDictionary *)result {
    if (self.completionBlock) {
        JSMercuryCreditTokenResponse *response = [[JSMercuryCreditTokenResponse alloc] initWithResponse:result action:MERCURY_ACTION_CREDIT_TOKEN_REVERSAL];
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
    [mgh tokenFromDictionary:params actionType:MERCURY_ACTION_CREDIT_TOKEN_REVERSAL];
}

- (NSMutableDictionary *)generateParameters:(NSMutableArray *)emptyParameters error:(NSError *__autoreleasing  _Nullable *)error {
    NSMutableDictionary *parameters = [super generateParameters:emptyParameters error:error];

    if ([[[JSMercuryAPIClient sharedClient] production] boolValue]) {
        
    } else {
        NSString *frequency = [JSMercuryUtility js_mercury_frequency_type:self.frequency];
        if (![JSMercuryUtility checkField:frequency]) [emptyParameters addObject:@"Frequency"];
        if (![JSMercuryUtility checkField:self.acqRefData]) [emptyParameters addObject:@"AcqRefData"];
        if (![JSMercuryUtility checkField:self.authCode]) [emptyParameters addObject:@"AuthCode"];
        if (![JSMercuryUtility checkField:self.purchaseAmount]) [emptyParameters addObject:@"PurchaseAmount"];
        if (![JSMercuryUtility checkField:self.refNo]) [emptyParameters addObject:@"RefNo"];
        if (![JSMercuryUtility checkField:self.processData]) [emptyParameters addObject:@"ProcessData"];
        if ([emptyParameters count] > 0) {
            *error = [JSMercuryCreditToken errorWithParameters:emptyParameters];
            return nil;
        }
//        NSAssert([JSMercuryUtility checkField:frequency], @"Frequency is a required field for Token Reversal");
//        NSAssert([JSMercuryUtility checkField:self.acqRefData], @"AcqRefData is a required field for Token Pre Auth");
//        NSAssert([JSMercuryUtility checkField:self.authCode], @"AuthCode is a required field for Token Pre Auth");
//        NSAssert([JSMercuryUtility checkField:self.purchaseAmount], @"PurchaseAmount is a required field for Token Pre Auth");
//        NSAssert([JSMercuryUtility checkField:self.refNo], @"RefNo is a required field for Token Pre Auth");
//        NSAssert([JSMercuryUtility checkField:self.processData], @"ProcessData is a required field for Token Pre Auth");
    }
    
    [parameters setObject:self.acqRefData forKey:@"AcqRefData"];
    [parameters setObject:self.authCode forKey:@"AuthCode"];
    [parameters setObject:self.refNo forKey:@"RefNo"];
    [parameters setObject:[JSMercuryUtility convertNumberToStringCurrency:self.purchaseAmount] forKey:@"PurchaseAmount"];
    [parameters setObject:self.processData forKey:@"ProcessData"];
    return parameters;
}

@end
