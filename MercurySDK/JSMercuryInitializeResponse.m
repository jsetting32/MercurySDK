//
//  JSMercuryInitializeResponse.m
//  Fora
//
//  Created by John Setting on 4/26/16.
//  Copyright © 2016 Logiciel Inc. All rights reserved.
//

#import "JSMercuryInitializeResponse.h"

@implementation JSMercuryInitializeResponse

- (instancetype)initWithResponse:(NSDictionary *)response {
    if (!(self = [super init])) return nil;
    _responseCode = [response objectForKey:@"ResponseCode"];
    _paymentId = [response objectForKey:@"PaymentID"];
    _cardId = [response objectForKey:@"CardID"];
    _message = [response objectForKey:@"Message"];
    return self;
}

@end
