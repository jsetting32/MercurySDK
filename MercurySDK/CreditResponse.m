//
//  CreditResponse.m
//  MercurySDK
//
//  Created by John Setting on 5/18/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "CreditResponse.h"
#import "NSManagedObject+Properties.h"
#import "JSMercuryCoreDataController.h"
#import "VerifyCardInfo.h"

@implementation CreditResponse

// Insert code here to add functionality to your managed object subclass
+ (BOOL)createCreditResponse:(JSMercuryCreditTokenResponse *)object token:(NSString *)token error:(NSError **)error {
    NSManagedObjectContext *context = [[JSMercuryCoreDataController sharedInstance] masterManagedObjectContext];
    CreditResponse *info = [CreditResponse js_hardManagedObject:context];
    info.account = object.account;
    info.action = object.action;
    info.acqRefData = object.acqRefData;
    info.authCode = object.authCode;
    info.authorizeAmount = object.authorizeAmount;
    info.avsResult = object.avsResult;
    info.batchNo = object.batchNo;
    info.cardType = object.cardType;
    info.cvvResult = object.cvvResult;
    info.gratuityAmount = object.gratuityAmount;
    info.invoice = object.invoice;
    info.message = object.message;
    info.processData = object.processData;
    info.purchaseAmount = object.purchaseAmount;
    info.refNo = object.refNo;
    info.status = object.status;
    info.token = object.token;
    info.transPostTime = [NSDate date];

    VerifyCardInfo *card = [JSMercuryCoreDataController fetchVerifyCardInfoByToken:token error:error];
    [card setToken:info.token];
    [card setDateUsed:[NSDate date]];
    
    return [context save:error];
}

- (NSString *)formattedPurchaseAmount {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    return [numberFormatter stringFromNumber:self.purchaseAmount];
}

- (NSString *)formattedTransactionDateTime {
    NSDateFormatter *numberFormatter = [[NSDateFormatter alloc] init];
    [numberFormatter setDateFormat:@"MMMM, dd, yyyy - hh:mm a"];
    return [numberFormatter stringFromDate:[NSDate date]];
}


@end
