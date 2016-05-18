//
//  JSCheckoutCardBillingCell.m
//  MercurySDK
//
//  Created by John Setting on 5/10/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSCheckoutCardBillingCell.h"
#import "JSMercuryUtility.h"

@implementation JSCheckoutCardBillingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.viewCardBillingImage setHidden:YES];
    [[self labelCardBilling] setText:@"CARD & \nBILLING"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCardInformation:(VerifyCardInfo *)card address:(Address *)address {
    
    if (card && address) {
        [[self imageViewCardType] setImage:[JSMercuryUtility cardImage:card.cardType]];
        NSString *trimmedAccountNumber = [card.maskedAccount substringFromIndex:MAX((int)[card.maskedAccount length] - 5, 0)];
        [[self labelCardInformation] setText:[NSString stringWithFormat:@"%@ %@", card.cardHolderName, trimmedAccountNumber]];
        [[self labelBillingInformation] setText:address.tomsFormattedMultiLineAddress];
        [self hasCardAndBillingInformation:YES];
        return;
    }

    if (address) {
        [[self labelBillingInformation] setText:address.tomsFormattedMultiLineAddress];
        [[self labelCardInformation] setText:address.name];
        [self hasBillingInformation:YES];
        return;
    }
    
    if (card) {
        [[self imageViewCardType] setImage:[JSMercuryUtility cardImage:card.cardType]];
        NSString *trimmedAccountNumber = [card.maskedAccount substringFromIndex:MAX((int)[card.maskedAccount length] - 5, 0)];
        [[self labelCardInformation] setText:[NSString stringWithFormat:@"%@ %@", card.cardHolderName, trimmedAccountNumber]];
        [self hasCardInformation:YES];
        return;
    }
    
    [self hasCardAndBillingInformation:NO];
}

- (void)hasCardInformation:(BOOL)information {
    [self.viewCardBillingImage setHidden:information];
    self.layoutConstraintViewImageViewCardInformationHeight.constant = 43.0f;
    [self.viewImageViewCardInformation setHidden:!information];
    [self.labelBillingInformation setHidden:information];
}

- (void)hasBillingInformation:(BOOL)information {
    [self.viewCardBillingImage setHidden:information];
    self.layoutConstraintViewImageViewCardInformationHeight.constant = 15.0f;
    self.layoutConstraintImageViewCardType.constant = 0.0f;
    self.layoutConstraintImageViewCardTypeCardHolderName.constant = 0.0f;
    [self.viewImageViewCardInformation setHidden:!information];
    [self.labelBillingInformation setHidden:!information];
}

- (void)hasCardAndBillingInformation:(BOOL)information {
    [self.viewCardBillingImage setHidden:information];
    self.layoutConstraintViewImageViewCardInformationHeight.constant = 15.0f;
    self.layoutConstraintImageViewCardType.constant = 25.0f;
    self.layoutConstraintImageViewCardTypeCardHolderName.constant = 8.0f;
    [self.viewImageViewCardInformation setHidden:!information];
    [self.labelBillingInformation setHidden:!information];
}

+ (NSString *)reuseIdentifier { return NSStringFromClass([self class]); }
+ (CGFloat)heightForCell { return 50.0f; }

@end
