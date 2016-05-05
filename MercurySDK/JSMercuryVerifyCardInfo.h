//
//  JSMercuryVerifyCardInfo.h
//  MercurySDK
//
//  Created by John Setting on 4/25/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSMercuryVerify.h"

@interface JSMercuryVerifyCardInfo : JSMercuryVerify

// The card usage
@property (strong, nonatomic, nonnull) NSString *cardUsage;

// The Operator ID passed in InitializePayment.
@property (strong, nonatomic, nonnull) NSString *operatorId;

// If the payment ID has been used to make a payment (even if they payment was declined or had an error),
// or if the session timed out while the user was on the HostedCheckout page, then this will be true.
// Otherwise, this will be false. Once the payment ID is set to Expired, it may not be used again to make
// a payment. The payment process must be started again with InitializePayment.
@property (assign, nonatomic) BOOL cardIdExpired;

// To find out the status of a CardInfo, the VerifyCardInfo routine in the HostedCheckout web service must be
// called. This allows the application to get the status and additional information about the CardInfo after
// VIP has processed it
- (void)js_verify_cardInfo:(void (^ _Nullable )(JSMercuryVerifyCardInfo * _Nullable verification, NSError * _Nullable error))completion;
@end
