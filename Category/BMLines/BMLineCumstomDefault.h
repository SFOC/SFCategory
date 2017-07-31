//
//  BMLineType.h
//  BMLine
//
//  Created by NADA_BM on 15/10/21.
//  Copyright © 2015年 NADA_BM. All rights reserved.
//

#import "BMDefines.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  普通直线
 */
@interface BMLineCumstomDefault : UIView
@property(strong, nonatomic) UIColor *lineColor;
@end

/**
 *  虚线
 */
@interface BMLineCumstomDash : UIView
@property(strong, nonatomic) UIColor *lineColor;
@end

/**
 *  小圆点
 */
@interface BMLineCumstomDot : UIView
@property(strong, nonatomic) UIColor *lineColor;
@end