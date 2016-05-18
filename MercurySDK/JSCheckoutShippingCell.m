//
//  JSCheckoutShippingCell.m
//  MercurySDK
//
//  Created by John Setting on 5/18/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSCheckoutShippingCell.h"

@implementation JSCheckoutShippingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.viewCardBillingImage setHidden:YES];
    self.layoutConstraintViewImageViewCardInformationHeight.constant = 0.0f;
    self.layoutConstraintImageViewCardType.constant = 0.0f;
    self.layoutConstraintImageViewCardTypeCardHolderName.constant = 0.0f;
    [[self labelCardBilling] setText:@"SHIPPING"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)hasBillingInformation:(BOOL)information {
    if (!information) {
        [[self labelBillingInformation] setText:@"Add Shipping Information"];
    }
    
    self.layoutConstraintViewImageViewCardInformationHeight.constant = (information) ? 15.0f : 0.0f;
    [self.viewImageViewCardInformation setHidden:!information];
}

- (void)setCardInformation:(VerifyCardInfo *)card address:(Address *)address {
    
    [self hasBillingInformation:(address) ? YES : NO];
    if (address) {
        [[self labelBillingInformation] setText:address.tomsFormattedMultiLineAddress];
        [[self labelCardInformation] setText:address.name];
        return;
    }
}

+ (nonnull NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end
