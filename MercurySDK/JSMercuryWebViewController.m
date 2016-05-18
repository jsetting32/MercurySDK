//
//  JSMercuryWebViewController.m
//  Fora
//
//  Created by John Setting on 4/26/16.
//  Copyright © 2016 Logiciel Inc. All rights reserved.
//

#import "JSMercuryWebViewController.h"
#import "JSMercuryUtility.h"
#import "JSMercuryVerify.h"
#import "JSMercuryVerifyPayment.h"
#import "JSMercuryVerifyCardInfo.h"
#import "JSMercuryInitializePayment.h"
#import "JSMercuryInitializeCardInfo.h"

@interface JSMercuryWebViewController () <UIWebViewDelegate>

@end

@implementation JSMercuryWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(didTapCancelButton:)]];
    [self.webView loadRequest:self.webRequest];
}

- (void)didTapCancelButton:(UIBarButtonItem *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    JSMercuryInitialize *init = [[JSMercuryUtility sharedInstance] initializer];
    NSNumber * type = @0;
    if ([init isKindOfClass:[JSMercuryInitializePayment class]]) type = @1;
    if ([init isKindOfClass:[JSMercuryInitializeCardInfo class]]) type = @2;
    
    NSString *URLString = [[request URL] absoluteString];

    if ([URLString hasSuffix:init.processCompleteUrl]) {
        [webView stopLoading];
        if ([type isEqualToNumber:@1]) {
            JSMercuryVerifyPayment *payment = [[JSMercuryVerifyPayment alloc] init];
            [payment js_verify_payment:^(JSMercuryVerifyPayment * _Nullable verification, NSError * _Nullable error) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(JSMercuryWebViewController:didFinishWithPaymentResponse:error:)]) {
                    [self.delegate JSMercuryWebViewController:self didFinishWithPaymentResponse:verification error:error];
                } else {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }];
        }

        if ([type isEqualToNumber:@2]) {
            JSMercuryVerifyCardInfo *payment = [[JSMercuryVerifyCardInfo alloc] init];
            [payment js_verify_cardInfo:^(JSMercuryVerifyCardInfo * _Nullable verification, NSError * _Nullable error) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(JSMercuryWebViewController:didFinishWithCardInfoResponse:error:)]) {
                    [self.delegate JSMercuryWebViewController:self didFinishWithCardInfoResponse:verification error:error];
                } else {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }];
        }
    }
    
    if ([URLString hasSuffix:init.returnUrl]) {
        [webView stopLoading];
        if ([type isEqualToNumber:@1]) {
            JSMercuryVerifyPayment *payment = [[JSMercuryVerifyPayment alloc] init];
            [payment js_verify_payment:^(JSMercuryVerifyPayment * _Nullable verification, NSError * _Nullable error) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(JSMercuryWebViewController:didFinishWithPaymentResponse:error:)]) {
                    [self.delegate JSMercuryWebViewController:self didFinishWithPaymentResponse:verification error:error];
                } else {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }];
        }
        
        if ([type isEqualToNumber:@2]) {
            JSMercuryVerifyCardInfo *payment = [[JSMercuryVerifyCardInfo alloc] init];
            [payment js_verify_cardInfo:^(JSMercuryVerifyCardInfo * _Nullable verification, NSError * _Nullable error) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(JSMercuryWebViewController:didFinishWithCardInfoResponse:error:)]) {
                    [self.delegate JSMercuryWebViewController:self didFinishWithCardInfoResponse:verification error:error];
                } else {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }];
        }
    }

    return YES;
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
