//
//  VerifyPayment+CoreDataProperties.h
//  MercurySDK
//
//  Created by John Setting on 4/29/16.
//  Copyright © 2016 John Setting. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "VerifyPayment.h"

NS_ASSUME_NONNULL_BEGIN

@interface VerifyPayment (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *acqRefData;
@property (nullable, nonatomic, retain) NSNumber *amount;
@property (nullable, nonatomic, retain) NSString *authCode;
@property (nullable, nonatomic, retain) NSString *avsAddress;
@property (nullable, nonatomic, retain) NSString *avsResult;
@property (nullable, nonatomic, retain) NSString *avsZip;
@property (nullable, nonatomic, retain) NSString *customerCode;
@property (nullable, nonatomic, retain) NSString *cvvResult;
@property (nullable, nonatomic, retain) NSString *invoice;
@property (nullable, nonatomic, retain) NSString *memo;
@property (nullable, nonatomic, retain) NSNumber *paymentIdExpired;
@property (nullable, nonatomic, retain) NSString *processData;
@property (nullable, nonatomic, retain) NSString *refNo;
@property (nullable, nonatomic, retain) NSNumber *taxAmount;
@property (nullable, nonatomic, retain) NSDate *transPostTime;

@end

NS_ASSUME_NONNULL_END
