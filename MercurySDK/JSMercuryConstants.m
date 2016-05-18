//
//  JSMercuryConstants.m
//  MercurySDK
//
//  Created by John Setting on 4/19/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSMercuryConstants.h"

NSString * const MERCURY_WEB_SERVICE_ERROR_DOMAIN               = @"com.mercury.vantiv";
NSString * const MERCURY_WEB_SERVICE_URL_DEVELOPMENT            = @"https://hc.mercurycert.net";
NSString * const MERCURY_WEB_SERVICE_URL_PRODUCTION             = @"https://hc.mercurypay.com";
NSString * const MERCURY_WEB_SERVICE_ENDPOINT                   = @"/hcws/hcservice.asmx";
NSString * const MERCURY_WEB_SERVICE_TOKENIZATION_ENDPOINT      = @"/tws/transactionservice.asmx";

NSString * const MERCURY_ACTION_INITIALIZE_PAYMENT              = @"InitializePayment";
NSString * const MERCURY_ACTION_INITIALIZE_CARD_INFO            = @"InitializeCardInfo";
NSString * const MERCURY_ACTION_VERIFY_PAYMENT                  = @"VerifyPayment";
NSString * const MERCURY_ACTION_VERIFY_CARD_INFO                = @"VerifyCardInfo";
NSString * const MERCURY_ACTION_CREDIT_TOKEN_PRE_AUTH           = @"CreditPreAuthToken";
NSString * const MERCURY_ACTION_CREDIT_TOKEN_PRE_AUTH_CAPTURE   = @"CreditPreAuthCaptureToken";
NSString * const MERCURY_ACTION_CREDIT_TOKEN_SALE               = @"CreditSaleToken";
NSString * const MERCURY_ACTION_CREDIT_TOKEN_ADJUST             = @"CreditAdjustToken";
NSString * const MERCURY_ACTION_CREDIT_TOKEN_VOID_SALE          = @"CreditVoidSaleToken";
NSString * const MERCURY_ACTION_CREDIT_TOKEN_REVERSAL           = @"CreditReversalToken";
NSString * const MERCURY_ACTION_CREDIT_TOKEN_RETURN             = @"CreditReturnToken";
NSString * const MERCURY_ACTION_CREDIT_TOKEN_VOID_RETURN        = @"CreditVoidReturnToken";