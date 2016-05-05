//
//  JSMercuryCreditTokenVoidSale.h
//  MercurySDK
//
//  Created by John Setting on 4/25/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSMercuryCreditToken.h"
#import "JSMercuryCreditTokenResponse.h"

@interface JSMercuryCreditTokenVoidSale : JSMercuryCreditToken

// The Authorization code
@property (strong, nonatomic, nonnull) NSString *authCode;

// The total amount of the order to charge the card holder. Two decimal places are required. Format is 99999.99.
@property (strong, nonatomic, nonnull) NSNumber *purchaseAmount;

// The reference number returned to the developer in the response of the Sale or PreAuthCapture transaction
// or the InvoiceNo from a PreAuth for reversal.
@property (strong, nonatomic, nonnull) NSString *refNo;

- (void)js_mercury_credit_token:(void (^ _Nullable)(JSMercuryCreditTokenResponse * _Nullable response, NSError * _Nullable error))completion;
@end
