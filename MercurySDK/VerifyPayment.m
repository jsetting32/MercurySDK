//
//  VerifyPayment.m
//  MercurySDK
//
//  Created by John Setting on 4/29/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "VerifyPayment.h"
#import "JSMercuryCoreDataController.h"
#import "NSManagedObject+Properties.h"
#import "VerifyCardInfo.h"

@implementation VerifyPayment

// Insert code here to add functionality to your managed object subclass
+ (BOOL)createVerifyPayment:(JSMercuryVerifyPayment *)object error:(NSError *)error {
    NSManagedObjectContext *context = [[JSMercuryCoreDataController sharedInstance] masterManagedObjectContext];
    VerifyPayment *info = [VerifyPayment js_hardManagedObject:context];
    info.acqRefData = object.acqRefData;
    info.amount = object.amount;
    info.authCode = object.authCode;
    info.avsAddress = object.AVSAddress;
    info.avsResult = object.AVSResult;
    info.avsZip = object.AVSZip;
    info.cardHolderName = object.cardHolderName;
    info.cardType = object.cardType;
    info.customerCode = object.customerCode;
    info.cvvResult = object.CVVResult;
    info.displayMessage = object.displayMessage;
    info.expDate = object.expDate;
    info.invoice = object.invoice;
    info.memo = object.memo;
    info.maskedAccount = object.maskedAccount;
    info.paymentIdExpired = object.paymentIDExpired;
    info.processData = object.processData;
    info.refNo = object.refNo;
    info.responseCode = object.responseCode;
    info.status = object.status;
    info.statusMessage = object.statusMessage;
    info.taxAmount = object.taxAmount;
    info.token = object.token;
    info.transPostTime = object.transPostTime;
    info.tranType = object.tranType;
    
    return [context save:&error];
}

- (NSString *)transPostTimeFormatted {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    return [dateFormatter stringFromDate:self.transPostTime];
}

- (NSString *)amountFormatted {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    return [numberFormatter stringFromNumber:self.amount];
}

@end
