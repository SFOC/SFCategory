//
//  UIView+SFCornerRadius.m
//  Category
//
//  Created by fly on 17/3/15.
//  Copyright © 2017年 石峰. All rights reserved.
//

#import "UIView+SFCornerRadius.h"

@implementation UIView (SFCornerRadius)
-(void)viewWithCornerRadius:(CGFloat)radius {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = self.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
@end
