//
//  JSAnimationController.m"
//  iMobileRep
//
//  Created by John Setting on 6/7/15.
//  Copyright (c) 2015 Logiciel Inc. All rights reserved.
//

#import "JSAnimationTransitionController.h"

@interface JSAnimationTransitionController()
@property (assign, nonatomic) NSTimeInterval transitionDuration;
@property (assign, nonatomic) kJSAnimationTransitionController transition;
@end

@implementation JSAnimationTransitionController

- (instancetype)init {
    return [self initWithTransitionDuration:0.8 animation:kJSAnimationTransitionControllerUnknown];
}

- (instancetype)initWithTransitionDuration:(NSTimeInterval)transitionDuration {
    return [self initWithTransitionDuration:transitionDuration animation:kJSAnimationTransitionControllerUnknown];
}

- (instancetype)initWithTransitionDuration:(NSTimeInterval)transitionDuration animation:(kJSAnimationTransitionController)animation {
    if (!(self = [super init])) return nil;
    _transitionDuration = transitionDuration;
    _transition = animation;
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return self.transitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (self.transition == kJSAnimationTransitionControllerFade) {
        [self slide:transitionContext];
        return;
    }

    if (self.transition == kJSAnimationTransitionControllerDepth) {
        [self depth:transitionContext];
        return;
    }
    
    if (self.transition == kJSAnimationTransitionControllerBounce) {
        [self bounce:transitionContext];
        return;
    }
    
    [self slide:transitionContext];
}

- (void)depth:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrameForToVc = [transitionContext finalFrameForViewController:toViewController];
    UIView *containerView = [transitionContext containerView];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    toViewController.view.frame = CGRectOffset(finalFrameForToVc, 0, bounds.size.height);
    [containerView addSubview:toViewController.view];
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:10
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         fromViewController.view.alpha = 0.7;
                         fromViewController.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
                         toViewController.view.frame = finalFrameForToVc;
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         toViewController.view.alpha = 1.0;
                     }];
}

- (void)bounce:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIView *presentedView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    
    presentedView.frame = containerView.bounds;
    [containerView addSubview:presentedView];
    
    CGAffineTransform transform = presentedView.transform;
    presentedView.transform = CGAffineTransformTranslate(transform, 0, containerView.bounds.size.height);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:10
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         presentedView.transform = transform;
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)slide:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIView *presentedView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    
    presentedView.frame = containerView.bounds;
    [containerView addSubview:presentedView];
    
    CGAffineTransform transform = presentedView.transform;
    presentedView.transform = CGAffineTransformTranslate(transform, 0, containerView.bounds.size.height);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        presentedView.transform = transform;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
