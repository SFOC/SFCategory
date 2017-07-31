//
//  UIAlertController+MZStyle.h
//  customAlert
//
//  Created by Michal Zaborowski on 16.01.2016.
//  Copyright © 2016 Michal Zaborowski. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIView (INSRecursiveSubviews)
- (void)enumerateAllSubviewsUsingBlock:
    (void (^)(__kindof UIView *subview))block;
- (BOOL)isAnySuperviewUntilView:(UIView *)view isKindOfClass:(Class) class;
@end

@interface UIAlertController (MZStyle)
@property(nonatomic, assign) NSUInteger selectedIndex;

@end
