//
//  JSCheckoutController.h
//  MercurySDK
//
//  Created by John Setting on 5/9/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VerifyCardInfo.h"
#import "Address.h"

@protocol JSCheckoutControllerDelegate;
@interface JSCheckoutController : UIViewController
@property (weak, nonatomic, nullable) id <JSCheckoutControllerDelegate> delegate;
//@property (strong, nonatomic, nullable) JSCheckoutCompany *company;
@property (strong, nonatomic, nullable) VerifyCardInfo *card;
@property (strong, nonatomic, nullable) Address *shipping;
@property (strong, nonatomic, nullable) Address *billing;
//@property (strong, nonatomic, nullable) JSCheckoutOrder *order;
@property (strong, nonatomic, nullable) NSNumber *taxAmount;
@property (strong, nonatomic, nullable) NSNumber *shippingAmount;
@property (strong, nonatomic, nullable) NSNumber *subtotalAmount;
@property (weak, nonatomic, nullable) IBOutlet UITableView *tableView;
+ (CGRect)suggestedEndingRect;
@end

@protocol JSCheckoutControllerDelegate <NSObject>
- (void)JSCheckoutController:(nonnull JSCheckoutController *)controller didTapSubmit:(nonnull UIButton *)submit;
@end