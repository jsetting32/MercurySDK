//
//  JSMercuryCreditTokenPreAuth.h
//  MercurySDK
//
//  Created by John Setting on 4/25/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSMercuryCreditToken.h"
#import "JSMercuryCreditTokenResponse.h"

@interface JSMercuryCreditTokenPreAuth : JSMercuryCreditToken

// CardHolder Billing Address. If provided will be used for Address Verification.
@property (strong, nonatomic, nullable) NSString *address;

// Card Verification Value from back of credit card. Used for card verification
@property (strong, nonatomic, nullable) NSString *cvv;

// The initial amount of the order to charge the card holder. Two decimal places are required.
// Format is 99999.99.
@property (strong, nonatomic, nonnull) NSNumber *amount;

// Cardholder Zip. If provided, will be used for address verification.
@property (strong, nonatomic, nullable) NSNumber *zip;

- (void)js_mercury_credit_token:(void (^ _Nullable)(JSMercuryCreditTokenResponse * _Nullable response, NSError * _Nullable error))completion;
@end
