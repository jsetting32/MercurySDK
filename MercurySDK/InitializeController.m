//
//  InitializeController.m
//  MercurySDK
//
//  Created by John Setting on 5/2/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "InitializeController.h"
#import "JSMercuryInitializePayment.h"
#import "JSMercuryInitializeCardInfo.h"
#import "JSMercuryWebViewController.h"

@interface InitializeController () <JSMercuryWebViewDelegate>

@end

@implementation InitializeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)JSMercuryWebViewController:(JSMercuryWebViewController *)controller didFinishWithPaymentResponse:(JSMercuryVerifyPayment *)response error:(NSError * _Nullable)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)JSMercuryWebViewController:(JSMercuryWebViewController *)controller didFinishWithCardInfoResponse:(JSMercuryVerifyCardInfo *)response error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:nil];    
}

- (IBAction)verifyPayment:(id)sender {
    JSMercuryInitializePayment *payment = [JSMercuryInitializePayment js_init];
    [payment setTotalAmount:@2];
    [payment setInvoice:@"012345"];
    [payment js_mercury_transaction:^(UINavigationController *navigationController, id webController, NSError *error) {
        if (error) {
            return;
        }
        
        [webController setDelegate:self];
        [self presentViewController:navigationController animated:YES completion:nil];
    }];
}

- (IBAction)verifyCardInfo:(id)sender {
    JSMercuryInitializeCardInfo *payment = [JSMercuryInitializeCardInfo js_init];
    [payment js_mercury_transaction:^(UINavigationController *navigationController, id webController, NSError *error) {
        if (error) {
            return;
        }
        
        [webController setDelegate:self];
        [self presentViewController:navigationController animated:YES completion:nil];
    }];
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
