//
//  JSMercuryTypeDef.h
//  MercurySDK
//
//  Created by John Setting on 4/19/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#ifndef JSMercuryTypeDef_h
#define JSMercuryTypeDef_h

//#import "JSMercuryWebViewController.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^kJSMercuryInitializeBlock)(UINavigationController * navigationController, id webController, NSError *error);
typedef void(^kJSMercuryObjectBlock)(id response, NSError *error);

typedef NS_ENUM(NSUInteger, kJSMercuryTransactionType) {
    kJSMercuryTransactionTypeSale       = 1 << 0,
    kJSMercuryTransactionTypePreAuth    = 1 << 1,
    kJSMercuryTransactionTypeZeroAuth   = 1 << 2
};

typedef NS_ENUM(NSUInteger, kJSMercuryTransactionFrequencyType) {
    kJSMercuryTransactionFrequencyTypeOnce          = 1 << 3,
    kJSMercuryTransactionFrequencyTypeRecurring     = 1 << 4
};

typedef NS_ENUM(NSUInteger, kJSMercuryCheckoutPageStyle) {
    kJSMercuryCheckoutPageStyleMercury  = 1 << 5,
    kJSMercuryCheckoutPageStyleCustom   = 1 << 6
};

typedef NS_ENUM(NSUInteger, kJSMercuryTransactionAVSFields) {
    kJSMercuryTransactionAVSFieldsBoth      = 1 << 7,
    kJSMercuryTransactionAVSFieldsZip       = 1 << 8,
    kJSMercuryTransactionAVSFieldsOff       = 1 << 9
};

#endif /* JSMercuryTypeDef_h */
