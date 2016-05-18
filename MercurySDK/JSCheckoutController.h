//
//  JSCheckoutController.h
//  MercurySDK
//
//  Created by John Setting on 5/9/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JSCheckoutControllerDelegate;
@interface JSCheckoutController : UIViewController
@property (weak, nonatomic, nullable) id <JSCheckoutControllerDelegate> delegate;
@property (weak, nonatomic, nullable) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic, nullable) NSNumber *taxAmount;
@property (strong, nonatomic, nullable) NSNumber *shippingAmount;
@property (strong, nonatomic, nullable) NSNumber *subtotalAmount;
@property (weak, nonatomic, nullable) IBOutlet UITableView *tableView;
@property (weak, nonatomic, nullable) IBOutlet UIButton *buttonRemark;
@property (weak, nonatomic, nullable) IBOutlet UIButton *buttonSubmit;
@property (weak, nonatomic, nullable) IBOutlet NSLayoutConstraint *layoutConstraintTableViewHeight;
+ (CGRect)suggestedEndingRect;
@end

@protocol JSCheckoutControllerDelegate <NSObject>
- (void)JSCheckoutController:(nonnull JSCheckoutController *)controller didTapSubmit:(nonnull UIButton *)submit;
@end