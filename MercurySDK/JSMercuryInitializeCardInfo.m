//
//  JSMercuryInitializeCardInfo.m
//  MercurySDK
//
//  Created by John Setting on 4/22/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSMercuryInitializeCardInfo.h"
#import "HCMercuryHelper.h"
#import "JSMercuryUtility.h"
#import "JSMercuryWebViewController.h"
#import "JSMercuryConstants.h"

@interface JSMercuryInitializeCardInfo() <HCMercuryHelperDelegate>
@end

@implementation JSMercuryInitializeCardInfo

+ (instancetype)js_init { return [[self alloc] init]; }

- (instancetype)init {
    if (!(self = [super init])) return nil;
    _operatorID = nil;
    return self;
}

#pragma mark <HCMercuryHelperDelegate>
- (void)hcTransactionDidFinish:(NSDictionary *)result {
    if (self.completionBlock) {
        JSMercuryUtility *utility = [JSMercuryUtility sharedInstance];
        JSMercuryInitializeResponse *response = [[JSMercuryInitializeResponse alloc] initWithResponse:result];
        [utility setInitializeResponse:response];
        [utility setInitializer:self];
        
        NSAssert(utility.initializeResponse.cardId, @"There must be a valid cardId to render the Hosted Checkout Page");
        NSString *pidURL = [NSString stringWithFormat:@"https://hc.mercurycert.net/CardInfoiFrame.aspx?cardid=%@", utility.initializeResponse.cardId];
//        NSString *pidURL = [NSString stringWithFormat:@"https://hc.mercurycert.net/CardInfo.aspx?cid=%@", utility.initializeResponse.cardId];
//        NSString *pidURL = [NSString stringWithFormat:@"https://hc.mercurycert.net/mobile/mCardInfo.aspx?cid=%@", utility.initializeResponse.cardId];
        NSURL *url = [NSURL URLWithString:pidURL];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"JSMercuryWebViewStoryboard" bundle:nil];
        UINavigationController *nav = [storyboard instantiateInitialViewController];
        JSMercuryWebViewController *web = [[nav viewControllers] firstObject];
        web.webRequest = requestObj;
        self.completionBlock(nav, web, nil);
    }
}

- (void)hcTransactionDidFailWithError:(NSError *)error {
    if (self.completionBlock) {
        self.completionBlock(nil, nil, error);
    }
}

- (void)js_mercury_transaction:(kJSMercuryInitializeBlock)completion {
    self.completionBlock = [completion copy];
    HCMercuryHelper *mgh = [HCMercuryHelper new];
    mgh.delegate = self;
    [mgh actionFromDictionary:[self generateParameters] actionType:MERCURY_ACTION_INITIALIZE_CARD_INFO];
}

- (NSMutableDictionary *)generateParameters {
    NSMutableDictionary *parameters = [super generateParameters];
    if ([JSMercuryUtility checkField:self.operatorID]) [parameters setObject:self.operatorID forKey:@"OperatorID"];
    return parameters;
}

@end
