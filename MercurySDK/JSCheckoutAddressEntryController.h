//
//  JSCheckoutBillingShippingEntryController.h
//  MercurySDK
//
//  Created by John Setting on 5/10/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Address.h"

@protocol JSCheckoutAddressEntryControllerDelegate;
@interface JSCheckoutAddressEntryController : UITableViewController
@property (weak, nonatomic) id <JSCheckoutAddressEntryControllerDelegate> entryDelegate;
@property (weak, nonatomic) IBOutlet UITextField *textFieldName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAddress;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCity;
@property (weak, nonatomic) IBOutlet UITextField *textFieldState;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPostalCode;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCountry;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhone;
@property (assign, nonatomic) BOOL billing;
@end

@protocol JSCheckoutAddressEntryControllerDelegate <NSObject>
- (void)JSCheckoutAddressEntryController:(JSCheckoutAddressEntryController *)controller didTapSaveButton:(UIBarButtonItem *)button address:(Address *)address;
@end