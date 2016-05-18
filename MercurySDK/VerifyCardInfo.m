//
//  VerifyCardInfo.m
//  MercurySDK
//
//  Created by John Setting on 4/29/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "VerifyCardInfo.h"
#import "JSMercuryCoreDataController.h"
#import "NSManagedObject+Properties.h"

@implementation VerifyCardInfo

// Insert code here to add functionality to your managed object subclass
+ (BOOL)createVerifyCardInfo:(JSMercuryVerifyCardInfo *)object error:(NSError *)error {
    NSManagedObjectContext *context = [[JSMercuryCoreDataController sharedInstance] masterManagedObjectContext];
    VerifyCardInfo *info = [VerifyCardInfo js_hardManagedObject:context];
    info.cardHolderName = object.cardHolderName;
    info.cardIdExpired = @(object.cardIdExpired);
    info.cardType = object.cardType;
    info.cardUsage = object.cardUsage;
    info.displayMessage = object.displayMessage;
    info.expDate = object.expDate;
    info.maskedAccount = object.maskedAccount;
    info.operatorId = object.operatorId;
    info.responseCode = object.responseCode;
    info.status = object.status;
    info.statusMessage = object.statusMessage;
    info.token = object.token;
    info.tranType = object.tranType;
    info.dateUsed = [NSDate date];
    return [context save:&error];
}

@end
