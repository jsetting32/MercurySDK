//
//  CardController.m
//  MercurySDK
//
//  Created by John Setting on 5/2/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "CardController.h"
#import "CardViewModel.h"
#import "JSMercury.h"
#import "NSManagedObject+Properties.h"
#import "JSMercuryInitializeCardInfo.h"

@interface CardController () <UITableViewDelegate, UITableViewDataSource, CardViewModelDelegate>
@property (strong, nonatomic, nonnull) CardViewModel *model;
@end

@implementation CardController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (!(self = [super initWithCoder:aDecoder])) return nil;
    _model = [[CardViewModel alloc] init];
    [_model setDelegate:self];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.model loadCards];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.model numberOfSectionsInTableView:tableView];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.model tableView:tableView titleForHeaderInSection:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        VerifyCardInfo *card = [[self.model cards] objectAtIndex:indexPath.row];
        [self deleteCard:card];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    
    JSMercuryInitializeCardInfo *payment = [JSMercuryInitializeCardInfo js_init];
    [payment js_mercury_transaction:^(UINavigationController *navigationController, id webController, NSError *error) {
        if (error) {
            return;
        }
        
        [webController setDelegate:self];
        [self presentViewController:navigationController animated:YES completion:nil];
    }];
}

- (void)deleteCard:(VerifyCardInfo *)card {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Payment" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"Delete Card" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSError *error = nil;
        if (![card deleteObject:&error]) {
            UIAlertController *delete = [UIAlertController alertControllerWithTitle:@"Delete Card Error" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okay = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
            UIAlertAction *retry = [UIAlertAction actionWithTitle:@"Retry" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self deleteCard:card];
            }];
            [delete addAction:okay];
            [delete addAction:retry];
            [self presentViewController:delete animated:YES completion:nil];
            return;
        }
        
        UIAlertController *delete = [UIAlertController alertControllerWithTitle:@"Delete Card" message:@"Successfully Deleted Card" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okay = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.model loadCards];
        }];
        [delete addAction:okay];
        [self presentViewController:delete animated:YES completion:nil];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:delete];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)cardViewModel:(CardViewModel *)model didFinishLoadingCards:(NSArray<VerifyCardInfo *> *)cards error:(NSError *)error {
    [self.tableView reloadData];
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
