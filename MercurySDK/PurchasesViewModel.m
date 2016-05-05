//
//  PurchasesViewModel.m
//  MercurySDK
//
//  Created by John Setting on 5/2/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "PurchasesViewModel.h"
#import "PurchasesCell.h"
#import "JSMercuryCoreDataController.h"

@interface PurchasesViewModel()
@property (strong, nonatomic, nonnull, readwrite) NSArray <VerifyPayment *> *purchases;
@end

@implementation PurchasesViewModel

- (instancetype)init {
    if (!(self = [super init])) return nil;
    _purchases = [NSArray array];
    return self;
}

- (void)loadPurchases {
    NSError *error = nil;
    self.purchases = [JSMercuryCoreDataController fetchVerifyPaymentAll:error];
    if (self.delegate && [self.delegate respondsToSelector:@selector(purchasesViewModel:didFinishLoadingPurchases:error:)]) {
        [self.delegate purchasesViewModel:self didFinishLoadingPurchases:self.purchases error:error];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PurchasesCell *cell = (PurchasesCell *)[tableView dequeueReusableCellWithIdentifier:[PurchasesCell cellIdentifier]];
    VerifyPayment *payment = [self.purchases objectAtIndex:indexPath.row];
    [cell.labelDisplayMessage setText:payment.displayMessage];
    [cell.labelToken setText:payment.token];
    [cell.labelTransPostTime setText:payment.transPostTimeFormatted];
    [cell.labelAmount setText:payment.amountFormatted];
    [cell.labelCardHolderName setText:payment.cardHolderName];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.purchases count];
}

@end
