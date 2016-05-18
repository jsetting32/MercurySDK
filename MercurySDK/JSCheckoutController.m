//
//  JSCheckoutController.m
//  MercurySDK
//
//  Created by John Setting on 5/9/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSCheckoutController.h"
#import "JSAnimationTransitionController.h"
#import "JSCheckoutPresentationController.h"
#import "JSCheckoutHeaderCell.h"
#import "JSCheckoutCardBillingCell.h"
#import "JSCheckoutShippingCell.h"
#import "JSCheckoutOrderCell.h"
#import "JSCheckoutSubmitCell.h"
#import "JSCheckoutAddressController.h"
#import "JSMercuryUtility.h"
#import "JSMercuryCreditTokenSale.h"
#import "JSMercuryCoreDataController.h"
#import "JSCheckoutCardBillingController.h"
#import "JSCheckoutItemCell.h"

@interface JSCheckoutController () <UIViewControllerTransitioningDelegate, UIAdaptivePresentationControllerDelegate, UITableViewDelegate, UITableViewDataSource,JSCheckoutAddressControllerDelegate, JSCheckoutCardBillingControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) NSString *next;
@property (strong, nonatomic, nullable) VerifyCardInfo *card;
@property (strong, nonatomic, nullable) Address *shipping;
@property (strong, nonatomic, nullable) Address *billing;
@end

@implementation JSCheckoutController

- (instancetype)init {
    if (!(self = [super init])) return nil;
    [self commonInit];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (!(self = [super initWithCoder:aDecoder])) return nil;
    [self commonInit];
    return self;
}

- (void)commonInit {
    if ([self respondsToSelector:@selector(setTransitioningDelegate:)]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }
}

- (nullable UIViewController *)presentationController:(UIPresentationController *)controller viewControllerForAdaptivePresentationStyle:(UIModalPresentationStyle)style {
    UIViewController *p = controller.presentedViewController;
    return [[UINavigationController alloc] initWithRootViewController:p];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSError *error = nil;
    
    UICollectionViewFlowLayout * layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.sectionHeadersPinToVisibleBounds = true;
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 1;

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.card = [JSMercuryCoreDataController fetchVerifyCardInfoLastUsed:error];
    self.billing = [JSMercuryCoreDataController fetchBillingAddressLastUsed:error];
    self.shipping = [JSMercuryCoreDataController fetchShippingAddressLastUsed:error];
    self.next = [[JSMercuryCoreDataController fetchNextInvoiceNumber:nil] stringValue];
    if (error) {
        NSLog(@"%@", error);
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.layoutConstraintTableViewHeight.constant = 166.0f;
    [self.view layoutIfNeeded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) return [JSCheckoutHeaderCell heightForCell];
    if (indexPath.row == 1) return [JSCheckoutShippingCell heightForCell];
    if (indexPath.row == 2) return [JSCheckoutCardBillingCell heightForCell];
    if (indexPath.row == 3) return [JSCheckoutOrderCell heightForCell];
    if (indexPath.row == 4) return [JSCheckoutSubmitCell heightForCell];
    return 0.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        JSCheckoutHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:[JSCheckoutHeaderCell reuseIdentifier]];
        [[cell labelItems] setText:@"99 Items"];
        [[cell labelUnits] setText:@"999 Units"];
        [[cell labelOrderNumber] setText:[NSString stringWithFormat:@"Order # : %@", self.next]];
        NSNumber *total = @([self.taxAmount floatValue] + [self.shippingAmount floatValue] + [self.subtotalAmount floatValue]);
        [[cell labelTotal] setText:[[JSCheckoutOrderCell currencyFormatter] stringFromNumber:total]];
        return cell;
    }

    if (indexPath.row == 1) {
        JSCheckoutShippingCell *cell = [tableView dequeueReusableCellWithIdentifier:[JSCheckoutShippingCell reuseIdentifier]];
        [cell setCardInformation:self.card address:self.shipping];
        return cell;
    }

    if (indexPath.row == 2) {
        JSCheckoutCardBillingCell *cell = [tableView dequeueReusableCellWithIdentifier:[JSCheckoutCardBillingCell reuseIdentifier]];
        [cell setCardInformation:self.card address:self.billing];
        return cell;
    }

    if (indexPath.row == 3) {
        JSCheckoutOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:[JSCheckoutOrderCell reuseIdentifier]];
        [cell.labelTaxPrice setText:[[JSCheckoutOrderCell currencyFormatter] stringFromNumber:self.taxAmount]];
        [cell.labelShippingPrice setText:[[JSCheckoutOrderCell currencyFormatter] stringFromNumber:self.shippingAmount]];
        [cell.labelSubtotalPrice setText:[[JSCheckoutOrderCell currencyFormatter] stringFromNumber:self.subtotalAmount]];
        NSNumber *total = @([self.taxAmount floatValue] + [self.shippingAmount floatValue] + [self.subtotalAmount floatValue]);
        [cell.labelTotalPrice setText:[[JSCheckoutOrderCell currencyFormatter] stringFromNumber:total]];
        return cell;
    }

    if (indexPath.row == 4) {
        JSCheckoutSubmitCell *cell = [tableView dequeueReusableCellWithIdentifier:[JSCheckoutSubmitCell reuseIdentifier]];
        [cell setDelegate:self];
        return cell;
    }

    return nil;
}

