//
//  JSCheckoutCardBillingController.m
//  MercurySDK
//
//  Created by John Setting on 5/11/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSCheckoutCardBillingController.h"
#import "JSCheckoutAddressController.h"
#import "JSMercuryCardController.h"
#import "CardCell.h"
#import "JSMercuryUtility.h"
#import "VerifyCardInfo.h"
#import "JSCheckoutController.h"

@interface JSCheckoutCardBillingController () <JSCheckoutAddressControllerDelegate, JSMercuryCardControllerDelegate>
@property (strong, nonatomic) Address *address;
@property (strong, nonatomic) VerifyCardInfo *card;
@end

@implementation JSCheckoutCardBillingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)JSMercuryCardController:(JSMercuryCardController *)controller didSelectCard:(VerifyCardInfo *)card {
    self.card = card;
    [controller.navigationController popViewControllerAnimated:YES];
    [self.tableView reloadData];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(JSCheckoutCardBillingController:didSelectBillingAddress:card:)]) {
        [self.delegate JSCheckoutCardBillingController:self didSelectBillingAddress:nil card:card];
    }
}

- (void)JSCheckoutAddressController:(JSCheckoutAddressController *)controller didSelectAddress:(Address *)address {
    self.address = address;
    [controller.navigationController popViewControllerAnimated:YES];
    [self.tableView reloadData];

    if (self.delegate && [self.delegate respondsToSelector:@selector(JSCheckoutCardBillingController:didSelectBillingAddress:card:)]) {
        [self.delegate JSCheckoutCardBillingController:self didSelectBillingAddress:address card:nil];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CardCell *cell = [tableView dequeueReusableCellWithIdentifier:[CardCell cellIdentifier] forIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (self.card) {
            [cell.labelExpDate setText:[self.card formattedExpDate]];
            [cell setIsCard:YES];
            [cell setIsValid:[self.card isValid]];
            [cell.imageViewCardType setImage:[JSMercuryUtility cardImage:[self.card cardType]]];
            [cell.labelMaskedAccount setText:[self.card formattedMaskedAccount]];
            return cell;
        }
        
        [cell.labelExpDate setText:@""];
        [cell setIsCard:NO];
        [cell.imageViewCardType setImage:[JSMercuryUtility cardImage:nil]];
        [cell.labelMaskedAccount setText:@"Add Credit Card"];
        return cell;
    }
    
    if (indexPath.section == 1) {
        [cell.imageViewCardType setImage:nil];
        [cell.labelExpDate setText:@""];
        [cell setIsCard:NO];

        if (self.address) {
            [[cell labelMaskedAccount] setText:self.address.formattedMultiLineAddress];
            return cell;
        }
        
        [[cell labelMaskedAccount] setText:@"Add Billing Address"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self performSegueWithIdentifier:@"card" sender:nil];
    }
    
    if (indexPath.section == 1) {
        [self performSegueWithIdentifier:@"address" sender:nil];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"address"]) {
        JSCheckoutAddressController * address = [segue destinationViewController];
        [address setDelegate:self];
        address.billing = YES;
        address.selection = YES;
    }
    
    if ([[segue identifier] isEqualToString:@"card"]) {
        JSMercuryCardController *card = [segue destinationViewController];
        [card setDelegate:self];
        card.selection = YES;
    }
}


@end
