//
//  JSCheckoutCardBillingCell.h
//  MercurySDK
//
//  Created by John Setting on 5/10/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSCheckoutCardBillingCell : UITableViewCell
@property (weak, nonatomic, nullable) IBOutlet UILabel *labelCardBilling;
@property (weak, nonatomic, nullable) IBOutlet UILabel *labelCardBillingInformation;
+ (nonnull NSString *)reuseIdentifier;
+ (CGFloat)heightForCell;
@end
