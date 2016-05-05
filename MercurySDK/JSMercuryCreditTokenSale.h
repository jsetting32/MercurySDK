//
//  JSMercuryCreditTokenSale.h
//  MercurySDK
//
//  Created by John Setting on 4/25/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSMercuryCreditToken.h"
#import "JSMercuryCreditTokenResponse.h"

@interface JSMercuryCreditTokenSale : JSMercuryCreditToken

// CardHolder Billing Address. If provided will be used for Address Verification.
@property (strong, nonatomic, nullable) NSString *address;

// The customer code.
@property (strong, nonatomic, nullable) NSString *customerCode;

// Card Verification Value from back of credit card. Used for card verification
@property (strong, nonatomic, nullable) NSString *cvv;

// Set to true to allow partial authorization. Default is false.
@property (assign, nonatomic) BOOL partialAuth;

// The total amount of the order to charge the card holder. Two decimal places are required. Format is 99999.99.
@property (strong, nonatomic, nonnull) NSNumber *purchaseAmount;

// The tax amount of the order. If there is no tax for the transaction, set to 0.00. Format is 99999.99.
@property (strong, nonatomic, nonnull) NSNumber *taxAmount;

// Cardholder Zip. If provided, will be used for address verification.
@property (strong, nonatomic, nullable) NSString *zip;

- (void)js_mercury_credit_token:(void (^ _Nullable)(JSMercuryCreditTokenResponse * _Nullable response, NSError * _Nullable error))completion;
@end
