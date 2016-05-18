//
//  VerifyCardInfo+CoreDataProperties.h
//  MercurySDK
//
//  Created by John Setting on 5/18/16.
//  Copyright © 2016 John Setting. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "VerifyCardInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface VerifyCardInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *cardIdExpired;
@property (nullable, nonatomic, retain) NSString *cardUsage;
@property (nullable, nonatomic, retain) NSString *operatorId;
@property (nullable, nonatomic, retain) NSDate *dateUsed;

@end

NS_ASSUME_NONNULL_END
