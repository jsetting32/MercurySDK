//
//  CreditViewModel.m
//  MercurySDK
//
//  Created by John Setting on 5/3/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "CreditViewModel.h"
#import "JSMercuryCoreDataController.h"
#import "CreditCell.h"
#import "CreditResponse.h"

@interface CreditViewModel()
@property (strong, nonatomic, nonnull, readwrite) NSArray <CreditResponse *> *credits;
@end

@implementation CreditViewModel

- (instancetype)init {
    if (!(self = [super init])) return nil;
    _credits = [NSArray array];
    return self;
}

- (void)loadCredits {
    NSError *error = nil;
    self.credits = [JSMercuryCoreDataController fetchCreditResponseAll:error];
    if (self.delegate && [self.delegate respondsToSelector:@selector(creditViewModel:didFinishLoadingCredits:error:)]) {
        [self.delegate creditViewModel:self didFinishLoadingCredits:self.credits error:error];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CreditCell *cell = (CreditCell *)[tableView dequeueReusableCellWithIdentifier:[CreditCell cellIdentifier]];
    CreditResponse *card = [self.credits objectAtIndex:indexPath.row];
    [cell.labelRefNo setText:card.refNo];
    [cell.labelToken setText:card.token];
    [cell.labelAccount setText:card.account];
    [cell.labelMessage setText:card.message];
    [cell.labelPurchaseAmount setText:card.formattedPurchaseAmount];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.credits count];
}

@end
