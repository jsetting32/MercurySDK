//
//  JSMercuryCreditTokenPreAuthCapture.h
//  MercurySDK
//
//  Created by John Setting on 4/25/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSMercuryCreditToken.h"
#import "JSMercuryCreditTokenResponse.h"

@interface JSMercuryCreditTokenPreAuthCapture : JSMercuryCreditToken

// Acquirer Reference Data
@property (strong, nonatomic, nullable) NSString *acqRefData;

// The Authorization code.
@property (strong, nonatomic, nonnull) NSString *authCode;

// The amount authorized for the transaction. Two decimal places are required. Must match the AuthorizeAmount
// that was sent in the PreAuth. Format is 99999.99.
@property (strong, nonatomic, nonnull) NSNumber *authAmount;

// The customer code
@property (strong, nonatomic, nullable) NSString *customerCode;

// The gratuity amount of the order. Two decimal places are required. If there is no gratuity amount,
// pass ‘0.00’. Format is 99999.99.
@property (strong, nonatomic, nonnull) NSNumber *gratuityAmount;

// The amount authorized for the transaction. Two decimal places are required. Must match the Amount
// that was sent in the PreAuth. Format is 99999.99.
@property (strong, nonatomic, nonnull) NSNumber *purchaseAmount;

// The tax amount of the order. Two decimal places are required. If there is no tax amount, pass ‘0.00’.
// Format is 99999.99.
@property (strong, nonatomic, nonnull) NSNumber *taxAmount;

- (void)js_mercury_credit_token:(void (^ _Nullable)(JSMercuryCreditTokenResponse * _Nullable response, NSError * _Nullable error))completion;
@end
