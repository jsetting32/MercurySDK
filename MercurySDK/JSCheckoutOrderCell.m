//
//  JSCheckoutOrderCell.m
//  MercurySDK
//
//  Created by John Setting on 5/10/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSCheckoutOrderCell.h"

@implementation JSCheckoutOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)reuseIdentifier { return NSStringFromClass([self class]); }
+ (CGFloat)heightForCell { return 132.0f; }
+ (NSNumberFormatter *)currencyFormatter {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    return numberFormatter;
}

@end
