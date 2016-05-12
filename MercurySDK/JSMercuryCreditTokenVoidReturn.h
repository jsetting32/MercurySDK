//
//  JSMercuryCreditTokenVoidReturn.h
//  MercurySDK
//
//  Created by John Setting on 4/25/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSMercuryCreditToken.h"
#import "JSMercuryCreditTokenResponse.h"

@interface JSMercuryCreditTokenVoidReturn : JSMercuryCreditToken

// The Authorization code
@property (strong, nonatomic, nonnull) NSString *authCode;

// The total amount of the order to charge the card holder. Two decimal places are required. Format is 99999.99.
@property (strong, nonatomic, nonnull) NSNumber *purchaseAmount;

// The reference number of the transaction returned in the original PreAuthCapture or Sale response.
@property (strong, nonatomic, nonnull) NSString *refNo;

@end
