//
//  PurchasesCell.h
//  MercurySDK
//
//  Created by John Setting on 5/2/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurchasesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelDisplayMessage;
@property (weak, nonatomic) IBOutlet UILabel *labelToken;
@property (weak, nonatomic) IBOutlet UILabel *labelTransPostTime;
@property (weak, nonatomic) IBOutlet UILabel *labelAmount;
@property (weak, nonatomic) IBOutlet UILabel *labelCardHolderName;
+ (NSString *)cellIdentifier;
@end
