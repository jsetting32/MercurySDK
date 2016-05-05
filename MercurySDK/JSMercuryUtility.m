//
//  JSMercuryConstants.m
//  Mercury Hosted Checkout
//
//  Created by John Setting on 4/18/16.
//  Copyright © 2016 Mercury. All rights reserved.
//

#import "JSMercuryUtility.h"
#import "JSMercuryTypeDef.h"

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

@end
