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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VerifyCardInfo *payment = [self.model.cards objectAtIndex:indexPath.row];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Actions" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *adjust = [UIAlertAction actionWithTitle:@"Adjust" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        JSMercuryCreditTokenAdjust *a = [[JSMercuryCreditTokenAdjust alloc] initWithToken:payment.token];
        [a js_mercury_credit_token:^(JSMercuryCreditTokenResponse * _Nullable response, NSError * _Nullable error) {
            NSString *message = (error) ? [error localizedFailureReason] : @"Successfully made transaction action";
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Status" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];

        }];
    }];
    UIAlertAction *preauth = [UIAlertAction actionWithTitle:@"PreAuth" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        JSMercuryCreditTokenPreAuth *preAuth = [[JSMercuryCreditTokenPreAuth alloc] initWithToken:payment.token];
        [preAuth js_mercury_credit_token:^(JSMercuryCreditTokenResponse * _Nullable response, NSError * _Nullable error) {
            NSString *message = (error) ? [error localizedFailureReason] : @"Successfully made transaction action";
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Status" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];

        }];
    }];
    UIAlertAction *preauthCapture = [UIAlertAction actionWithTitle:@"PreAuthCapture" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        JSMercuryCreditTokenPreAuthCapture *preAuth = [[JSMercuryCreditTokenPreAuthCapture alloc] initWithToken:payment.token];
        [preAuth js_mercury_credit_token:^(JSMercuryCreditTokenResponse * _Nullable response, NSError * _Nullable error) {
            NSString *message = (error) ? [error localizedFailureReason] : @"Successfully made transaction action";
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Status" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];

        }];
    }];
    UIAlertAction *returna = [UIAlertAction actionWithTitle:@"Return" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        JSMercuryCreditTokenReturn *preAuth = [[JSMercuryCreditTokenReturn alloc] initWithToken:payment.token];
        [preAuth js_mercury_credit_token:^(JSMercuryCreditTokenResponse * _Nullable response, NSError * _Nullable error) {
            NSString *message = (error) ? [error localizedFailureReason] : @"Successfully made transaction action";
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Status" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];

        }];
    }];
    UIAlertAction *reversal = [UIAlertAction actionWithTitle:@"Reversal" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        JSMercuryCreditTokenReversal *preAuth = [[JSMercuryCreditTokenReversal alloc] initWithToken:payment.token];
        [preAuth js_mercury_credit_token:^(JSMercuryCreditTokenResponse * _Nullable response, NSError * _Nullable error) {
            NSString *message = (error) ? [error localizedFailureReason] : @"Successfully made transaction action";
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Status" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];

        }];
        
    }];
    UIAlertAction *sale = [UIAlertAction actionWithTitle:@"Sale" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        JSMercuryCreditTokenSale *preAuth = [[JSMercuryCreditTokenSale alloc] initWithToken:payment.token];
        preAuth.purchaseAmount = @10;
        preAuth.invoice = @"1234";
        [preAuth js_mercury_credit_token:^(JSMercuryCreditTokenResponse * _Nullable response, NSError * _Nullable error) {
            NSString *message = (error) ? [error localizedFailureReason] : @"Successfully made transaction action";
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Status" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }];
        
    }];
    UIAlertAction *voidSale = [UIAlertAction actionWithTitle:@"VoidSale" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        JSMercuryCreditTokenVoidSale *preAuth = [[JSMercuryCreditTokenVoidSale alloc] initWithToken:payment.token];
        [preAuth js_mercury_credit_token:^(JSMercuryCreditTokenResponse * _Nullable response, NSError * _Nullable error) {
            NSString *message = (error) ? [error localizedFailureReason] : @"Successfully made transaction action";
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Status" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];

        }];
        
    }];
    UIAlertAction *voidReturn = [UIAlertAction actionWithTitle:@"VoidReturn" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        JSMercuryCreditTokenVoidReturn *preAuth = [[JSMercuryCreditTokenVoidReturn alloc] initWithToken:payment.token];
        [preAuth js_mercury_credit_token:^(JSMercuryCreditTokenResponse * _Nullable response, NSError * _Nullable error) {
            NSString *message = (error) ? [error localizedFailureReason] : @"Successfully made transaction action";
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Status" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];

        }];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:adjust];
    [alert addAction:preauth];
    [alert addAction:preauthCapture];
    [alert addAction:returna];
    [alert addAction:reversal];
    [alert addAction:sale];
    [alert addAction:voidSale];
    [alert addAction:voidReturn];
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
