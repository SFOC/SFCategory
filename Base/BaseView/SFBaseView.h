//
//  SFBaseView.h
//  带有箭头的边框
//  Created by fly on 2018/5/4.
//  Copyright © 2018年 fly(石峰). All rights reserved.
//

#import <UIKit/UIKit.h>

/// 边框箭头方向枚举
typedef enum : NSUInteger {
    sf_borderArrowDirectTop = 1,
    sf_borderArrowDirectRight,
    sf_borderArrowDirectBottom,
    sf_borderArrowDirectLeft,
}SF_borderArrowDirect;

@interface SFBaseView : UIView

/// 弧度 （默认为8）
@property (nonatomic, assign) CGFloat radian;

/// 箭头高度 （默认为15）
@property (nonatomic, assign) CGFloat arrowHeight;

/// 箭头宽度 （默认为10）
@property (nonatomic, assign) CGFloat arrowWidth;

/// 边框颜色（默认灰色）
@property (nonatomic, strong) UIColor *borderColor; 

/*! 内部填充色（默认白色） */
@property (nonatomic, strong) UIColor *fillColor;

/// 边框箭头方向 （默认下）
@property (nonatomic, assign) SF_borderArrowDirect borderArrowDirect;

/*!
 箭头尖的位置：箭头默认在中间
 当箭头是上下，则是距离X轴的距离
 当箭头是左右，则是距离Y轴的距离
 
 */
@property (nonatomic, assign) CGFloat arrowSpaceX_YLength;
@end
