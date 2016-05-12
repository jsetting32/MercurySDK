//
//  JSCheckoutSubmitCell.h
//  MercurySDK
//
//  Created by John Setting on 5/10/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JSCheckoutSubmitCellDelegate;
@interface JSCheckoutSubmitCell : UITableViewCell
@property (weak, nonatomic, nullable) id <JSCheckoutSubmitCellDelegate> delegate;
@property (weak, nonatomic, nullable) IBOutlet UIButton *buttonSubmit;
+ (nonnull NSString *)reuseIdentifier;
+ (CGFloat)heightForCell;
@end

@protocol JSCheckoutSubmitCellDelegate <NSObject>
- (void)JSCheckoutSubmitCell:(nonnull JSCheckoutSubmitCell *)cell didTapSubmitButton:(nonnull UIButton *)button;
@end