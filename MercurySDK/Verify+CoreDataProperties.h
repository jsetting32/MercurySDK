//
//  Verify+CoreDataProperties.h
//  MercurySDK
//
//  Created by John Setting on 4/29/16.
//  Copyright © 2016 John Setting. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Verify.h"

NS_ASSUME_NONNULL_BEGIN

@interface Verify (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *cardHolderName;
@property (nullable, nonatomic, retain) NSString *cardType;
@property (nullable, nonatomic, retain) NSString *displayMessage;
@property (nullable, nonatomic, retain) NSDate *expDate;
@property (nullable, nonatomic, retain) NSString *maskedAccount;
@property (nullable, nonatomic, retain) NSNumber *responseCode;
@property (nullable, nonatomic, retain) NSString *status;
@property (nullable, nonatomic, retain) NSString *statusMessage;
@property (nullable, nonatomic, retain) NSString *token;
@property (nullable, nonatomic, retain) NSString *tranType;

@end

NS_ASSUME_NONNULL_END
