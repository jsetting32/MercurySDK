//
//  JSMercuryVerifyPayment.h
//  MercurySDK
//
//  Created by John Setting on 4/25/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSMercuryVerify.h"

@interface JSMercuryVerifyPayment : JSMercuryVerify

// Required for PreAuthCapture and PreAuth Reversal
@property (strong, nonatomic, nonnull) NSString *acqRefData;

// The amount of the transaction
@property (strong, nonatomic, nonnull) NSNumber *amount;

// The Authorization Code. Required for PreAuthCapture.
@property (strong, nonatomic, nonnull) NSString *authCode;

// Address used for AVS verification. Note it is truncated to 8 characters.
@property (strong, nonatomic, nonnull) NSString *AVSAddress;

/*
 * The result of the AVS check. AVSResult codes are in the Global Spec and there is a different list per card type.
 * Suggested message upon AVS mismatch: The billing address provided does not match the billing address on file.
 * Please verify that the billing address provided matches the billing address on file with the card issuer.
 * If you continue to experience problems, please contact your credit card company.
 */
@property (strong, nonatomic, nonnull) NSString *AVSResult;

// Postal code used for AVS verification.
@property (strong, nonatomic, nonnull) NSString *AVSZip;


// The customer code passed in InitializePayment.
@property (strong, nonatomic, nonnull) NSString *customerCode;

/*
 * Result of the CVV check. Values: M=Match
 * N=No Match
 * P=Not Processed
 * S=CVV should be on card but merchant indicated it is not present (Visa/Discover only)
 * U=Issuer is Not Certified, CID not checked (AMEX only)
 */
@property (strong, nonatomic, nonnull) NSString *CVVResult;

// VIP responds back with the Invoice passed to us on the HostedCheckout request.
@property (strong, nonatomic, nonnull) NSString *invoice;


// The Memo tag is the product name and version number of the developers software.
@property (strong, nonatomic, nonnull) NSString *memo;

/*
 * If the paymentID has been used to make a payment (even if they payment was declined or had an error),
 * or if the session timed out while the user was on the HostedCheckout page, then this will be true.
 * Otherwise, this will be false. Once the payment ID is set to Expired, it may not be used again to make a payment.
 * The payment process must be started again with InitializePayment.
 */
@property (strong, nonatomic, nonnull) NSNumber *paymentIDExpired;

// Required for PreAuthReversal.
@property (strong, nonatomic, nonnull) NSString *processData;

// Transaction reference number. Required for VoidSale.
@property (strong, nonatomic, nonnull) NSString *refNo;

// The tax amount of the transaction, passed in InitializePayment.
@property (strong, nonatomic, nonnull) NSNumber *taxAmount;

// The date/time that the transaction occurred in EST. If it is 1/1/0001 this is equivalent to blank or Null.
@property (strong, nonatomic, nonnull) NSDate *transPostTime;

/*
 * The VerifyPayment method in the HostedCheckout web service must be called to find out the status of a payment. 
 * This allows the eCommerce developer to get the status and additional information about the payment after VIP 
 * has processed it.
 * !Important Note VerifyPayment is a polling service and should be used judiciously:
 * 1. When you initiate the payment process (Step 1 above), set PageTimeoutDuration to 5, which sets the 
 * timeout for 5 minutes. You can optionally have the timeout indicator display by using the TimeoutIndicator 
 * API call.
 * 2. Call VerifyPayment for no longer than 5 minutes per transaction. After this time, you will know that 
 * the transaction was not completed.
 * 3. Stop calling VerifyPayment as soon as a status (Approved, Declined, Error, etc.) is received.
 * 4. Stop calling VerifyPayment if the PostBack to your page from HostedCheckout succeeds.
 * 5. Call VerifyPayment at most at an interval of once every 5 seconds, preferably once every 10 seconds.
 */
- (void)js_verify_payment:(void (^ _Nullable )(JSMercuryVerifyPayment * _Nullable verification, NSError * _Nullable error))completion;
@end
