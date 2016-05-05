//
//  CardCell.h
//  MercurySDK
//
//  Created by John Setting on 5/2/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelMaskedAccount;
@property (weak, nonatomic) IBOutlet UILabel *labelToken;
@property (weak, nonatomic) IBOutlet UILabel *labelCardType;
@property (weak, nonatomic) IBOutlet UILabel *labelExpDate;
@property (weak, nonatomic) IBOutlet UILabel *labelDisplayMessage;
+ (NSString *)cellIdentifier;
@end
