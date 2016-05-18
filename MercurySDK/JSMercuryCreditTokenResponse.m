//
//  JSMercuryCreditTokenResponse.m
//  MercurySDK
//
//  Created by John Setting on 4/25/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSMercuryCreditTokenResponse.h"
#import "JSMercuryUtility.h"
#import "JSMercury.h"
#import "CreditResponse.h"

@implementation JSMercuryCreditTokenResponse

- (nullable instancetype)initWithResponse:(NSDictionary *)response action:(NSString *)action {
    if (!(self = [super init])) return nil;
    [self commonInit:response action:action];
    return self;
}

- (void)commonInit:(NSDictionary *)response action:(NSString *)action {
    self.account = [response objectForKey:@"Account"];
    self.acqRefData = [response objectForKey:@"AcqRefData"];
    self.authCode = [response objectForKey:@"AuthCode"];
    
    NSString *authorizeAmount = [response objectForKey:@"AuthorizeAmount"];
    self.authorizeAmount = [JSMercuryUtility convertStringCurrencyToNumber:authorizeAmount];

    self.avsResult = [response objectForKey:@"AvsResult"];
    self.batchNo = [response objectForKey:@"BatchNo"];
    self.cardType = [response objectForKey:@"CardType"];
    self.cvvResult = [response objectForKey:@"CvvResult"];
    
    NSString *gratuityAmount = [response objectForKey:@"gratuityAmount"];
    self.gratuityAmount = [JSMercuryUtility convertStringCurrencyToNumber:gratuityAmount];
    
    self.invoice = [response objectForKey:@"Invoice"];
    self.message = [response objectForKey:@"Message"];
    self.processData = [response objectForKey:@"ProcessData"];
    
    NSString *purchaseAmount = [response objectForKey:@"PurchaseAmount"];
    self.purchaseAmount = [JSMercuryUtility convertStringCurrencyToNumber:purchaseAmount];
    
    self.refNo = [response objectForKey:@"RefNo"];
    self.status = [response objectForKey:@"Status"];

    self.taxAmount = [response objectForKey:@"TaxAmount"];
    
    self.token = [response objectForKey:@"Token"];

    self.action = action;
}

@end
