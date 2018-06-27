//
//  SF_CountdownView.h
//  测试
//
//  Created by fly on 2018/6/27.
//  Copyright © 2018年 fly(石峰). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SF_CountdownView : UIView

/// 总秒数 默认10秒
@property (nonatomic, assign) NSInteger totalSeconds;

/// 倒计时按钮的颜色 ，默认白色
@property (nonatomic, strong) UIColor *countdownBtnBackgroundColor;

/// 倒计时按钮字体的颜色 ，默认黑色色
@property (nonatomic, strong) UIColor *countdownBtnTitleColor;

/// 圈颜色，默认blue
@property (nonatomic, strong) UIColor *circleColor;


/// 点击了倒计时按钮
@property (nonatomic, copy) void (^clickCountdownBtnBlock)(void);

/// 倒计时完成
@property (nonatomic, copy) void (^countdownCompleteBlock)(void);

/// 开始动画
- (void) startAnimation;

@end
