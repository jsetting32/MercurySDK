//
//  JSCheckoutItemCell.h
//  MercurySDK
//
//  Created by John Setting on 5/18/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSCheckoutItemCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelItemNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelDescription;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewItem;
@property (weak, nonatomic) IBOutlet UILabel *labelNumberOfItems;
@property (weak, nonatomic) IBOutlet UILabel *labelPriceTotal;
+ (NSString *)cellIdentifier;
+ (CGFloat)heightForCell;
@end
