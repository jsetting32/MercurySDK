//
//  CardCell.m
//  MercurySDK
//
//  Created by John Setting on 5/2/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "CardCell.h"

@implementation CardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [[self.viewValid layer] setCornerRadius:self.viewValid.frame.size.height / 2.0f];
    [[self.viewValid layer] setMasksToBounds:YES];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.viewValid setHidden:!self.isCard];
    [self.viewValid setBackgroundColor:(self.isValid) ?
     [UIColor colorWithRed:102.0f/255.0f green:204.0f/255.0f blue:0.0f/255.0f alpha:1.0f] :
     [UIColor colorWithRed:204.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)cellIdentifier {
    return @"CardCell";
}

@end
