//
//  UILabel+SFChangeStringDifferentLocationScaleOrColor.h
//
//  设置label富文本
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 Fly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SFChangeStringDifferentLocationScaleOrColor)
/*!
 *  设置Label的text，同时设置不同位置的text的字体大小和颜色
 *
 *  @param contentStr    内容str
 *  @param bigFontSize   大字体的大小
 *  @param bigColor      大字体的颜色
 *  @param bigRange      大字体的范围
 *  @param otherFontSize 其他字体大小
 *  @param otherColor    其他字体颜色
 *  @param otherRange    其他字体的范围
 */
- (void)setLabelTextScaleOrColorWith:(NSString *)contentStr BigFontSize:(CGFloat)bigFontSize BigColor:(UIColor *)bigColor BigStrRange:(NSRange)bigRange otherFontSize:(CGFloat)otherFontSize otherColor:(UIColor *)otherColor otherRange:(NSRange)otherRange;

@end










