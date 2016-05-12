//
//  JSCheckoutOrderCell.h
//  MercurySDK
//
//  Created by John Setting on 5/10/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSCheckoutOrderCell : UITableViewCell
@property (weak, nonatomic, nullable) IBOutlet UILabel *labelPayCompany;
@property (weak, nonatomic, nullable) IBOutlet UILabel *labelSubtotalPrice;
@property (weak, nonatomic, nullable) IBOutlet UILabel *labelTaxPrice;
@property (weak, nonatomic, nullable) IBOutlet UILabel *labelShippingPrice;
@property (weak, nonatomic, nullable) IBOutlet UILabel *labelTotalPrice;
+ (nonnull NSString *)reuseIdentifier;
+ (nonnull NSNumberFormatter *)currencyFormatter;
+ (CGFloat)heightForCell;
@end
