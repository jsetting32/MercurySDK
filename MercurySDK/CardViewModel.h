//
//  CardViewModel.h
//  MercurySDK
//
//  Created by John Setting on 5/2/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VerifyCardInfo.h"

@protocol CardViewModelDelegate;
@interface CardViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic, nullable) id <CardViewModelDelegate> delegate;
@property (strong, nonatomic, nonnull, readonly) NSArray <VerifyCardInfo *> *cards;
- (void)loadCards;
@end

@protocol CardViewModelDelegate <NSObject>
- (void)CardViewModel:(nonnull CardViewModel *)model didFinishLoadingCards:(nonnull NSArray <VerifyCardInfo *> *)cards error:(nullable NSError *)error;
@end
