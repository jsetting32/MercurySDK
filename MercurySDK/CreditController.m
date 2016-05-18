//
//  CreditController.m
//  MercurySDK
//
//  Created by John Setting on 5/3/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "CreditController.h"
#import "CreditViewModel.h"
#import "JSMercuryUtility.h"
#import "NSManagedObject+Properties.h"
#import "VerifyCardInfo.h"
#import "JSMercuryCoreDataController.h"

@interface CreditController () <UITableViewDelegate, UITableViewDataSource, CreditViewModelDelegate>
@property (strong, nonatomic, nonnull) CreditViewModel *model;
@end

@implementation CreditController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (!(self = [super initWithCoder:aDecoder])) return nil;
    _model = [[CreditViewModel alloc] init];
    [_model setDelegate:self];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.model loadCredits];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UITableViewDataSource>
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.model tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model tableView:tableView numberOfRowsInSection:section];
}

- (void)creditViewModel:(CreditViewModel *)model didFinishLoadingCredits:(NSArray<CreditResponse *> *)cards error:(NSError *)error {
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSError *error = nil;
    NSArray *cards = [JSMercuryCoreDataController fetchVerifyCardInfoAll:error];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Choose Card" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (VerifyCardInfo *c in cards) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:c.maskedAccount style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            CreditResponse *card = [self.model.credits objectAtIndex:indexPath.row];
            [JSMercuryUtility showAlert:self creditResponse:card token:c.token completion:^{
                [card deleteObject:nil];
                [self.model.credits removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
                [self.model loadCredits];
            }];
        }];
        [alert addAction:action];
    }
    [self presentViewController:alert animated:YES completion:nil];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        CreditResponse *credit = [self.model.credits objectAtIndex:indexPath.row];
        [credit deleteObject:nil];
        [self.model.credits removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }
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
