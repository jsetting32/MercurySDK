//
//  MercurySOAPHelper.h
//  CallMercuryHostedCheckoutWebService
//
//  Created by Kevin Oliver on 5/16/13.
//  Copyright (c) 2013 Kevin Oliver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSMercuryTypeDef.h"
#import "JSMercuryConstants.h"

@class HCMercuryHelper;

@protocol HCMercuryHelperDelegate;

@interface HCMercuryHelper : NSObject <NSXMLParserDelegate>
@property (strong, nonatomic, nullable) id <HCMercuryHelperDelegate> delegate;
- (void)actionFromDictionary:(nonnull NSDictionary *)dictionary actionType:(nonnull NSString *)actionType;
- (void)tokenFromDictionary:(nonnull NSDictionary *)dictionary actionType:(nonnull NSString *)actionType;
@end

@protocol HCMercuryHelperDelegate <NSObject>
- (void)hcTransactionDidFailWithError:(nonnull NSError *)error;
- (void)hcTransactionDidFinish:(nonnull NSDictionary *)result;
@end
