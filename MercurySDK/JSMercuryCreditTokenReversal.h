//
//  JSMercuryCreditTokenReversal.h
//  MercurySDK
//
//  Created by John Setting on 4/25/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSMercuryCreditToken.h"
#import "JSMercuryCreditTokenResponse.h"
#import "JSMercuryVerifyPayment.h"
#import "JSMercuryVerifyCardInfo.h"

@interface JSMercuryCreditTokenReversal : JSMercuryCreditToken

// Acquirer Reference Data that was received in the response of VerifyPayment, CreditSaleToken,
// CreditPreAuthToken, or CreditPreAuthCaptureToken transaction.
@property (strong, nonatomic, nonnull) NSString *acqRefData;

// The Authorization code
@property (strong, nonatomic, nonnull) NSString *authCode;

// The total amount of the order to charge the card holder. Two decimal places are required. Format is 99999.99.
@property (strong, nonatomic, nonnull) NSNumber *purchaseAmount;

// The reference number returned to the developer in the response of the Sale or PreAuthCapture transaction
// or the RefNo filler from the PreAuth.
@property (strong, nonatomic, nonnull) NSString *refNo;

// Process Data that was received in the response of VerifyPayment, CreditSaleToken, CreditPreAuthToken,
// or CreditPreAuthCaptureToken transaction.
@property (strong, nonatomic, nonnull) NSString *processData;

@end
