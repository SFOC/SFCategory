//
//  BMLine.h
//  BMLine
//
//  Created by NADA_BM on 15/10/21.
//  Copyright © 2015年 NADA_BM. All rights reserved.
//

#import "BMDefines.h"
#import "BMLineCumstomDefault.h"
#import <UIKit/UIKit.h>

extern NSString *const BMLineType;
extern NSString *const BMLineOffset;
extern NSString *const BMLineBothSides;

@interface UIView (BMLine)

/**
 *  快速添加线 默认 直线 bottom lightGrayColor
 */
- (void)addLine;
/**
 *  快速添加线 默认 直线 bottom
 */
- (void)addLineWithColor:(UIColor *)color;
/**
 *  快速添加线 默认直线
 */
- (void)addLineWithColor:(UIColor *)color
                position:(BMLinePostionCustom)position;

/**
 *  根据参数在对应位置添加线条
 *
 *  @param color      线条颜色 默认 lightGrayColor
 *  @param position   位置
 *  @param attributes 其他参数
 *  @param BMLineType 传BMLineTypeCustom类型的NSNumber 直线、虚线、小圆点
 *  @param BMLineOffset 偏移量 正数为 上或左偏移 反之 右或下
 * 传NSNumber或NSStirng
 *  @param BMLineBothSides  0或非0  0为1端偏移  非0为两端偏移
 * 传NSNumber或NSStirng
 *  example:attributes:@{BMLineType:@(BMLineTypeCustomDash),BMLineOffset:@-20,BMLineBothSides:@"0"}
 */
- (void)addLineWithColor:(UIColor *)color
                position:(BMLinePostionCustom)position
              attributes:(NSDictionary *)attributes;

/**
 *  根据参数所给的位置信息删除相应的线
 *  @param position 线所在的位置
 */
- (void)removeLineWithPosition:(BMLinePostionCustom)position;

/**
 *  删除此View上所有的BMLine
 */
- (void)removeAllLines;

@end
