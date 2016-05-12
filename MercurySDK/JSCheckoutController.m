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
#import "JSCheckoutCompanyCell.h"
#import "JSCheckoutCardBillingCell.h"
#import "JSCheckoutShippingCell.h"
#import "JSCheckoutOrderCell.h"
#import "JSCheckoutSubmitCell.h"
#import "JSCheckoutAddressController.h"
#import "JSMercuryUtility.h"
#import "JSMercuryCreditTokenSale.h"
#import "JSMercuryCoreDataController.h"

@interface JSCheckoutController () <UIViewControllerTransitioningDelegate, UIAdaptivePresentationControllerDelegate, UITableViewDelegate, UITableViewDataSource, JSCheckoutCompanyCellDelegate, JSCheckoutSubmitCellDelegate, JSCheckoutAddressControllerDelegate>

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) return [JSCheckoutCompanyCell heightForCell];
    if (indexPath.row == 1) return [JSCheckoutCardBillingCell heightForCell];
    if (indexPath.row == 2) return [JSCheckoutShippingCell heightForCell];
    if (indexPath.row == 3) return [JSCheckoutOrderCell heightForCell];
    if (indexPath.row == 4) return [JSCheckoutSubmitCell heightForCell];
    return 0.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        JSCheckoutCompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:[JSCheckoutCompanyCell reuseIdentifier]];
        [cell setDelegate:self];
        return cell;
    }

    if (indexPath.row == 1) {
        JSCheckoutCardBillingCell *cell = [tableView dequeueReusableCellWithIdentifier:[JSCheckoutCardBillingCell reuseIdentifier]];
        if (self.billing && self.card) {
            [[cell labelCardBillingInformation] setText:[JSMercuryUtility formattedCardBillingInformation:self.card address:self.billing]];
            return cell;
        }
        
        if (self.card) {
            [[cell labelCardBillingInformation] setText:[NSString stringWithFormat:@"%@ %@", self.card.maskedAccount, self.card.formattedExpDate]];
            return cell;
        }
        
        if (self.billing) {
            [[cell labelCardBillingInformation] setText:self.billing.formattedSingleLineAddress];
            return cell;
        }
        
        [[cell labelCardBillingInformation] setText:@"Add Card and Billing Information"];
        return cell;
    }

    if (indexPath.row == 2) {
        JSCheckoutShippingCell *cell = [tableView dequeueReusableCellWithIdentifier:[JSCheckoutShippingCell reuseIdentifier]];
        if (self.shipping) {
            [[cell labelShippingInformation] setText:[self.shipping formattedMultiLineAddress]];
            return cell;
        }
        [[cell labelShippingInformation] setText:@"Add Shipping Information"];
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

#pragma mark <JSCheckoutCompanyCellDelegate>
- (void)JSCheckoutCompanyCell:(JSCheckoutCompanyCell *)cell didTapCancelButton:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark <JSCheckoutSubmitCellDelegate>
- (void)JSCheckoutSubmitCell:(JSCheckoutSubmitCell *)cell didTapSubmitButton:(UIButton *)button {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Submit Order" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sale = [UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        JSMercuryCreditTokenSale *sale = [[JSMercuryCreditTokenSale alloc] initWithToken:self.card.token];
        sale.address = self.billing.formattedVantivAddress;
        sale.zip = self.billing.postalCode;
        sale.purchaseAmount = @([self.taxAmount floatValue] + [self.shippingAmount floatValue] + [self.subtotalAmount floatValue]);
        sale.invoice = [[JSMercuryCoreDataController fetchNextInvoiceNumber:nil] stringValue];
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"shipping"]) {
        JSCheckoutAddressController * shipping = [segue destinationViewController];
        [shipping setDelegate:self];
        shipping.billing = NO;
        shipping.selection = YES;
    }
}

@end
