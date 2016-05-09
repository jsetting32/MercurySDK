//
//  JSMercuryConstants.m
//  Mercury Hosted Checkout
//
//  Created by John Setting on 4/18/16.
//  Copyright © 2016 Mercury. All rights reserved.
//

#import "JSMercuryUtility.h"
#import "JSMercuryTypeDef.h"
#import "JSMercuryCreditTokenSale.h"
#import "JSMercuryCreditTokenAdjust.h"
#import "JSMercuryCreditTokenReturn.h"
#import "JSMercuryCreditTokenPreAuth.h"
#import "JSMercuryCreditTokenReversal.h"
#import "JSMercuryCreditTokenVoidSale.h"
#import "JSMercuryCreditTokenVoidReturn.h"
#import "JSMercuryCreditTokenPreAuthCapture.h"

@implementation JSMercuryUtility

+ (instancetype)sharedInstance {
    static JSMercuryUtility *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

+ (void)printRequest:(NSURLRequest *)r withBenchmark:(NSDate *)date {
    [JSMercuryUtility printRequest:r withSession:nil withBenchmark:date];
}

+ (void)printRequest:(NSURLRequest *)r withSession:(NSURLSession *)session withBenchmark:(NSDate *)date {
    NSError *error = nil;
    if (r.HTTPBody) {
        id json = [NSJSONSerialization JSONObjectWithData:r.HTTPBody
                                                  options:kNilOptions
                                                    error:&error];
        if (!json || [json isKindOfClass:[NSNull class]] || [json isEqual:[NSNull null]]) {
            json = [NSKeyedUnarchiver unarchiveObjectWithData:r.HTTPBody];
        }
        
        if (!json || [json isKindOfClass:[NSNull class]] || [json isEqual:[NSNull null]]) {
            json = [NSString stringWithUTF8String:[r.HTTPBody bytes]];
        }
        
        if (date) {
            NSLog(@"\n\nURL = %@\nURL = %@ (DECODED)\nMETHOD = %@\nHEADERS = %@\nBODY = %@\n\n\n",
                  r.URL, [[r.URL absoluteString] stringByRemovingPercentEncoding], r.HTTPMethod, (session) ? session.configuration.HTTPAdditionalHeaders : r.allHTTPHeaderFields, json/*, [FLUtility generateSQLQuery:[r.URL absoluteString] body:json]*/);
        } else {
            NSLog(@"\n\nURL = %@\nURL = %@ (DECODED)\nMETHOD = %@\nHEADERS = %@\nBODY = %@\nTime Executed = %f\n\n\n",
                  r.URL, [[r.URL absoluteString] stringByRemovingPercentEncoding], r.HTTPMethod, (session) ? session.configuration.HTTPAdditionalHeaders : r.allHTTPHeaderFields, json, [[NSDate date] timeIntervalSinceDate:date]
                  /*, [FLUtility generateSQLQuery:[r.URL absoluteString] body:json]*/);
        }
    } else {
        if (date) {
            NSLog(@"\n\nURL = %@\nURL = %@ (DECODED)\nMETHOD = %@\nHEADERS = %@\nTime Executed = %f\n\n\n",
                  r.URL, [[r.URL absoluteString] stringByRemovingPercentEncoding], r.HTTPMethod, (session) ? session.configuration.HTTPAdditionalHeaders : r.allHTTPHeaderFields, [[NSDate date] timeIntervalSinceDate:date]
                  /*, [FLUtility generateSQLQuery:[r.URL absoluteString] body:json]*/);
        } else {
            NSLog(@"\n\nURL = %@\nURL = %@ (DECODED)\nMETHOD = %@\nHEADERS = %@\n\n\n",
                  r.URL, [[r.URL absoluteString] stringByRemovingPercentEncoding], r.HTTPMethod, (session) ? session.configuration.HTTPAdditionalHeaders : r.allHTTPHeaderFields/*, [FLUtility generateSQLQuery:[r.URL absoluteString] body:nil]*/);
        }
    }
}

+ (NSString *)convertNumberToStringCurrency:(NSNumber *)number {
    if (!number || [number floatValue] < 0) number = @0;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMinimumFractionDigits:2];
    [formatter setMaximumFractionDigits:2];
    return [formatter stringForObjectValue:number];
}

+ (NSNumber *)convertStringCurrencyToNumber:(NSString *)string {
    if (!string || [string floatValue] < 0) string = @"0";
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMinimumFractionDigits:2];
    [formatter setMaximumFractionDigits:2];
    return [formatter numberFromString:string];
}

