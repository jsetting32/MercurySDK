//
//  JSMercuryCardController.m
//  MercurySDK
//
//  Created by John Setting on 5/12/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSMercuryCardController.h"
#import "CardViewModel.h"
#import "CardCell.h"
#import "JSMercuryInitializeCardInfo.h"
#import "NSManagedObject+Properties.h"

@interface JSMercuryCardController () <UITableViewDelegate, UITableViewDataSource, CardViewModelDelegate>
@property (strong, nonatomic, nonnull) CardViewModel *model;
@end

@implementation JSMercuryCardController

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
        if (self.selection) {
            VerifyCardInfo *card = [[self.model cards] objectAtIndex:indexPath.row];
            if (self.delegate && [self.delegate respondsToSelector:@selector(JSMercuryCardController:didSelectCard:)]) {
                [self.delegate JSMercuryCardController:self didSelectCard:card];
                return;
            }
        }
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        VerifyCardInfo *card = [[self.model cards] objectAtIndex:indexPath.row];
        [self deleteCard:card indexPath:indexPath];
    }
}

- (void)deleteCard:(VerifyCardInfo *)card indexPath:(NSIndexPath *)indexPath {
    NSError *error = nil;
    if (![card deleteObject:&error]) {
        UIAlertController *delete = [UIAlertController alertControllerWithTitle:@"Delete Card Error" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okay = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *retry = [UIAlertAction actionWithTitle:@"Retry" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self deleteCard:card indexPath:indexPath];
        }];
        [delete addAction:okay];
        [delete addAction:retry];
        [self presentViewController:delete animated:YES completion:nil];
        return;
    }
    
    [[self.model cards] removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    
    UIAlertController *delete = [UIAlertController alertControllerWithTitle:@"Delete Card" message:@"Successfully Deleted Card" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okay = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.model loadCards];
    }];
    [delete addAction:okay];
    [self presentViewController:delete animated:YES completion:nil];
}

- (void)CardViewModel:(CardViewModel *)model didFinishLoadingCards:(NSArray<VerifyCardInfo *> *)cards error:(NSError *)error {
    [self.tableView reloadData];
}

@end
