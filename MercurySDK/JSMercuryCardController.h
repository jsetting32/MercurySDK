//
//  JSMercuryCardController.h
//  MercurySDK
//
//  Created by John Setting on 5/12/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VerifyCardInfo.h"

@protocol JSMercuryCardControllerDelegate;
@interface JSMercuryCardController : UIViewController
@property (weak, nonatomic, nullable) id <JSMercuryCardControllerDelegate> delegate;
@property (weak, nonatomic, nullable) IBOutlet UITableView *tableView;
@property (assign, nonatomic) BOOL selection;
@end

@protocol JSMercuryCardControllerDelegate <NSObject>
- (void)JSMercuryCardController:(nonnull JSMercuryCardController *)controller didSelectCard:(nonnull VerifyCardInfo *)card;
@end
