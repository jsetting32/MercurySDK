//
//  JSMercuryInitialize.m
//  MercurySDK
//
//  Created by John Setting on 4/22/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSMercuryInitialize.h"
#import "JSMercuryTypeDef.h"
#import "JSMercuryUtility.h"
#import "JSMercury.h"

@implementation JSMercuryInitialize

+ (instancetype)js_init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (instancetype)init {
    if (!(self = [super init])) return nil;
    _frequency = kJSMercuryTransactionFrequencyTypeOnce;
    _cardHolderName = nil;
    _processCompleteUrl = @"COMPLETED";
    _returnUrl = @"CANCELED";
    _pageTimeoutDuration = @0;
    _displayStyle = kJSMercuryCheckoutPageStyleMercury;
    _backgroundColor = nil;
    _fontColor = nil;
    _fontFamily = nil;
    _fontSize = nil;
    _logoUrl = nil;
    _pageTitle = nil;
    _submitButtonText = nil;
    _cancelButtonText = nil;
    _buttonTextColor = nil;
    _buttonBackgroundColor = nil;
    _cancelButton = NO;
    _JCB = YES;
    _Diners = YES;
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


- (nonnull NSMutableDictionary *)generateParameters {
    if ([[[JSMercuryAPIClient sharedClient] production] boolValue]) {
        BOOL check = YES;
        check = [JSMercuryUtility checkField:self.processCompleteUrl];
        check = [JSMercuryUtility checkField:self.returnUrl];
        if (!check) return nil;
    } else {
        NSAssert([JSMercuryUtility checkField:self.processCompleteUrl], @"processCompleteUrl must be used for initializing requests");
        NSAssert([JSMercuryUtility checkField:self.returnUrl], @"returnUrl must be used for initializing requests");
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[JSMercuryUtility js_mercury_frequency_type:self.frequency] forKey:@"Frequency"];
    if ([JSMercuryUtility checkField:self.cardHolderName]) [parameters setObject:self.cardHolderName forKey:@"CardHolderName"];
    [parameters setObject:self.processCompleteUrl forKey:@"ProcessCompleteUrl"];
    [parameters setObject:self.returnUrl forKey:@"ReturnUrl"];
    if ([JSMercuryUtility checkField:self.pageTimeoutDuration]) [parameters setObject:self.pageTimeoutDuration forKey:@"PageTimeoutDuration"];
    [parameters setObject:[JSMercuryUtility js_mercury_checkout_style_type:self.displayStyle] forKey:@"DisplayStyle"];
    if ([JSMercuryUtility checkField:self.backgroundColor]) [parameters setObject:self.backgroundColor forKey:@"BackgroundColor"];
    if ([JSMercuryUtility checkField:self.fontColor]) [parameters setObject:self.fontColor forKey:@"FontColor"];
    if ([JSMercuryUtility checkField:self.fontFamily]) [parameters setObject:self.fontFamily forKey:@"FontFamily"];
    if ([JSMercuryUtility checkField:self.fontSize]) [parameters setObject:self.fontSize forKey:@"FontSize"];
    if ([JSMercuryUtility checkField:self.logoUrl]) [parameters setObject:self.logoUrl forKey:@"LogoUrl"];
    if ([JSMercuryUtility checkField:self.pageTitle]) [parameters setObject:self.pageTitle forKey:@"PageTitle"];
    if ([JSMercuryUtility checkField:self.submitButtonText]) [parameters setObject:self.submitButtonText forKey:@"SubmitButtonText"];
    if ([JSMercuryUtility checkField:self.cancelButtonText]) [parameters setObject:self.cancelButtonText forKey:@"CancelButtonText"];
    if ([JSMercuryUtility checkField:self.buttonTextColor]) [parameters setObject:self.buttonTextColor forKey:@"ButtonTextColor"];
    if ([JSMercuryUtility checkField:self.buttonBackgroundColor]) [parameters setObject:self.buttonBackgroundColor forKey:@"ButtonBackgroundColor"];
    [parameters setObject:self.cancelButton ? @"On" : @"Off" forKey:@"CancelButton"];
    [parameters setObject:self.JCB ? @"On" : @"Off" forKey:@"JCB"];
    [parameters setObject:self.Diners ? @"On" : @"Off" forKey:@"Diners"];
    return parameters;
}

@end
