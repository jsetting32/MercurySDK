//
//  JSMercuryVerifyCardInfo.m
//  MercurySDK
//
//  Created by John Setting on 4/25/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSMercuryVerifyCardInfo.h"
#import "JSMercury.h"
#import "JSMercuryUtility.h"
#import "JSMercuryTypeDef.h"
#import "JSMercuryConstants.h"

@implementation JSMercuryVerifyCardInfo

- (instancetype)initWithResponse:(NSDictionary *)response {
    if (!(self = [super initWithResponse:response])) return nil;
    [self commonInit:response];
    return self;
}

- (void)commonInit:(NSDictionary *)response {
    self.cardUsage = [response objectForKey:@"CardUsage"];
    self.operatorId = [response objectForKey:@"OperatorID"];
    self.cardIdExpired = [[response objectForKey:@"CardIDExpired"] boolValue];
}

- (void)js_verify_cardInfo:(void (^)(JSMercuryVerifyCardInfo * _Nullable, NSError * _Nullable))completion {
    self.completionBlock = [completion copy];
    
    NSMutableDictionary *dictionaryReq = [NSMutableDictionary new];
    [dictionaryReq setObject:[[JSMercuryUtility sharedInstance] initializeResponse].cardId forKey:@"CardID"];
    
    HCMercuryHelper *mgh = [HCMercuryHelper new];
    mgh.delegate = self;
    [mgh actionFromDictionary:dictionaryReq actionType:MERCURY_ACTION_VERIFY_CARD_INFO];
}

- (void)hcTransactionDidFinish:(NSDictionary *)result {
    if (self.completionBlock) {
        JSMercuryVerifyCardInfo *verify = [[JSMercuryVerifyCardInfo alloc] initWithResponse:result];
        NSError *error = nil;
        BOOL coreData = [[[JSMercuryAPIClient sharedClient] coreDataKey] boolValue];
        if (coreData) {
            if (![VerifyCardInfo createVerifyCardInfo:verify error:error]) {
                NSLog(@"%@", error);
            }
        }
        self.completionBlock(verify, nil);
    }
}

- (void)hcTransactionDidFailWithError:(NSError *)error {
    if (self.completionBlock) {
        self.completionBlock(nil, error);
    }
}

@end
