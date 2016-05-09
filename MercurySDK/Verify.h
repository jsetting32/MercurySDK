//
//  Verify.h
//  MercurySDK
//
//  Created by John Setting on 4/29/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "JSMercuryVerify.h"

@class VerifyCardInfo, VerifyPayment;

NS_ASSUME_NONNULL_BEGIN

@interface Verify : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
- (NSString *)formattedExpDate;
- (NSString *)formattedExpDateMonth;
- (NSString *)formattedExpDateYear;
- (BOOL)isValid;
- (NSString *)formattedMaskedAccount;

@end

NS_ASSUME_NONNULL_END

#import "Verify+CoreDataProperties.h"
