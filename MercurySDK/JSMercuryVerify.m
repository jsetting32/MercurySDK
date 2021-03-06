//
//  JSMercuryVerify.m
//  MercurySDK
//
//  Created by John Setting on 4/19/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSMercuryVerify.h"

@implementation JSMercuryVerify

- (instancetype)initWithResponse:(NSDictionary *)response {
    if (!(self = [super init])) return nil;
    _cardType = [response objectForKey:@"CardType"];
    
    NSString *card = [response objectForKey:@"CardHolderName"];
    if (!card) card = [response objectForKey:@"CardholderName"];
    _cardHolderName = card;
    
    _displayMessage = [response objectForKey:@"DisplayMessage"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMyy"];
    _expDate = [formatter dateFromString:[response objectForKey:@"ExpDate"]];
    
    _maskedAccount = [response objectForKey:@"MaskedAccount"];
    _responseCode = @([[response objectForKey:@"ResponseCode"] integerValue]);
    _status = [response objectForKey:@"Status"];
    _statusMessage = [response objectForKey:@"StatusMessage"];
    _token = [response objectForKey:@"Token"];
    _tranType = [response objectForKey:@"TranType"];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:6];
    _tokenExpireDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];

    return self;
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
