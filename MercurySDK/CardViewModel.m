//
//  CardViewModel.m
//  MercurySDK
//
//  Created by John Setting on 5/2/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "CardViewModel.h"
#import "JSMercuryCoreDataController.h"
#import "CardCell.h"

@interface CardViewModel()
@property (strong, nonatomic, nonnull, readwrite) NSArray <VerifyCardInfo *> *cards;
@end

@implementation CardViewModel

- (instancetype)init {
    if (!(self = [super init])) return nil;
    _cards = [NSArray array];
    return self;
}

- (void)loadCards {
    NSError *error = nil;
    self.cards = [JSMercuryCoreDataController fetchVerifyCardInfoAll:error];
    if (self.delegate && [self.delegate respondsToSelector:@selector(cardViewModel:didFinishLoadingCards:error:)]) {
        [self.delegate cardViewModel:self didFinishLoadingCards:self.cards error:error];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CardCell *cell = (CardCell *)[tableView dequeueReusableCellWithIdentifier:[CardCell cellIdentifier]];
    VerifyCardInfo *card = [self.cards objectAtIndex:indexPath.row];
    [cell.labelExpDate setText:[card formattedExpDate]];
    [cell.labelToken setText:card.token];
    [cell.labelCardType setText:card.cardType];
    [cell.labelMaskedAccount setText:card.maskedAccount];
    [cell.labelDisplayMessage setText:card.displayMessage];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cards count];
}


@end
