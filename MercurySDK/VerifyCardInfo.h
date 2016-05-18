//
//  VerifyCardInfo.h
//  MercurySDK
//
//  Created by John Setting on 4/29/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Verify.h"
#import "JSMercuryVerifyCardInfo.h"
#import "JSMercuryCreditTokenResponse.h"
#import "CreditResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface VerifyCardInfo : Verify

// Insert code here to declare functionality of your managed object subclass
+ (BOOL)createVerifyCardInfo:(nullable JSMercuryVerifyCardInfo *)object error:(nullable NSError *)error;

@end

NS_ASSUME_NONNULL_END

#import "VerifyCardInfo+CoreDataProperties.h"
