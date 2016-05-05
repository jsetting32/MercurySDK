//
//  JSMercuryInitializePayment.h
//  MercurySDK
//
//  Created by John Setting on 4/22/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSMercuryInitialize.h"

@interface JSMercuryInitializePayment : JSMercuryInitialize

// The type of payment VIP should process. Values are PreAuth, Sale, and ZeroAuth
@property (assign, nonatomic) kJSMercuryTransactionType transType;

// ￼Values = on or off - Default is off. You will have to code to prompt for the remaining balance if the card has insufficient funds to cover the TotalAmount.
// If you do not want card holders to be able to use the remainder of the balance on their PrePaid debit cards, set this to off.
@property (assign, nonatomic) BOOL partialAuth;

// The total amount of the order to charge the card holder. Two decimal places are required. Format is 99999.99. ZeroAuth amount must be 0.00.
// If TotalAmount is left null, or is not a valid number, you will receive an error response back, such as “The remote server returned an error: (500) Internal Server Error.”
@property (strong, nonatomic, nonnull) NSNumber *totalAmount;

// Invoice Number from the eCommerce site. It will be used for both the Invoice and the RefNo fields when the pre-auth is submitted.
@property (strong, nonatomic, nonnull) NSString *invoice;

// The Memo tag is the product name and version number of the developer’s software.
@property (strong, nonatomic, nonnull) NSString *memo;

// The tax amount of the transaction. Two decimal places are required. If there is no tax amount, pass in ‘0.00’. Format is 99999.99.
@property (strong, nonatomic, nonnull) NSNumber *taxAmount;

// Valid values = Off, Zip, or Both.
@property (assign, nonatomic) kJSMercuryTransactionAVSFields AVSFields;

// ￼Street number portion of CardHolder Billing Address. If provided will be used for Address Verification.
@property (strong, nonatomic, nullable) NSString *AVSAddress;

// Cardholder Zip. If provided, will be used for address verification. Canadian Postal Codes must use the following format “A1A1A1”. The letters D, F, I, O, Q, and U are not permitted.
@property (strong, nonatomic, nullable) NSString *AVSZip;

// Valid values = off or on. Determines whether CVV field is displayed. Default is on.
@property (assign, nonatomic) BOOL CVV;

// Customer Code.
@property (strong, nonatomic, nullable) NSString *customerCode;

// Values are on and off. Default is off. The timeout indicator will count down to 0 and then redirect.
// iFrame size must be increased to 600 X 600 if FontSize = large or 550 X 500 if FontSize = medium.
@property (assign, nonatomic) BOOL pageTimeoutIndicator;

// Indicates whether the Order Total box will be displayed on the page. This only applies to iFrame. Valid values are on and off. Default is on.
@property (assign, nonatomic) BOOL orderTotal;

- (void)js_mercury_transaction:(nullable kJSMercuryInitializeBlock)completion;
@end
