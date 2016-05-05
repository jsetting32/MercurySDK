//
//  CreditResponse+CoreDataProperties.h
//  MercurySDK
//
//  Created by John Setting on 5/3/16.
//  Copyright © 2016 John Setting. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CreditResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreditResponse (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *account;
@property (nullable, nonatomic, retain) NSString *acqRefData;
@property (nullable, nonatomic, retain) NSString *authCode;
@property (nullable, nonatomic, retain) NSNumber *authorizeAmount;
@property (nullable, nonatomic, retain) NSString *avsResult;
@property (nullable, nonatomic, retain) NSString *batchNo;
@property (nullable, nonatomic, retain) NSString *cardType;
@property (nullable, nonatomic, retain) NSString *cvvResult;
@property (nullable, nonatomic, retain) NSNumber *gratuityAmount;
@property (nullable, nonatomic, retain) NSString *invoice;
@property (nullable, nonatomic, retain) NSString *message;
@property (nullable, nonatomic, retain) NSNumber *purchaseAmount;
@property (nullable, nonatomic, retain) NSString *refNo;
@property (nullable, nonatomic, retain) NSString *status;
@property (nullable, nonatomic, retain) NSString *token;
@property (nullable, nonatomic, retain) NSString *processData;

@end

NS_ASSUME_NONNULL_END
