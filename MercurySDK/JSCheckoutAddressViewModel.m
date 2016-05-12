//
//  JSCheckoutShippingBillingViewModel.m
//  MercurySDK
//
//  Created by John Setting on 5/11/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSCheckoutAddressViewModel.h"
#import "JSMercuryCoreDataController.h"
#import "CardCell.h"
#import "JSMercuryUtility.h"

@interface JSCheckoutAddressViewModel()
@property (strong, nonatomic, nonnull, readwrite) NSArray *addresses;
@property (strong, nonatomic, nullable, readwrite) NSArray *cards;
@property (assign, nonatomic) BOOL billing;
@end

@implementation JSCheckoutAddressViewModel

- (instancetype)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"Cannot call %@. Use initWithBilling: instead", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (instancetype)initWithBilling:(BOOL)billing {
    if (!(self = [super init])) return nil;
    _billing = billing;
    return self;
}

- (void)loadData {
    NSError *error = nil;
    if (self.billing) {
        self.cards = [JSMercuryCoreDataController fetchVerifyCardInfoAll:error];
        self.addresses = [JSMercuryCoreDataController fetchAddressBillingAll:error];
        if (self.delegate && [self.delegate respondsToSelector:@selector(JSCheckoutAddressViewModel:didFinishLoadingCards:billingAddresses:)]) {
            [self.delegate JSCheckoutAddressViewModel:self didFinishLoadingCards:self.cards billingAddresses:self.addresses];
        }
        return;
    }
    self.addresses = [JSMercuryCoreDataController fetchAddressShippingAll:error];
    if (self.delegate && [self.delegate respondsToSelector:@selector(JSCheckoutAddressViewModel:didFinishLoadingCards:billingAddresses:)]) {
        [self.delegate JSCheckoutAddressViewModel:self didFinishLoadingCards:self.cards billingAddresses:self.addresses];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return [self.addresses count];
    if (section == 1) return 1;
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [CardCell addressHeight];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.billing) {
        if (section == 0) return @"Billing Addresses";
        if (section == 1) return @"Add Billing Address";
        return nil;
    }

    if (section == 0) return @"Shipping Addresses";
    if (section == 1) return @"Add Shipping Address";
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        Address *address = [self.addresses objectAtIndex:indexPath.row];
        CardCell *cell = [tableView dequeueReusableCellWithIdentifier:[CardCell cellIdentifier]];
        [cell.labelExpDate setText:@""];
        [cell setIsCard:NO];
        [cell.imageViewCardType setImage:[JSMercuryUtility cardImage:nil]];
        [cell.labelMaskedAccount setText:[address formattedMultiLineAddress]];
        return cell;
    }
    
    if (indexPath.section == 1) {
        CardCell *cell = [tableView dequeueReusableCellWithIdentifier:[CardCell cellIdentifier]];
        [cell.labelExpDate setText:@""];
        [cell setIsCard:NO];
        [cell.imageViewCardType setImage:[JSMercuryUtility cardImage:nil]];
        [cell.labelMaskedAccount setText:(self.billing) ? @"Add Billing Address" : @"Add Shipping Address"];
        return cell;
    }
    return nil;
}

@end
