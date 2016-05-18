//
//  JSMercuryInitializePayment.m
//  MercurySDK
//
//  Created by John Setting on 4/22/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSMercuryInitializePayment.h"
#import "JSMercuryTypeDef.h"
#import "HCMercuryHelper.h"
#import "JSMercuryUtility.h"
#import "JSMercuryWebViewController.h"
#import "JSMercuryConstants.h"

@implementation JSMercuryInitializePayment

+ (instancetype)js_init { return [[self alloc] init]; }

- (instancetype)init {
    if (!(self = [super init])) return nil;
    _transType = kJSMercuryTransactionTypeSale;
    _partialAuth = NO;
    _totalAmount = @0;
    _invoice = nil;
    _memo = [NSString stringWithFormat:@"%@ - %@ - %@", [JSMercuryUtility appTitle], [JSMercuryUtility appVersion], MERCURY_ACTION_INITIALIZE_PAYMENT];
    _taxAmount = @0;
    _AVSFields = kJSMercuryTransactionAVSFieldsOff;
    _AVSAddress = nil;
    _AVSZip = nil;
    _CVV = YES;
    _customerCode = nil;
    _pageTimeoutIndicator = NO;
    _orderTotal = YES;
    return self;
}

#pragma mark <HCMercuryHelperDelegate>
- (void)hcTransactionDidFinish:(NSDictionary *)result {
    if (self.completionBlock) {
        JSMercuryUtility *utility = [JSMercuryUtility sharedInstance];
        JSMercuryInitializeResponse *response = [[JSMercuryInitializeResponse alloc] initWithResponse:result];
        [utility setInitializeResponse:response];
        [utility setInitializer:self];
        
        NSAssert(utility.initializeResponse.paymentId, @"There must be a valid pid to render the Hosted Checkout Page");
        NSString *pidURL = [NSString stringWithFormat:@"https://hc.mercurycert.net/CheckoutiFrame.aspx?pid=%@", utility.initializeResponse.paymentId];
        //    NSString *pidURL = [NSString stringWithFormat:@"https://hc.mercurycert.net/CheckoutPOSiframe.aspx?pid=%@", utility.pid];
        //    NSString *pidURL = [NSString stringWithFormat:@"https://hc.mercurycert.net/mobile/mCheckout.aspx?pid=%@", utility.pid];
        NSURL *url = [NSURL URLWithString:pidURL];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"JSMercuryWebViewStoryboard" bundle:nil];
        UINavigationController *nav = [storyboard instantiateInitialViewController];
        JSMercuryWebViewController *web = [[nav viewControllers] firstObject];
        web.webRequest = requestObj;
        self.completionBlock(nav, web, nil);
    }
}

- (void)hcTransactionDidFailWithError:(NSError *)error {
    if (self.completionBlock) {
        self.completionBlock(nil, nil, error);
    }
}

- (void)js_mercury_transaction:(kJSMercuryInitializeBlock)completion {
    self.completionBlock = [completion copy];
    HCMercuryHelper *mgh = [HCMercuryHelper new];
    mgh.delegate = self;
    [mgh actionFromDictionary:[self generateParameters] actionType:MERCURY_ACTION_INITIALIZE_PAYMENT];
}

- (NSMutableDictionary *)generateParameters {
    NSAssert(self.totalAmount && [self.totalAmount floatValue] > 0, @"Total Amount must be used for payment initializer");
    NSAssert(self.invoice && [self.invoice length] > 0, @"Invoice must be used for payment initializer");
    NSAssert(self.memo, @"Memo must be used for payment initializer");
    NSAssert(self.taxAmount, @"Tax Amount must be used for payment initializer");
    
    NSMutableDictionary *parameters = [super generateParameters];
    [parameters setObject:[JSMercuryUtility js_mercury_transaction_type:self.transType] forKey:@"TranType"];
    [parameters setObject:self.partialAuth ? @"on" : @"off" forKey:@"PartialAuth"];
    [parameters setObject:[JSMercuryUtility convertNumberToStringCurrency:self.totalAmount] forKey:@"TotalAmount"];
    [parameters setObject:self.invoice forKey:@"Invoice"];
    [parameters setObject:self.memo forKey:@"Memo"];
    [parameters setObject:[JSMercuryUtility convertNumberToStringCurrency:self.taxAmount] forKey:@"TaxAmount"];
    [parameters setObject:[JSMercuryUtility js_mercury_avs_fields:self.AVSFields] forKey:@"AVSFields"];
    if ([JSMercuryUtility checkField:self.AVSAddress]) [parameters setObject:self.AVSAddress forKey:@"AVSAddress"];
    if ([JSMercuryUtility checkField:self.AVSZip]) [parameters setObject:self.AVSZip forKey:@"AVSZip"];
    [parameters setObject:self.CVV ? @"on" : @"off" forKey:@"CVV"];
    if ([JSMercuryUtility checkField:self.customerCode]) [parameters setObject:self.customerCode forKey:@"CustomerCode"];
    [parameters setObject:self.pageTimeoutIndicator ? @"on" : @"off" forKey:@"PageTimeoutIndicator"];
    [parameters setObject:self.orderTotal ? @"on" : @"off" forKey:@"OrderTotal"];
    return parameters;
}

@end
