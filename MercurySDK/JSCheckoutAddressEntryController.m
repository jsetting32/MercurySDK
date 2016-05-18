//
//  JSBillingShippingController.m
//  MercurySDK
//
//  Created by John Setting on 5/10/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSCheckoutAddressEntryController.h"
#import "JSMercuryCoreDataController.h"
#import "NSManagedObject+Properties.h"
#import "Address.h"

@interface JSCheckoutAddressEntryController ()

@end

@implementation JSCheckoutAddressEntryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

- (IBAction)didTapSubmitButton:(UIBarButtonItem *)sender {

    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject:self.textFieldName.text forKey:@"name"];
    [data setObject:self.textFieldAddress.text forKey:@"address"];
    [data setObject:self.textFieldCity.text forKey:@"city"];
    [data setObject:self.textFieldState.text forKey:@"state"];
    [data setObject:self.textFieldPostalCode.text forKey:@"postalCode"];
    [data setObject:self.textFieldCountry.text forKey:@"country"];
    [data setObject:self.textFieldPhone.text forKey:@"phone"];
    [data setObject:@(self.billing) forKey:@"billing"];
    
    NSError *error = nil;
    Address *address = [Address saveAddress:data error:&error];
        
    if (self.entryDelegate && [self.entryDelegate respondsToSelector:@selector(JSCheckoutAddressEntryController:didTapSaveButton:address:)]) {
        [self.entryDelegate JSCheckoutAddressEntryController:self didTapSaveButton:sender address:address];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