+ (BOOL)isValidHex:(NSString *)hex {
    return (NSNotFound == [hex rangeOfCharacterFromSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEF"] invertedSet]].location);
}

+ (nullable NSString *)js_mercury_transaction_type:(kJSMercuryTransactionType)type {
    if (type == kJSMercuryTransactionTypeSale) return @"Sale";
    if (type == kJSMercuryTransactionTypePreAuth) return @"PreAuth";
    if (type == kJSMercuryTransactionTypeZeroAuth) return @"ZeroAuth";
    NSAssert(NO, @"The type must be a valid kJSMercuryTransactionType");
    return nil;
}

+ (nullable NSString *)js_mercury_frequency_type:(kJSMercuryTransactionFrequencyType)type {
    if (type == kJSMercuryTransactionFrequencyTypeOnce) return @"OneTime";
    if (type == kJSMercuryTransactionFrequencyTypeRecurring) return @"Recurring";
    NSAssert(NO, @"The type must be a valid kJSMercuryTransactionFrequencyType");
    return nil;
}

+ (nullable NSString *)js_mercury_checkout_style_type:(kJSMercuryCheckoutPageStyle)type {
    if (type == kJSMercuryCheckoutPageStyleMercury) return @"Mercury";
    if (type == kJSMercuryCheckoutPageStyleCustom) return @"Custom";
    NSAssert(NO, @"The type must be a valid kJSMercuryCheckoutPageStyle");
    return nil;
}

+ (nullable NSString *)js_mercury_avs_fields:(kJSMercuryTransactionAVSFields)type {
    if (type == kJSMercuryTransactionAVSFieldsBoth) return @"Both";
    if (type == kJSMercuryTransactionAVSFieldsZip) return @"Zip";
    if (type == kJSMercuryTransactionAVSFieldsOff) return @"Off";
    NSAssert(NO, @"The type must be a valid kJSMercuryTransactionAVSFields");
    return nil;
}

+ (BOOL)checkField:(id)field {
    if (!field) return NO;
    if ([field isKindOfClass:[NSString class]]) {
        return (field && [field length] > 0);
    }
    return field != nil;
}

+ (UIImage *)cardImage:(NSString *)cardType {
    if ([cardType isEqualToString:@"AMEX"]) return [UIImage imageNamed:@"amex"];
    if ([cardType isEqualToString:@"DANKORT"]) return [UIImage imageNamed:@"dankort"];
    if ([cardType isEqualToString:@"DINERS"]) return [UIImage imageNamed:@"diners"];
    if ([cardType isEqualToString:@"DCVR"]) return [UIImage imageNamed:@"discover"];
    if ([cardType isEqualToString:@"FORBRU"]) return [UIImage imageNamed:@"forbru"];
    if ([cardType isEqualToString:@"GOOGLE"]) return [UIImage imageNamed:@"google"];
    if ([cardType isEqualToString:@"JCB"]) return [UIImage imageNamed:@"jcb"];
    if ([cardType isEqualToString:@"LASER"]) return [UIImage imageNamed:@"laser"];
    if ([cardType isEqualToString:@"MAESTRO"]) return [UIImage imageNamed:@"maestro"];
    if ([cardType isEqualToString:@"M/C"]) return [UIImage imageNamed:@"mastercard"];
    if ([cardType isEqualToString:@"MONEY"]) return [UIImage imageNamed:@"money"];
    if ([cardType isEqualToString:@"PAYPAL"]) return [UIImage imageNamed:@"paypal"];
    if ([cardType isEqualToString:@"SHOPIFY"]) return [UIImage imageNamed:@"shipify"];
    if ([cardType isEqualToString:@"SOLO"]) return [UIImage imageNamed:@"solo"];
    if ([cardType isEqualToString:@"VISA"]) return [UIImage imageNamed:@"visa"];
    return [UIImage imageNamed:@"credit"];
}

+ (NSString *)appTitle { return [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleNameKey]; }
+ (NSString *)appVersion { return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]; }
+ (NSString *)build { return [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey]; }
+ (NSString *)versionBuild {
    NSString * version = [self appVersion];
    NSString * build = [self build];
    NSString * versionBuild = [NSString stringWithFormat:@"v%@", version];
    if (![version isEqualToString: build]) {
        versionBuild = [NSString stringWithFormat: @"%@(%@)", versionBuild, build];
    }
    return versionBuild;
}

+ (void)showAlert:(id)target card:(JSMercuryVerify *)payment {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Actions" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *adjust = [UIAlertAction actionWithTitle:@"Adjust" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        JSMercuryCreditTokenAdjust *a = [[JSMercuryCreditTokenAdjust alloc] initWithToken:payment.token];
        [a js_mercury_credit_token:^(JSMercuryCreditTokenResponse * _Nullable response, NSError * _Nullable error) {
            NSString *message = (error) ? [error localizedFailureReason] : @"Successfully made transaction action";
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Status" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:cancel];
            [target presentViewController:alert animated:YES completion:nil];
            
        }];
    }];
    UIAlertAction *preauth = [UIAlertAction actionWithTitle:@"PreAuth" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        JSMercuryCreditTokenPreAuth *preAuth = [[JSMercuryCreditTokenPreAuth alloc] initWithToken:payment.token];
        [preAuth js_mercury_credit_token:^(JSMercuryCreditTokenResponse * _Nullable response, NSError * _Nullable error) {
            NSString *message = (error) ? [error localizedFailureReason] : @"Successfully made transaction action";
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Status" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:cancel];
            [target presentViewController:alert animated:YES completion:nil];

        }];
    }];
    UIAlertAction *preauthCapture = [UIAlertAction actionWithTitle:@"PreAuthCapture" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        JSMercuryCreditTokenPreAuthCapture *preAuth = [[JSMercuryCreditTokenPreAuthCapture alloc] initWithToken:payment.token];
        [preAuth js_mercury_credit_token:^(JSMercuryCreditTokenResponse * _Nullable response, NSError * _Nullable error) {
            NSString *message = (error) ? [error localizedFailureReason] : @"Successfully made transaction action";
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Status" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:cancel];
            [target presentViewController:alert animated:YES completion:nil];
            
        }];
    }];
    UIAlertAction *returna = [UIAlertAction actionWithTitle:@"Return" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        JSMercuryCreditTokenReturn *preAuth = [[JSMercuryCreditTokenReturn alloc] initWithToken:payment.token];
        [preAuth js_mercury_credit_token:^(JSMercuryCreditTokenResponse * _Nullable response, NSError * _Nullable error) {
            NSString *message = (error) ? [error localizedFailureReason] : @"Successfully made transaction action";
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Status" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:cancel];
            [target presentViewController:alert animated:YES completion:nil];
            
        }];
    }];
    UIAlertAction *reversal = [UIAlertAction actionWithTitle:@"Reversal" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        JSMercuryCreditTokenReversal *preAuth = [[JSMercuryCreditTokenReversal alloc] initWithToken:payment.token];
        [preAuth js_mercury_credit_token:^(JSMercuryCreditTokenResponse * _Nullable response, NSError * _Nullable error) {
            NSString *message = (error) ? [error localizedFailureReason] : @"Successfully made transaction action";
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Status" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:cancel];
            [target presentViewController:alert animated:YES completion:nil];
            
        }];
        
    }];
    UIAlertAction *sale = [UIAlertAction actionWithTitle:@"Sale" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        JSMercuryCreditTokenSale *preAuth = [[JSMercuryCreditTokenSale alloc] initWithToken:payment.token];
        preAuth.purchaseAmount = @10;
        preAuth.invoice = @"1234";
        [preAuth js_mercury_credit_token:^(JSMercuryCreditTokenResponse * _Nullable response, NSError * _Nullable error) {
            NSString *message = (error) ? [error localizedFailureReason] : @"Successfully made transaction action";
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Status" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:cancel];
            [target presentViewController:alert animated:YES completion:nil];
        }];
        
    }];
    UIAlertAction *voidSale = [UIAlertAction actionWithTitle:@"VoidSale" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        JSMercuryCreditTokenVoidSale *preAuth = [[JSMercuryCreditTokenVoidSale alloc] initWithToken:payment.token];
        [preAuth js_mercury_credit_token:^(JSMercuryCreditTokenResponse * _Nullable response, NSError * _Nullable error) {
            NSString *message = (error) ? [error localizedFailureReason] : @"Successfully made transaction action";
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Status" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:cancel];
            [target presentViewController:alert animated:YES completion:nil];
            
        }];
        
    }];
    UIAlertAction *voidReturn = [UIAlertAction actionWithTitle:@"VoidReturn" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        JSMercuryCreditTokenVoidReturn *preAuth = [[JSMercuryCreditTokenVoidReturn alloc] initWithToken:payment.token];
        [preAuth js_mercury_credit_token:^(JSMercuryCreditTokenResponse * _Nullable response, NSError * _Nullable error) {
            NSString *message = (error) ? [error localizedFailureReason] : @"Successfully made transaction action";
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Status" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:cancel];
            [target presentViewController:alert animated:YES completion:nil];
            
        }];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:adjust];
    [alert addAction:preauth];
    [alert addAction:preauthCapture];
    [alert addAction:returna];
    [alert addAction:reversal];
    [alert addAction:sale];
    [alert addAction:voidSale];
    [alert addAction:voidReturn];
    [alert addAction:cancel];
    
    [target presentViewController:alert animated:YES completion:nil];
}

@end
