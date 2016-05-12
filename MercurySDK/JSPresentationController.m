//
//  JSPresentationController.m
//  iMobileRep
//
//  Created by John Setting on 3/10/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSPresentationController.h"

@interface JSPresentationController()
@property (nonatomic, strong) UIView *dimmingView;
@end

@implementation JSPresentationController

- (UIView *)dimmingView {
    
    static UIView *instance = nil;
    if (instance == nil) {
        instance = [[UIView alloc] initWithFrame:self.containerView.bounds];
        instance.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    }
    
    [instance.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [instance removeGestureRecognizer:obj];
    }];
    
    [instance addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)]];

    return instance;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)presentationTransitionWillBegin {
    UIView *presentedView = self.presentedViewController.view;
    presentedView.layer.cornerRadius = 10.f;
    presentedView.layer.shadowColor = [[UIColor blackColor] CGColor];
    presentedView.layer.shadowOffset = CGSizeMake(0, 10);
    presentedView.layer.shadowRadius = 10;
    presentedView.layer.shadowOpacity = 0.5;
    
    self.dimmingView.frame = self.containerView.bounds;
    self.dimmingView.alpha = 0;
    [self.containerView addSubview:self.dimmingView];
    
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 1;
    } completion:nil];
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    if (!completed) {
        [self.dimmingView removeFromSuperview];
    }
}

- (void)dismissalTransitionWillBegin {
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 0;
    } completion:nil];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed) {
        [self.dimmingView removeFromSuperview];
    }
}

- (CGRect)frameOfPresentedViewInContainerView {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (void)containerViewWillLayoutSubviews {
    self.dimmingView.frame = self.containerView.bounds;
    self.presentedView.frame = [self frameOfPresentedViewInContainerView];
}

@end
