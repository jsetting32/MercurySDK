//
//  JSMercuryCreditToken.m
//  MercurySDK
//
//  Created by John Setting on 4/25/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSMercuryCreditToken.h"
#import "JSMercury.h"
#import "JSMercuryUtility.h"

@implementation JSMercuryCreditToken

- (instancetype)initWithToken:(NSString *)token {
    if (!(self = [super init])) return nil;
    _cardHolderName = nil;
    _frequency = kJSMercuryTransactionFrequencyTypeOnce;
    _invoice = @"";
    _memo = [NSString stringWithFormat:@"%@ - %@", [JSMercuryUtility appTitle], [JSMercuryUtility appVersion]];
    _operatorId = nil;
    _token = token;
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"You must use initWithToken: as the initializer"
                                 userInfo:nil];
}

- (NSMutableDictionary *)generateParameters:(NSMutableArray *)emptyParameters error:(NSError *__autoreleasing  _Nullable *)error
{
    if ([[[JSMercuryAPIClient sharedClient] production] boolValue]) {

    } else {
        if (![JSMercuryUtility checkField:self.invoice]) [emptyParameters addObject:@"Invoice"];
        if (![JSMercuryUtility checkField:self.memo]) [emptyParameters addObject:@"Memo"];
        if (![JSMercuryUtility checkField:self.token]) [emptyParameters addObject:@"Token"];
        if ([emptyParameters count] > 0) return nil;
//        NSAssert([JSMercuryUtility checkField:self.invoice], @"Invoice must have some value for credit tokens");
//        NSAssert([JSMercuryUtility checkField:self.memo], @"Memo must have some value for credit tokens");
//        NSAssert([JSMercuryUtility checkField:self.token], @"Token must have some value for credit tokens");
    }

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if ([JSMercuryUtility checkField:self.cardHolderName]) [parameters setObject:self.cardHolderName forKey:@"CardHolderName"];
    [parameters setObject:[JSMercuryUtility js_mercury_frequency_type:self.frequency] forKey:@"Frequency"];
    [parameters setObject:self.invoice forKey:@"Invoice"];
    [parameters setObject:self.memo forKey:@"Memo"];
    if ([JSMercuryUtility checkField:self.operatorId]) [parameters setObject:self.operatorId forKey:@"OperatorID"];
    [parameters setObject:self.token forKey:@"Token"];
    return parameters;
}

+ (NSError *)errorWithParameters:(NSMutableArray *)parameters {
    return [NSError errorWithDomain:MERCURY_WEB_SERVICE_ERROR_DOMAIN code:400 userInfo:@{NSLocalizedDescriptionKey : @"Error Generating Request",
                                                                                         NSLocalizedFailureReasonErrorKey : [NSString stringWithFormat:@"Field(s) : '%@' need to be added in order to made a token request", [parameters componentsJoinedByString:@", "]]}];
}

- (void)hcTransactionDidFinish:(NSDictionary *)result {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (void)hcTransactionDidFailWithError:(NSError *)error {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end
