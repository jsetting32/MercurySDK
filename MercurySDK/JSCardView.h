//
//  JSCardView.h
//  MercurySDK
//
//  Created by John Setting on 4/22/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSMercuryVerifyCardInfo.h"

typedef NS_ENUM(NSInteger, JSCardType) {
    kJSCardTypeAmex = 0,
    kJSCardTypeDankort = 1,
    kJSCardTypeDiners,
    kJSCardTypeDiscover,
    kJSCardTypeForbru,
    kJSCardTypeGoogle,
    kJSCardTypeJCB,
    kJSCardTypeLaser,
    kJSCardTypeMaestro,
    kJSCardTypeMastercard,
    kJSCardTypeMoney,
    kJSCardTypePaypal,
    kJSCardTypeShopify,
    kJSCardTypeSolo,
    kJSCardTypeVisa,
    kJSCartTypeInvalid,
    kJSCartTypeUnknown
};

@protocol JSCardViewDelegate;
@interface JSCardView : UIView <UITextFieldDelegate>
@property (weak, nonatomic, nullable) id <JSCardViewDelegate> delegate;
@property (weak, nonatomic, nullable) IBOutlet UITextField *textFieldCardNumber;
@property (weak, nonatomic, nullable) IBOutlet UITextField *textFieldCardHolderName;
@property (weak, nonatomic, nullable) IBOutlet UIImageView *imageViewCardType;
@property (weak, nonatomic, nullable) IBOutlet UITextField *textFieldExpirationMonth;
@property (weak, nonatomic, nullable) IBOutlet UITextField *textFieldExpirationYear;
@property (strong, nonatomic, nonnull) IBOutlet UIView *viewContainer;
@property (weak, nonatomic, nullable) IBOutlet UIButton *buttonMask;

- (void)setCardInfo:(nonnull JSMercuryVerifyCardInfo *)cardInfo;

@end

@protocol JSCardViewDelegate <NSObject>
- (void)JSCardView:(nonnull JSCardView *)cardView didTapCard:(nonnull UIButton *)button;
@end
