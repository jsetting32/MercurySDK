//
//  JSMercuryWebViewController.h
//  Fora
//
//  Created by John Setting on 4/26/16.
//  Copyright © 2016 Logiciel Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSMercuryVerifyCardInfo.h"
#import "JSMercuryVerifyPayment.h"

@protocol JSMercuryWebViewDelegate;
@interface JSMercuryWebViewController : UIViewController
@property (weak, nonatomic, nullable) id <JSMercuryWebViewDelegate> delegate;
@property (weak, nonatomic, nullable) IBOutlet UIWebView *webView;
@property (strong, nonatomic, nonnull) NSURLRequest *webRequest;
@end

@protocol JSMercuryWebViewDelegate <NSObject>
- (void)JSMercuryWebViewController:(nonnull JSMercuryWebViewController *)controller didFinishWithPaymentResponse:(JSMercuryVerifyPayment * _Nullable)response error:( NSError * _Nullable)error;
- (void)JSMercuryWebViewController:(nonnull JSMercuryWebViewController *)controller didFinishWithCardInfoResponse:(JSMercuryVerifyCardInfo * _Nullable)response error:( NSError * _Nullable)error;
@end
