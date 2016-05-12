//
//  CreditResponse.h
//  MercurySDK
//
//  Created by John Setting on 5/12/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "JSMercuryCreditTokenResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreditResponse : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+ (BOOL)createCreditResponse:(nullable JSMercuryCreditTokenResponse *)object error:(nullable NSError *)error;
- (NSString *)formattedPurchaseAmount;

@end

NS_ASSUME_NONNULL_END

#import "CreditResponse+CoreDataProperties.h"
