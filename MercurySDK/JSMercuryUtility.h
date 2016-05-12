//
//  JSMercuryUtility.h
//  Mercury Hosted Checkout
//
//  Created by John Setting on 4/18/16.
//  Copyright © 2016 Mercury. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSMercuryVerify.h"
#import "JSMercuryTypeDef.h"
#import "JSMercuryInitializeResponse.h"
#import "JSMercuryInitialize.h"
#import "Address.h"
#import "VerifyCardInfo.h"
#import "CreditResponse.h"

@interface JSMercuryUtility : NSObject
+ (nullable instancetype)sharedInstance;
@property (strong, nonatomic, nullable) JSMercuryVerify *verificationObject;
@property (strong, nonatomic, nullable) JSMercuryInitializeResponse *initializeResponse;
@property (strong, nonatomic, nullable) JSMercuryInitialize *initializer;

+ (void)printRequest:(nullable NSURLRequest *)r withBenchmark:(nullable NSDate *)date;
+ (void)printRequest:(nullable NSURLRequest *)r withSession:(nullable NSURLSession *)session withBenchmark:(nullable NSDate *)date;

+ (nullable NSString *)convertNumberToStringCurrency:(nullable NSNumber *)number;
+ (nullable NSNumber *)convertStringCurrencyToNumber:(nullable NSString *)string;
+ (BOOL)isValidHex:(nullable NSString *)hex;
+ (nullable NSString *)js_mercury_transaction_type:(kJSMercuryTransactionType)type;
+ (nullable NSString *)js_mercury_frequency_type:(kJSMercuryTransactionFrequencyType)type;
+ (nullable NSString *)js_mercury_checkout_style_type:(kJSMercuryCheckoutPageStyle)type;
+ (nullable NSString *)js_mercury_avs_fields:(kJSMercuryTransactionAVSFields)type;
+ (BOOL)checkField:(nullable id)field;
+ (nonnull UIImage *)cardImage:(nullable NSString *)cardType;
+ (nonnull NSString *)appTitle;
+ (nonnull NSString *)appVersion;
+ (nonnull NSString *)build;
+ (nonnull NSString *)versionBuild;
+ (void)showAlert:(nonnull id)target creditResponse:(nonnull CreditResponse *)response;
+ (nonnull NSString *)formattedCardBillingInformation:(nonnull VerifyCardInfo *)card address:(nonnull Address *)address;
@end
