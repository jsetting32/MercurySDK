//
//  PurchasesViewModel.h
//  MercurySDK
//
//  Created by John Setting on 5/2/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VerifyPayment.h"

@protocol PurchasesViewModelDelegate;
@interface PurchasesViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic, nullable) id <PurchasesViewModelDelegate> delegate;
@property (strong, nonatomic, nonnull, readonly) NSArray <VerifyPayment *> *purchases;
- (void)loadPurchases;
@end

@protocol PurchasesViewModelDelegate <NSObject>
- (void)purchasesViewModel:(nonnull PurchasesViewModel *)model didFinishLoadingPurchases:(nonnull NSArray <VerifyPayment *> *)payments error:(nullable NSError *)error;
@end
