//
//  JSCheckoutShippingBillingViewModel.h
//  MercurySDK
//
//  Created by John Setting on 5/11/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VerifyCardInfo.h"
#import "Address.h"

@protocol JSCheckoutAddressViewModelDelegate;
@interface JSCheckoutAddressViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic, nullable) id <JSCheckoutAddressViewModelDelegate> delegate;
- (nullable instancetype)initWithBilling:(BOOL)billing;
@property (strong, nonatomic, nonnull, readonly) NSArray *addresses;
- (void)loadData;
@end

@protocol JSCheckoutAddressViewModelDelegate <NSObject>
- (void)JSCheckoutAddressViewModel:(nonnull JSCheckoutAddressViewModel *)model didFinishLoadingCards:(nonnull NSArray <VerifyCardInfo *> *)cards billingAddresses:(nonnull NSArray <Address *> *)address;
@end
