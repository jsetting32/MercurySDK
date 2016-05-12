//
//  JSCheckoutCompanyCell.h
//  MercurySDK
//
//  Created by John Setting on 5/10/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JSCheckoutCompanyCellDelegate;
@interface JSCheckoutCompanyCell : UITableViewCell
@property (weak, nonatomic, nullable) id <JSCheckoutCompanyCellDelegate> delegate;
@property (weak, nonatomic, nullable) IBOutlet UIImageView *imageViewCompany;
@property (weak, nonatomic, nullable) IBOutlet UILabel *labelCompany;
@property (weak, nonatomic, nullable) IBOutlet UIButton *buttonCancel;
+ (nonnull NSString *)reuseIdentifier;
+ (CGFloat)heightForCell;
@end

@protocol JSCheckoutCompanyCellDelegate <NSObject>
- (void)JSCheckoutCompanyCell:(nonnull JSCheckoutCompanyCell *)cell didTapCancelButton:(nonnull UIButton *)button;
@end
