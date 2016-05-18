//
//  JSCheckoutHeaderCell.h
//  MercurySDK
//
//  Created by John Setting on 5/10/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSCheckoutHeaderCell : UITableViewCell
@property (weak, nonatomic, nullable) IBOutlet UILabel *labelOrderNumber;
@property (weak, nonatomic, nullable) IBOutlet UILabel *labelUnits;
@property (weak, nonatomic, nullable) IBOutlet UILabel *labelItems;
@property (weak, nonatomic, nullable) IBOutlet UILabel *labelTotal;
+ (nonnull NSString *)reuseIdentifier;
+ (CGFloat)heightForCell;
@end
