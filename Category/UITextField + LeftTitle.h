//
//  UITextField + LeftTitle.h
//  OA
//
//  Created by mac on 16/6/27.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (LeftTitle)

@property(nonatomic, strong) UILabel *leftLb;

- (void)setLeftTitle:(NSString *)title;

- (void)setLeftSpace:(CGFloat)space;

@end
