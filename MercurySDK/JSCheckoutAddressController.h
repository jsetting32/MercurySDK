//
//  JSCheckoutAddressController.h
//  MercurySDK
//
//  Created by John Setting on 5/11/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Address.h"

@protocol JSCheckoutAddressControllerDelegate;
@interface JSCheckoutAddressController : UIViewController
@property (weak, nonatomic, nullable) id <JSCheckoutAddressControllerDelegate> delegate;
@property (weak, nonatomic, nullable) IBOutlet UITableView *tableView;
@property (assign, nonatomic) BOOL billing;
@property (assign, nonatomic) BOOL selection;
@end

@protocol JSCheckoutAddressControllerDelegate <NSObject>
- (void)JSCheckoutAddressController:(nonnull JSCheckoutAddressController *)controller didSelectAddress:(nonnull Address *)address;
@end
