//
//  JSMercury.h
//  MercurySDK
//
//  Created by John Setting on 4/19/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSMercuryUtility.h"
#import "JSMercuryTypeDef.h"
#import "JSMercuryVerify.h"
#import "JSMercuryError.h"
#import "HCMercuryHelper.h"
#import "JSMercuryConstants.h"
#import "JSMercuryCoreDataController.h"

#import "JSMercuryCreditTokenAdjust.h"
#import "JSMercuryCreditTokenPreAuth.h"
#import "JSMercuryCreditTokenPreAuthCapture.h"
#import "JSMercuryCreditTokenReturn.h"
#import "JSMercuryCreditTokenReversal.h"
#import "JSMercuryCreditTokenSale.h"
#import "JSMercuryCreditTokenVoidReturn.h"
#import "JSMercuryCreditTokenVoidSale.h"


/* 
 MasterCard
 5499990123456781 0516
 ￼￼
 Visa
 4003000123456781 0516

 Amex
 373953244361001 0516

 Discover
 6011000997235373 0513
 ￼￼*/

@interface JSMercury : NSObject
+ (void)setMerchantID:(nonnull NSString *)merchantID password:(nonnull NSString *)password coreData:(BOOL)coreData production:(BOOL)production;
@end

@interface JSMercuryAPIClient : NSObject

/**
 *  A shared singleton API client. Its API key will be initially equal to [JSMercury merchantKey].
 */
+ (nonnull instancetype)sharedClient;
- (nonnull instancetype)initWithMerchantKey:(nonnull NSString *)merchantKey passwordKey:(nonnull NSString *)passwordKey coreData:(BOOL)coreData production:(BOOL)production NS_DESIGNATED_INITIALIZER;

/**
 *  @see [JSMercury setMerchantKey:]
 */
@property (nonatomic, copy, nullable) NSString *merchantKey;
@property (nonatomic, copy, nullable) NSString *passwordKey;
@property (nonatomic, copy, nullable) NSNumber *coreDataKey;
@property (nonatomic, copy, nullable) NSNumber *production;

@end
