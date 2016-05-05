//
//  CreditCell.h
//  MercurySDK
//
//  Created by John Setting on 5/3/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreditCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelAccount;
@property (weak, nonatomic) IBOutlet UILabel *labelToken;
@property (weak, nonatomic) IBOutlet UILabel *labelMessage;
@property (weak, nonatomic) IBOutlet UILabel *labelPurchaseAmount;
@property (weak, nonatomic) IBOutlet UILabel *labelRefNo;
+ (NSString *)cellIdentifier;

@end
