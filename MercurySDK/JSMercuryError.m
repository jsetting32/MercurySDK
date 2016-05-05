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
    if (errorCode == 0) return nil;
    if (errorCode == 100) return [NSError errorWithDomain:@"com.logiciel" code:errorCode userInfo:@{NSLocalizedDescriptionKey : @"Authentication Error",
                                                                                                    NSLocalizedFailureReasonErrorKey : @"Interacting with Mercury's Web services require a valid Merchant ID and Password. Please verify these fields are correct",
                                                                                                    NSLocalizedRecoverySuggestionErrorKey : response}];
    if (errorCode == 200) return [NSError errorWithDomain:@"com.logiciel" code:errorCode userInfo:@{NSLocalizedDescriptionKey : @"Internal Error",
                                                                                                    NSLocalizedFailureReasonErrorKey : @"Mercury's servers are acting up. Please try again",
                                                                                                    NSLocalizedRecoverySuggestionErrorKey : response}];
    if (errorCode == 300) return [NSError errorWithDomain:@"com.logiciel" code:errorCode userInfo:@{NSLocalizedDescriptionKey : @"Internal Error",
                                                                                                    NSLocalizedFailureReasonErrorKey : @"Mercury's servers are acting up. Please try again",
                                                                                                    NSLocalizedRecoverySuggestionErrorKey : response}];
    return nil;
}

@end
