//
//  SF_BaseTextView.h
//  YN_PassWordView
//
//  Created by fly（石峰） on 2018/6/13.
//  Copyright © 2018年 ijianghu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SF_BaseTextView : UITextView

/// 限制字数设置（不设置则为无数）
@property (nonatomic, assign) NSInteger limitWordsNum;

/// 占位字符
@property (nonatomic, strong) NSString *placeholder;

/// 内边距设置(默认 5，5，5，5)
@property (nonatomic, assign) UIEdgeInsets paddingEdgeInset;

/// 边框颜色（默认为f2f2f2）
@property (nonatomic, strong) UIColor *borderColor;

/// 边框宽度（默认为1）
@property (nonatomic, assign) CGFloat borderWidth;

/// 是否有圆角（默认有）
@property (nonatomic, assign) BOOL isRoundCorner;

/// 圆角值 (默认5)
@property (nonatomic, assign) CGFloat roundCornerValue;

/// 字体大小（默认15）
@property (nonatomic, assign) CGFloat fontSize;

/// 光标颜色（默认blue）
@property (nonatomic, strong) UIColor *cursorColor;
#pragma mark ---颜色---
/*！
 text变化的时候的block回调
 text：当前的textView的内容
 currentWordsNum：当前字数
 */
@property (nonatomic, copy) void (^textChangeBlock)(NSString *text, NSInteger currentWordsNum);

/// 超出限制字符block
@property (nonatomic, copy) void (^beyondLimitWords)(void);
@end
