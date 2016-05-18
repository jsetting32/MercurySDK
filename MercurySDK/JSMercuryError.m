//
//  JSMercuryError.m
//  Mercury Hosted Checkout
//
//  Created by John Setting on 4/18/16.
//  Copyright © 2016 Mercury. All rights reserved.
//

#import "JSMercuryError.h"

@implementation JSMercuryError

+ (NSError *)js_mercury_error:(NSInteger)errorCode response:(NSString *)response {
    if (errorCode == 0 || !response) return nil;
    if (errorCode == 100) return [NSError errorWithDomain:@"com.logiciel"
                                                     code:errorCode
                                                 userInfo:@{NSLocalizedDescriptionKey : @"Authentication Error",
                                                            NSLocalizedFailureReasonErrorKey : @"Interacting with Mercury's Web services require a valid Merchant ID and Password. Please verify these fields are correct",
                                                            NSLocalizedRecoverySuggestionErrorKey : response}];
    if (errorCode == 200) return [NSError errorWithDomain:@"com.logiciel"
                                                     code:errorCode
                                                 userInfo:@{NSLocalizedDescriptionKey : @"Internal Error",
                                                            NSLocalizedFailureReasonErrorKey : @"Mercury's servers are acting up. Please try again",
                                                            NSLocalizedRecoverySuggestionErrorKey : response}];
    if (errorCode == 300) return [NSError errorWithDomain:@"com.logiciel"
                                                     code:errorCode
                                                 userInfo:@{NSLocalizedDescriptionKey : @"Internal Error",
                                                            NSLocalizedFailureReasonErrorKey : @"Mercury's servers are acting up. Please try again",
                                                            NSLocalizedRecoverySuggestionErrorKey : response}];
    return nil;
}

+ (NSError *)communicationError:(NSInteger)errorCode response:(NSString *)response {
    if ([response containsString:@"EDC UNAVAILABLE"] ||
        [response containsString:@"DB UNAVAIL"] ||
        [response containsString:@"TIMEOUT ON RESPONSE"] ||
        [response containsString:@"TIMEOUT WAITING FOR RESPONSE"] ||
        [response containsString:@"MAX CONNECTION ERROR"] ||
        [response containsString:@"SOCKET CONNECTION FAILED"] ||
        [response containsString:@"NO CONNECTION TO ANY SERVER"] ||
        [response containsString:@"HOST UNAVAIL"] ||
        [response containsString:@"ISSUER UNAVAIL"]) {
        return [NSError errorWithDomain:@"com.logiciel"
                                   code:errorCode
                               userInfo:@{NSLocalizedDescriptionKey : @"Connection Error",
                                          NSLocalizedFailureReasonErrorKey : @"We’re sorry. We are experiencing a temporary connectivity error. Please try again",
                                          NSLocalizedRecoverySuggestionErrorKey : response}];
    }
    return nil;
}

+ (NSError *)transactionDeclined:(NSInteger)errorCode response:(NSString *)response {
    if ([response containsString:@"DECLINED"] ||
        [response containsString:@"OTHER NOT EXCEPTED"] ||
        [response containsString:@"PIC UP"] ||
        [response containsString:@"EXCEEDS MAX AMT"] ||
        [response containsString:@"DECLINE TRY LATER"]) {
        return [NSError errorWithDomain:@"com.logiciel"
                                   code:errorCode
                               userInfo:@{NSLocalizedDescriptionKey : @"Unable to Process Transaction",
                                          NSLocalizedFailureReasonErrorKey : @"We’re sorry, your transaction has declined",
                                          NSLocalizedRecoverySuggestionErrorKey : response}];
    }
    return nil;
}

+ (NSError *)transactionInvalidData:(NSInteger)errorCode response:(NSString *)response {
    if ([response containsString:@"INVLD ACCT"] ||
        [response containsString:@"INVALID EX DATE"] ||
        [response containsString:@"INVALID REFERENCE NUMBER"] ||
        [response containsString:@"INVLD TRAN CODE"] ||
        [response containsString:@"INVALID FIELD"]) {
        return [NSError errorWithDomain:@"com.logiciel"
                                   code:errorCode
                               userInfo:@{NSLocalizedDescriptionKey : @"Unable to Process Transaction",
                                          NSLocalizedFailureReasonErrorKey : @"Your account information has been entered incorrectly. Please try again",
                                          NSLocalizedRecoverySuggestionErrorKey : response}];
    }
    return nil;
}

+ (NSError *)transactionDuplicateTransaction:(NSInteger)errorCode response:(NSString *)response {
    if ([response containsString:@"AP*"] ||
        [response containsString:@"AP DUPE"]) {
        return [NSError errorWithDomain:@"com.logiciel"
                                   code:errorCode
                               userInfo:@{NSLocalizedDescriptionKey : @"Unable to Process Transaction",
                                          NSLocalizedFailureReasonErrorKey : @"Duplicate transaction data has been entered. Transaction declined",
                                          NSLocalizedRecoverySuggestionErrorKey : response}];
    }
    return nil;
}

+ (NSError *)transactionCallReferral:(NSInteger)errorCode response:(NSString *)response {
    if ([response containsString:@"CALL AE"] ||
        [response containsString:@"CALL DISCOVER"] ||
        [response containsString:@"CALL ND"] ||
        [response containsString:@"CALL XXXX"]) {
        return [NSError errorWithDomain:@"com.logiciel" code:errorCode userInfo:@{NSLocalizedDescriptionKey : @"Unable to Process Transaction",
                                                                                  NSLocalizedFailureReasonErrorKey : @"Your transaction has declined: please contact us at ###-###-#### to complete your transaction",
                                                                                  NSLocalizedRecoverySuggestionErrorKey : response}];
    }
    return nil;
}

@end
