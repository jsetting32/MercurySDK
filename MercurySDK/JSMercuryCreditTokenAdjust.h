//
//  JSMercuryCreditTokenAdjust.h
//  MercurySDK
//
//  Created by John Setting on 4/25/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSMercuryCreditToken.h"
#import "JSMercuryCreditTokenResponse.h"

@interface JSMercuryCreditTokenAdjust : JSMercuryCreditToken

// The Authorization code.
@property (strong, nonatomic, nonnull) NSString *authCode;

// The customer code
@property (strong, nonatomic, nullable) NSString *customerCode;

// The gratuity amount of the order. Two decimal places are required. If there is no gratuity amount,
// pass ‘0.00’. Format is 99999.99.
@property (strong, nonatomic, nonnull) NSNumber *gratuityAmount;

// The amount of the order to charge the cardholder not including gratuity.
// Two decimal places are required. Format is 99999.99.
@property (strong, nonatomic, nonnull) NSNumber *purchaseAmount;

// The reference number returned to the developer in the response of the Sale or PreAuthCapture transaction.
@property (strong, nonatomic, nonnull) NSString *refNo;

// The tax amount of the order. Two decimal places are required. If there is no tax amount,
// pass ‘0.00’. Format is 99999.99.
@property (strong, nonatomic, nonnull) NSNumber *taxAmount;

@end
