//
//  JSMercuryCreditToken.h
//  MercurySDK
//
//  Created by John Setting on 4/25/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSMercuryTypeDef.h"
#import "HCMercuryHelper.h"
#import "VerifyPayment.h"
#import "VerifyCardInfo.h"
#import "JSMercuryCreditTokenResponse.h"

// MToken is VIP’s proprietary technology that replaces sensitive card data with non-sensitive reference data for long-term data storage. It has become popular as a means of reducing the risk, cost, and complexity of credit card processing. The actual card number is used only when submitted by the user on the HostedCheckout web page. After the transaction is processed by HostedCheckout the token is retrieved using the VerifyPayment or VerifyCardInfo web methods. The token can be used to perform subsequent transactions for the same card. This can be used for capturing a PreAuth, voiding or reversing a transaction in the current batch, returning a previous transaction, card-on-file, or recurring billing.
@interface JSMercuryCreditToken : NSObject <HCMercuryHelperDelegate>

- (nullable instancetype)initWithToken:(nonnull NSString *)token;
- (nullable instancetype)initWithResponse:(nonnull CreditResponse *)response;


@property (strong, nonatomic, nonnull) kJSMercuryObjectBlock completionBlock;

// Customer Card Holder Name as it appears on card.
@property (strong, nonatomic, nullable) NSString *cardHolderName;

// OneTime or Recurring
@property (assign, nonatomic) kJSMercuryTransactionFrequencyType frequency;

// Invoice Number from the eCommerce site. It will be used for both the Invoice and the RefNo fields when
// the pre-auth is submitted. Invoice Number must be unique.
@property (strong, nonatomic, nonnull) NSString *invoice;

// The Memo tag is the product name and version number of the developer’s software.
@property (strong, nonatomic, nonnull) NSString *memo;

// Operator ID
@property (strong, nonatomic, nullable) NSString *operatorId;

// Terminal Name
@property (strong, nonatomic, nullable) NSString *terminalName;

// The token generated by a PreAuth transaction that replaces the credit card #. Can be used in
// subsequent transactions.
@property (strong, nonatomic, nonnull) NSString *token;

- (nonnull NSMutableDictionary *)generateParameters:(nullable NSMutableArray *)emptyParameters error:(NSError * _Nullable * _Nullable)error;
+ (nullable NSError *)errorWithParameters:(nullable NSMutableArray *)parameters;
- (void)js_mercury_credit_token:(void (^ _Nullable)(JSMercuryCreditTokenResponse * _Nullable response, NSError * _Nullable error))completion;
@end
