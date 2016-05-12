//
//  JSMercuryCreditTokenResponse.h
//  MercurySDK
//
//  Created by John Setting on 4/25/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSMercuryCreditTokenResponse : NSObject

- (nullable instancetype)initWithResponse:(nonnull NSDictionary *)response action:(nonnull NSString *)action;

// The action made for the response
@property (strong, nonatomic, nonnull) NSString *action;

// The masked account number used for the transaction.
@property (strong, nonatomic, nonnull) NSString *account;

// Acquirer Reference Data
@property (strong, nonatomic, nonnull) NSString *acqRefData;

// Authorization code.
@property (strong, nonatomic, nonnull) NSString *authCode;

// The amount that the transaction was authorized for. If this amount is less than the PurchaseAmount field,
// then payment in full has not been received and additional tender will need to be requested.
@property (strong, nonatomic, nonnull) NSNumber *authorizeAmount;

// The result of the AVS check. AVSResult codes are in the Platform Integration Guide and there is a
// different list per card type.
@property (strong, nonatomic, nonnull) NSString *avsResult;

// Batch # of transaction if applicable
@property (strong, nonatomic, nonnull) NSString *batchNo;

// Type of card used to make the payment
@property (strong, nonatomic, nonnull) NSString *cardType;

// Result of the CVV check. M=match
// N=no match
// P=not processed
// S=CVV should be on card but merchant indicated it is not present (Visa/Discover only)
// U=Issuer is Not Certified, CID not checked (AMEX only)
@property (strong, nonatomic, nonnull) NSString *cvvResult;

// Tip (gratuity) amount (with 2-place decimal – e.g., 5.00)
@property (strong, nonatomic, nonnull) NSNumber *gratuityAmount;

// Invoice # of the transaction
@property (strong, nonatomic, nonnull) NSString *invoice;

// Transaction status message or concatenated validation error messages.
@property (strong, nonatomic, nonnull) NSString *message;

// ProcessData
@property (strong, nonatomic, nonnull) NSString *processData;

// Purchase price (with 2-place decimal – e.g., 29.25)
@property (strong, nonatomic, nonnull) NSNumber *purchaseAmount;

// Transaction Reference Number
@property (strong, nonatomic, nonnull) NSString *refNo;

// The status of the transaction. The Message field contains additional information.
// Approved. The transaction was approved.
// Declined. The transaction was declined.
// Error. A transaction processing error occurred.
// AuthFail. Authentication failed for MerchantID/password. MercuryInternalFail. An error occurred internal to VIP.
// ValidateFail. Validation of the request failed. See Message for validation errors.
@property (strong, nonatomic, nonnull) NSString *status;

// The token generated by the transaction that replaces the credit card #. Can be used in subsequent transactions.
@property (strong, nonatomic, nonnull) NSString *token;

@end
