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
#import "JSMercuryUtility.h"

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
    if (self.delegate && [self.delegate respondsToSelector:@selector(CardViewModel:didFinishLoadingCards:error:)]) {
        [self.delegate CardViewModel:self didFinishLoadingCards:self.cards error:error];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CardCell *cell = (CardCell *)[tableView dequeueReusableCellWithIdentifier:[CardCell cellIdentifier]];

    if (indexPath.section == 0) {
        VerifyCardInfo *card = [self.cards objectAtIndex:indexPath.row];
        [cell.labelExpDate setText:[card formattedExpDate]];
        [cell setIsCard:YES];
        [cell setIsValid:[card isValid]];
        [cell.imageViewCardType setImage:[JSMercuryUtility cardImage:[card cardType]]];
        [cell.labelMaskedAccount setText:[card formattedMaskedAccount]];
        return cell;
    }
    
    [cell.labelExpDate setText:@""];
    [cell setIsCard:NO];
    [cell.imageViewCardType setImage:[JSMercuryUtility cardImage:nil]];
    [cell.labelMaskedAccount setText:@"Add Credit Card"];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return [self.cards count];
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) return @"Payment Methods";
    return @"Add Payment Method";
}

@end