- (IBAction)didTapSubmitButtonAction:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Submit Order" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sale = [UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSError *error = nil;
        [JSMercuryCoreDataController updateUsedCard:self.card billing:self.billing shipping:self.shipping error:&error];
        if (error) NSLog(@"%@", error);
        
        JSMercuryCreditTokenSale *sale = [[JSMercuryCreditTokenSale alloc] initWithToken:self.card.token];
        sale.address = self.billing.formattedVantivAddress;
        sale.zip = self.billing.postalCode;
        sale.purchaseAmount = @([self.taxAmount floatValue] + [self.shippingAmount floatValue] + [self.subtotalAmount floatValue]);
        sale.invoice = self.next;
        [sale js_mercury_credit_token:^(JSMercuryCreditTokenResponse * _Nullable response, NSError * _Nullable error) {
            NSString *message = (error) ? [error localizedFailureReason] : @"Order Submitted";
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Status" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:sale];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JSCheckoutItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[JSCheckoutItemCell cellIdentifier] forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width, [JSCheckoutItemCell heightForCell]);
}

#pragma mark <UIViewControllerTransitioningDelegate>
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[JSAnimationTransitionController alloc] initWithTransitionDuration:0.5f animation:kJSAnimationTransitionControllerSlide];
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[JSCheckoutPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

+ (CGRect)suggestedEndingRect {    
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    CGRect frame = window.frame;
    CGFloat origin = 374 - 20;
    CGRect rect = CGRectMake(frame.origin.x, frame.size.height - origin, frame.size.width, origin);
    return rect;
}

- (void)JSCheckoutAddressController:(JSCheckoutAddressController *)controller didSelectAddress:(Address *)address {
    self.shipping = address;
    [self.tableView reloadData];
    [controller.navigationController popViewControllerAnimated:YES];
}

- (void)JSCheckoutCardBillingController:(JSCheckoutCardBillingController *)controller didSelectBillingAddress:(Address *)address card:(VerifyCardInfo *)card {
    if (address) self.billing = address;
    if (card) self.card = card;
    [self.tableView reloadData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"billing"]) {
        JSCheckoutCardBillingController *billing = [segue destinationViewController];
        [billing setDelegate:self];
    }
    
    if ([[segue identifier] isEqualToString:@"shipping"]) {
        JSCheckoutAddressController * shipping = [segue destinationViewController];
        [shipping setDelegate:self];
        shipping.billing = NO;
        shipping.selection = YES;
    }
}

@end
