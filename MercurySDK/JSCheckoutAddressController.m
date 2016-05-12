//
//  JSCheckoutAddressController.m
//  MercurySDK
//
//  Created by John Setting on 5/11/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSCheckoutAddressController.h"
#import "JSCheckoutPresentationController.h"
#import "JSAnimationTransitionController.h"
#import "JSCheckoutAddressViewModel.h"
#import "JSCheckoutAddressEntryController.h"
#import "CardCell.h"
#import "NSManagedObject+Properties.h"
#import "JSMercuryInitializeCardInfo.h"
#import "JSMercuryWebViewController.h"
#import "JSMercuryCardController.h"

@interface JSCheckoutAddressController () <UIViewControllerTransitioningDelegate, JSCheckoutAddressViewModelDelegate, UITableViewDelegate, UITableViewDataSource, JSCheckoutAddressEntryControllerDelegate, JSMercuryWebViewDelegate>

@property (strong, nonatomic, nonnull) JSCheckoutAddressViewModel *model;
@end

@implementation JSCheckoutAddressController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (!(self = [super initWithCoder:aDecoder])) return nil;
    _selection = NO;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.model = [[JSCheckoutAddressViewModel alloc] initWithBilling:self.billing];
    [self.model setDelegate:self];
    [self.model loadData];
}

- (void)JSCheckoutAddressViewModel:(JSCheckoutAddressViewModel *)model didFinishLoadingCards:(NSArray<VerifyCardInfo *> *)cards billingAddresses:(NSArray<Address *> *)address {
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model tableView:tableView numberOfRowsInSection:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.model numberOfSectionsInTableView:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.model tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.model tableView:tableView titleForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.model tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (void)JSCheckoutAddressEntryController:(JSCheckoutAddressEntryController *)controller didTapSaveButton:(UIBarButtonItem *)button address:(Address *)address {
    [controller.navigationController popViewControllerAnimated:YES];
    NSError *error = nil;
    [address saveObject:&error];
    [self.model loadData];
}

- (void)JSMercuryWebViewController:(nonnull JSMercuryWebViewController *)controller didFinishWithCardInfoResponse:(JSMercuryVerifyCardInfo * _Nullable)response error:( NSError * _Nullable)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
    [self.model loadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        if (self.selection) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(JSCheckoutAddressController:didSelectAddress:)]) {
                [self.delegate JSCheckoutAddressController:self didSelectAddress:[[self.model addresses] objectAtIndex:indexPath.row]];
            }
        }
        
        return;
    }
    
    [self performSegueWithIdentifier:@"address" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    JSCheckoutAddressEntryController *entry = [segue destinationViewController];
    [entry setEntryDelegate:self];
    entry.billing = self.billing;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
