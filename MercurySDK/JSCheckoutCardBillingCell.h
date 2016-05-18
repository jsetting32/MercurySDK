//
//  JSCheckoutCardBillingCell.h
//  MercurySDK
//
//  Created by John Setting on 5/10/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VerifyCardInfo.h"
#import "Address.h"

@interface JSCheckoutCardBillingCell : UITableViewCell
@property (weak, nonatomic, nullable) IBOutlet UILabel *labelCardBilling;
@property (weak, nonatomic, nullable) IBOutlet UILabel *labelCardInformation;
@property (weak, nonatomic, nullable) IBOutlet UILabel *labelBillingInformation;
@property (weak, nonatomic, nullable) IBOutlet UIImageView *imageViewCardType;
@property (weak, nonatomic, nullable) IBOutlet UIView *viewImageViewCardInformation;
@property (weak, nonatomic, nullable) IBOutlet UIView *viewCardBillingImage;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *layoutConstraintViewImageViewCardInformationHeight;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *layoutConstraintImageViewCardTypeCardHolderName;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *layoutConstraintImageViewCardType;
+ (nonnull NSString *)reuseIdentifier;
+ (CGFloat)heightForCell;
- (void)setCardInformation:(nullable VerifyCardInfo *)card address:(nullable Address *)address;



@end
