//
//  JSCardView.m
//  MercurySDK
//
//  Created by John Setting on 4/22/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSCardView.h"
#import "JSMercuryUtility.h"
#import "Verify.h"

@implementation JSCardView

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil]) {
        [self.viewContainer setFrame:[self bounds]];
        [self addSubview:self.viewContainer];
    }
    
    [self.viewContainer setBackgroundColor:[UIColor colorWithWhite:0.85f alpha:1.0f]];
    [[self layer] setCornerRadius:10.0f];
    [[self layer] setMasksToBounds:YES];
    [[self.viewContainer layer] setMasksToBounds:YES];
    [[self.viewContainer layer] setCornerRadius:10.0f];
    
    for (UITextField *textField in [self.viewContainer subviews]) {
        if ([textField isKindOfClass:[UITextField class]]) {
            [textField.layer setShadowColor:[[UIColor colorWithWhite:0.75f alpha:1.0f] CGColor]];
            [textField.layer setShadowOffset:CGSizeMake(-2.0, -2.0)];
            [textField.layer setShadowOpacity:1.0];
            [textField.layer setShadowRadius:0.3];
            [textField.layer setMasksToBounds:YES];
        }
    }
}

- (IBAction)didTapMaskButton:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(JSCardView:didTapCard:)]) {
        [self.delegate JSCardView:self didTapCard:sender];
    }
}

- (void)setCardInfo:(Verify *)cardInfo {
    [self.textFieldCardHolderName setText:cardInfo.cardHolderName];
    [self.textFieldCardNumber setText:cardInfo.maskedAccount];
    [self.textFieldExpirationMonth setText:cardInfo.formattedExpDateMonth];
    [self.textFieldExpirationYear setText:cardInfo.formattedExpDateYear];
    [self.imageViewCardType setImage:[JSMercuryUtility cardImage:cardInfo.cardType]];
}

@end
