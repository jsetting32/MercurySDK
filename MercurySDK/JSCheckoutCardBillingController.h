//
//  JSCheckoutCardBillingController.h
//  MercurySDK
//
//  Created by John Setting on 5/11/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Address.h"
#import "VerifyCardInfo.h"

@protocol JSCheckoutCardBillingControllerDelegate;
@interface JSCheckoutCardBillingController : UIViewController
@property (weak, nonatomic, nullable) IBOutlet UITableView *tableView;
@property (weak, nonatomic, nullable) id <JSCheckoutCardBillingControllerDelegate> delegate;
@end

@protocol JSCheckoutCardBillingControllerDelegate <NSObject>
- (void)JSCheckoutCardBillingController:(nonnull JSCheckoutCardBillingController *)controller didSelectBillingAddress:(nullable Address *)address card:(nullable VerifyCardInfo *)card;
@end
