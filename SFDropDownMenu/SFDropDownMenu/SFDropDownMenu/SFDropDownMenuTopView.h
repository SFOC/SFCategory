//
//  SFDropDownMenuTopView.h
//  SFDropDownMenu
//
//  Created by fly on 2018/5/6.
//  Copyright © 2018年 石峰(fly). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFDropDownMenuTopView : UIView

#pragma mark ---初始化方法---
/*!
 初始化方法
 titleArr：标题数组
 rect：传空默认（0，0，window.With, 50）
 */
+ (instancetype) initWithFrame:(CGRect)rect titleArr:(NSMutableArray *)titleArr;

#pragma mark ---属性----
/*! 标题字体大小（默认为15） */
@property (nonatomic, assign) CGFloat titleFont;

/*! 标题颜色（默认333333） */
@property (nonatomic, strong) UIColor *titleColor;

/*! 分割线颜色（默认系统灰色） */
@property (nonatomic, strong) UIColor *segmentLineColor;

#pragma mark ---方法和block回调---
/*!
 按钮的点击方法
 index：点击的按钮位置 第一个为0，一次类推
 */
@property (nonatomic, copy) void (^clickAction)(NSInteger index);
@end
