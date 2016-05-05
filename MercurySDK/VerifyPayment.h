//
//  VerifyPayment.h
//  MercurySDK
//
//  Created by John Setting on 4/29/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Verify.h"
#import "JSMercuryVerifyPayment.h"
#import "JSMercuryCreditTokenResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface VerifyPayment : Verify

// Insert code here to declare functionality of your managed object subclass
+ (BOOL)createVerifyPayment:(nullable JSMercuryVerifyPayment *)object error:(nullable NSError *)error;

- (NSString *)transPostTimeFormatted;
- (NSString *)amountFormatted;

@end

NS_ASSUME_NONNULL_END

#import "VerifyPayment+CoreDataProperties.h"
