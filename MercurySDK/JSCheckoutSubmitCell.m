//
//  JSCheckoutSubmitCell.m
//  MercurySDK
//
//  Created by John Setting on 5/10/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSCheckoutSubmitCell.h"

@implementation JSCheckoutSubmitCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapSubmitButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(JSCheckoutSubmitCell:didTapSubmitButton:)]) {
        [self.delegate JSCheckoutSubmitCell:self didTapSubmitButton:sender];
    }
}

+ (NSString *)reuseIdentifier { return NSStringFromClass([self class]); }
+ (CGFloat)heightForCell { return 43.0f; }

@end
