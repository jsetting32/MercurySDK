//
//  JSCheckoutPresentationController.m
//  MercurySDK
//
//  Created by John Setting on 5/10/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSCheckoutPresentationController.h"
#import "JSCheckoutController.h"

@implementation JSCheckoutPresentationController

- (void)presentationTransitionWillBegin {
    [super presentationTransitionWillBegin];
    
    UIView *presentedView = self.presentedViewController.view;
    presentedView.layer.cornerRadius = 0.f;
    presentedView.layer.shadowColor = [[UIColor blackColor] CGColor];
    presentedView.layer.shadowOffset = CGSizeMake(0, -5);
    presentedView.layer.shadowRadius = 5.f;
    presentedView.layer.shadowOpacity = 0.5f;
}

- (CGRect)frameOfPresentedViewInContainerView {
    return [JSCheckoutController suggestedEndingRect];
}

@end
