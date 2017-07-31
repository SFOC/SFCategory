//
//  UIWindow+rootAnimation.m
//  iOS-Core-Animation-Advanced-Techniques
//
//  Created by gykj on 15/11/18.
//  Copyright (c) 2015年 gykj. All rights reserved.
//

#import "UIWindow+RootAnimation.h"
//#import "UIView+DHSmartScreenshot.h"
@implementation UIWindow (RootAnimation)

- (void)setRootViewController:(UIViewController *)rootViewController
                     animated:(BOOL)animated {
    
    if (rootViewController) {
        
        if (animated) {
            if (self.rootViewController) {
                /* 1 */
                //                [UIView animateWithDuration:0.15 delay:0.0
                //                options:UIViewAnimationOptionCurveEaseInOut
                //                animations:^{
                //                    self.rootViewController.view.alpha=0.0;
                //                } completion:^(BOOL finished) {
                //                    rootViewController.view.alpha=0.0;
                //                    self.rootViewController=rootViewController;
                //                    [UIView animateWithDuration:0.35 delay:0.0
                //                    options:UIViewAnimationOptionCurveEaseInOut
                //                    animations:^{
                //                        self.rootViewController.view.alpha=1.0;
                //                    } completion:nil];
                //                }];
                //
                
                /* 2 */
                UIView *tempView = self.rootViewController.view;
                self.rootViewController = rootViewController;
                [self insertSubview:tempView belowSubview:self.rootViewController.view];
                
                CGPoint center =
                CGPointMake([UIScreen mainScreen].bounds.size.width / 2.0,
                            [UIScreen mainScreen].bounds.size.height / 2.0);
                self.rootViewController.view.center = CGPointMake(
                                                                  center.x, center.y + CGRectGetHeight([UIScreen mainScreen].bounds));
                
                [UIView animateWithDuration:0.4
                                      delay:0.0
                                    options:UIViewAnimationOptionCurveEaseInOut
                                 animations:^{
                                     tempView.alpha = 0.5;
                                     self.rootViewController.view.center = center;
                                 }
                                 completion:^(BOOL finished) {
                                     [tempView removeFromSuperview];
                                 }];
                tempView = nil;
            } else {
                self.rootViewController = rootViewController;
            }
        } else {
            self.rootViewController = rootViewController;
        }
    }
}

@end
