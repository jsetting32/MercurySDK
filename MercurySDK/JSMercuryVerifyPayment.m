//
//  JSMercuryVerifyPayment.m
//  MercurySDK
//
//  Created by John Setting on 4/25/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSMercuryVerifyPayment.h"
#import "JSMercuryTypeDef.h"
#import "JSMercuryUtility.h"
#import "JSMercury.h"
#import "JSMercuryConstants.h"
#import "VerifyPayment.h"
#import "NSManagedObject+Properties.h"
#import "JSMercuryCoreDataController.h"

//@interface JSMercuryVerifyPayment()
//@property (strong, nonatomic, nullable) NSString *paymentId;
//@end

@implementation JSMercuryVerifyPayment

- (instancetype)initWithResponse:(NSDictionary *)response {
    if (!(self = [super initWithResponse:response])) return nil;
    [self commonInit:response];
    return self;
}

- (void)commonInit:(NSDictionary *)response {
    self.acqRefData = [response objectForKey:@"AcqRefData"];

    NSString *amount = [response objectForKey:@"Amount"];
    self.amount = [JSMercuryUtility convertStringCurrencyToNumber:amount];
    
    self.authCode = [response objectForKey:@"AuthCode"];
    self.AVSAddress = [response objectForKey:@"AVSAddress"];
    self.AVSResult = [response objectForKey:@"AVSResult"];
    self.AVSZip = [response objectForKey:@"AVSZip"];
    self.customerCode = [response objectForKey:@"CustomerCode"];
    self.CVVResult = [response objectForKey:@"CVVResult"];
    self.invoice = [response objectForKey:@"Invoice"];
    self.memo = [response objectForKey:@"Memo"];
    self.paymentIDExpired = @([[response objectForKey:@"PaymentIDExpired"] boolValue]);
    self.processData = [response objectForKey:@"ProcessData"];
    self.refNo = [response objectForKey:@"RefNo"];
    
    NSString *taxAmount = [response objectForKey:@"TaxAmount"];
    self.taxAmount = [JSMercuryUtility convertStringCurrencyToNumber:taxAmount];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    self.transPostTime = [formatter dateFromString:[response objectForKey:@"TransPostTime"]];
}

- (void)js_verify_payment:(void (^)(JSMercuryVerifyPayment * _Nullable, NSError * _Nullable))completion {
    self.completionBlock = [completion copy];
    
    NSMutableDictionary *dictionaryReq = [NSMutableDictionary new];
    [dictionaryReq setObject:[[JSMercuryUtility sharedInstance] initializeResponse].paymentId forKey:@"PaymentID"];
    
    HCMercuryHelper *mgh = [HCMercuryHelper new];
    mgh.delegate = self;
    [mgh actionFromDictionary:dictionaryReq actionType:MERCURY_ACTION_VERIFY_PAYMENT];
}

- (void)hcTransactionDidFinish:(NSDictionary *)result {
    if (self.completionBlock) {
        JSMercuryVerifyPayment *verify = [[JSMercuryVerifyPayment alloc] initWithResponse:result];
        
        NSError *error = nil;
        BOOL coreData = [[[JSMercuryAPIClient sharedClient] coreDataKey] boolValue];
        if (coreData) {
            if (![VerifyPayment createVerifyPayment:verify error:error]) {
                NSLog(@"%@", error);
            }
        }
        self.completionBlock(verify, nil);
    }
}

- (void)hcTransactionDidFailWithError:(NSError *)error {
    if (self.completionBlock) {
        self.completionBlock(nil, error);
    }
}

@end
