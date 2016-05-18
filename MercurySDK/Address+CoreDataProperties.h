//
//  Address+CoreDataProperties.h
//  MercurySDK
//
//  Created by John Setting on 5/18/16.
//  Copyright © 2016 John Setting. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Address.h"

NS_ASSUME_NONNULL_BEGIN

@interface Address (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSNumber *billing;
@property (nullable, nonatomic, retain) NSString *city;
@property (nullable, nonatomic, retain) NSString *country;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *phone;
@property (nullable, nonatomic, retain) NSString *postalCode;
@property (nullable, nonatomic, retain) NSString *state;
@property (nullable, nonatomic, retain) NSDate *dateUsed;

@end

NS_ASSUME_NONNULL_END
