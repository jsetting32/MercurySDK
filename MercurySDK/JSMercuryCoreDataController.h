//
//  JSMercuryCoreDataController.h
//  MercurySDK
//
//  Created by John Setting on 4/29/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "VerifyPayment.h"
#import "VerifyCardInfo.h"
#import "CreditResponse.h"
#import "Address.h"

@interface JSMercuryCoreDataController : NSObject
+ (nullable instancetype)sharedInstance;
- (nonnull NSURL *)applicationDocumentsDirectory;
- (void)saveContext;

- (nonnull NSManagedObjectContext *)masterManagedObjectContext;
- (nonnull NSManagedObjectContext *)backgroundManagedObjectContext;
- (nonnull NSManagedObjectContext *)newManagedObjectContext;

- (nonnull NSManagedObjectModel *)managedObjectModel;
- (nonnull NSPersistentStoreCoordinator *)persistentStoreCoordinator;

+ (nonnull NSArray <VerifyPayment *> *)fetchVerifyPaymentAll:(nullable NSError *)error;
+ (nonnull NSArray <VerifyCardInfo *> *)fetchVerifyCardInfoAll:(nullable NSError *)error;
+ (nonnull NSArray <CreditResponse *> *)fetchCreditResponseAll:(nullable NSError *)error;
+ (nonnull NSArray <CreditResponse *> *)fetchAddressShippingAll:(nullable NSError *)error;
+ (nonnull NSArray <CreditResponse *> *)fetchAddressBillingAll:(nullable NSError *)error;
+ (nonnull NSNumber *)fetchNextInvoiceNumber:(nullable NSError *)error;
@end
