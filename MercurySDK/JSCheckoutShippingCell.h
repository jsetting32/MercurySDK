//
//  JSCheckoutShippingCell.h
//  MercurySDK
//
//  Created by John Setting on 5/10/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSCheckoutShippingCell : UITableViewCell
@property (weak, nonatomic, nullable) IBOutlet UILabel *labelShipping;
@property (weak, nonatomic, nullable) IBOutlet UILabel *labelShippingInformation;
+ (nonnull NSString *)reuseIdentifier;
+ (CGFloat)heightForCell;
@end
