//
//  JSAnimationController
//  iMobileRep
//
//  Created by John Setting on 6/7/15.
//  Copyright (c) 2015 Logiciel Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, kJSAnimationTransitionController) {
    kJSAnimationTransitionControllerBounce      = 1 << 0,
    kJSAnimationTransitionControllerFade        = 1 << 1,
    kJSAnimationTransitionControllerDepth       = 1 << 2,
    kJSAnimationTransitionControllerSlide       = 1 << 3,
    kJSAnimationTransitionControllerUnknown     = 1 << 4
};

@interface JSAnimationTransitionController : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithTransitionDuration:(NSTimeInterval)transitionDuration;
- (instancetype)initWithTransitionDuration:(NSTimeInterval)transitionDuration animation:(kJSAnimationTransitionController)animation;

@end
