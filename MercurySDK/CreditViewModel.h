//
//  CreditViewModel.h
//  MercurySDK
//
//  Created by John Setting on 5/3/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CreditResponse.h"

@protocol CreditViewModelDelegate;
@interface CreditViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic, nullable) id <CreditViewModelDelegate> delegate;
@property (strong, nonatomic, nonnull) NSMutableArray <CreditResponse *> *credits;
- (void)loadCredits;
@end

@protocol CreditViewModelDelegate <NSObject>
- (void)creditViewModel:(nonnull CreditViewModel *)model didFinishLoadingCredits:(nonnull NSArray <CreditResponse *> *)cards error:(nullable NSError *)error;
@end
