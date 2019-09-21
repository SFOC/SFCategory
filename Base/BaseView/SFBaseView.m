//
//  SFBaseView.m
//  绘制边框带箭头
//  Created by fly on 2018/5/4.
//  Copyright © 2018年 fly(石峰). All rights reserved.
//

#import "SFBaseView.h"

@implementation SFBaseView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialize];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
       
        [self initialize];
    }
    
    return self;
}


#pragma mark ---系统自带----
- (void)drawRect:(CGRect)rect {
    
    /// 随便设置个长宽
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);

    /// 设置边框颜色
    CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);

    /// 设置填充颜色
    CGContextSetFillColorWithColor(context, self.fillColor.CGColor);

    /** 先介绍 CGContextAddArcToPoint 参数
     * CGContextRef : 为获取的文本
     * x1, y1 : 第一点
     * x2, y2 : 第二点
     * radius : 圆角弧度
     * 说明 : 两点连线 如同矢量线, 有方向性.
     */
    switch (self.borderArrowDirect) {
        case sf_borderArrowDirectTop:
        {
            /// 开始点
            CGContextMoveToPoint(context, self.radian, 1 + self.arrowHeight); // 圆弧的起始点
            
            if (self.arrowSpaceX_YLength > 0) {
                
                CGContextAddLineToPoint(context, self.arrowSpaceX_YLength - self.arrowWidth/2.0, 1 + self.arrowHeight);
                
                CGContextAddLineToPoint(context, self.arrowSpaceX_YLength, 0);
                
                CGContextAddLineToPoint(context, self.arrowSpaceX_YLength + self.arrowWidth/2.0, 1 + self.arrowHeight);
            }else {
                
                CGContextAddLineToPoint(context, w/2 - self.arrowWidth/2.0, 1 + self.arrowHeight);
                
                CGContextAddLineToPoint(context, w/2, 0);
                
                CGContextAddLineToPoint(context, w/2 + self.arrowWidth/2.0, 1 + self.arrowHeight);
            }
            
            
            
            /// 两条线连接与方向为直角，设置弧度
            CGContextAddArcToPoint(context, w - 1, self.arrowHeight + 1, w - 1, self.radian + self.arrowHeight + 1, self.radian); // 右上角弧度设置
            
            CGContextAddArcToPoint(context, w - 1, h - 1, w - 1 - self.radian, h - 1, self.radian); // 右下角弧度设置
            
            CGContextAddArcToPoint(context, 1, h - 1, 1, h - 1 - self.radian, self.radian); // 左下角弧度
            
            CGContextAddArcToPoint(context, 1, 1 + self.arrowHeight, self.radian,1 + self.arrowHeight, self.radian); // 左上角弧度
            
            
        }
            break;
        case sf_borderArrowDirectRight:
        {
            CGContextMoveToPoint(context, w - 1 - self.arrowHeight, self.radian + 1);
            
            if (self.arrowSpaceX_YLength > 0) {
                
                CGContextAddLineToPoint(context, w - 1 - self.arrowHeight, self.arrowSpaceX_YLength - self.arrowWidth/2.0); // 箭头开始
                CGContextAddLineToPoint(context, w - 1, self.arrowSpaceX_YLength); // 箭头
                CGContextAddLineToPoint(context, w - 1 - self.arrowHeight, self.arrowSpaceX_YLength + self.arrowWidth/2); // 箭头尾

            }else {
                
                CGContextAddLineToPoint(context, w - 1 - self.arrowHeight, h/2.0 - self.arrowWidth/2.0); // 箭头开始
                CGContextAddLineToPoint(context, w - 1, h/2.0); // 箭头
                CGContextAddLineToPoint(context, w - 1 - self.arrowHeight, h/2.0 + self.arrowWidth/2); // 箭头尾

            }
            
            CGContextAddArcToPoint(context, w - 1 - self.arrowHeight , h - 1, w - 1- self.arrowHeight - self.radian, h - 1, self.radian); // 右下角
            
            CGContextAddArcToPoint(context, 1, h - 1, 1, h - 1 - self.radian, self.radian); // 左下角
            
            CGContextAddArcToPoint(context, 1, 1, self.radian + 1, 1, self.radian); // 左上角
            
            CGContextAddArcToPoint(context, w - 1 - self.arrowHeight, 1, w - 1 - self.arrowHeight, self.radian + 1, self.radian);
        }
            break;
        case sf_borderArrowDirectBottom:
        {
            /// 开始点
            CGContextMoveToPoint(context, self.radian, 1); // 圆弧的起始点
            
            /// 两条线连接与方向为直角，设置弧度
            CGContextAddArcToPoint(context, w - 1, 1, w - 1, self.radian, self.radian); // 右上角弧度设置
            
            // 设置右下角弧度
            CGContextAddArcToPoint(context, w - 1, h - self.arrowHeight, w - self.radian - 1, h - self.arrowHeight, self.radian);
            
            if (self.arrowSpaceX_YLength > 0) {
                
                CGContextAddLineToPoint(context, self.arrowSpaceX_YLength + self.arrowWidth/2.0 - 1, h - self.arrowHeight); // 向左画线
                
                CGContextAddLineToPoint(context, self.arrowSpaceX_YLength, h); // 左下直线
                
                CGContextAddLineToPoint(context, self.arrowSpaceX_YLength - self.arrowWidth/2.0 + 1, h - self.arrowHeight); // 左上直线
            }else {
                
                CGContextAddLineToPoint(context, w/2 + self.arrowWidth/2.0 - 1, h - self.arrowHeight); // 向左画线
                
                CGContextAddLineToPoint(context, w/2, h); // 左下直线
                
                CGContextAddLineToPoint(context, w/2 - self.arrowWidth/2.0 + 1, h - self.arrowHeight); // 左上直线
            }
            
            
            // 现在 [开始点] 坐标变为 (20, h ). 第一条线(20, h)-> (0, h) ; 第二条线(0, h)->(0, h - 10)
            CGContextAddArcToPoint(context, 1, h - self.arrowHeight, 1, h - self.arrowHeight - self.radian, self.radian); // 左下角圆弧设置完
            
            // 说明: 最开始设置的坐标点为(6, 0) 不为(0, 0). 就是为了最后可以连接上, 不然 画的线不能连接上 , 读者可自行试验
            CGContextAddArcToPoint(context, 1, 1, self.radian, 1, self.radian); // 左上角圆弧设置完
        }
            break;
        case sf_borderArrowDirectLeft:
        {
            if (self.arrowSpaceX_YLength > 0) {
                
                CGContextMoveToPoint(context, self.arrowHeight + 1, self.arrowSpaceX_YLength - self.arrowWidth/2.0);

            }else {
                
                CGContextMoveToPoint(context, self.arrowHeight + 1, h / 2.0 - self.arrowWidth/2.0);
            }
            
            CGContextAddArcToPoint(context,self.arrowHeight + 1, 1, w - self.radian - 1, 1, self.radian); // 左上角
            
            CGContextAddArcToPoint(context, w - 1, 1, w - 1, self.radian + 1, self.radian); // 右上角
            
            CGContextAddArcToPoint(context, w - 1, h - 1, w - self.radian - 1, h - 1, self.radian); // 右下角
            
            CGContextAddArcToPoint(context, self.arrowHeight + 1, h - 1, self.arrowHeight + 1, h / 2.0 + self.arrowWidth/2.0, self.radian); // 左下角
            
            if (self.arrowSpaceX_YLength > 0) {
                
                CGContextAddLineToPoint(context, self.arrowHeight + 1, self.arrowSpaceX_YLength + self.arrowWidth/2.0);
                CGContextAddLineToPoint(context, 0, self.arrowSpaceX_YLength);
                CGContextAddLineToPoint(context,self.arrowHeight + 1, self.arrowSpaceX_YLength - self.arrowWidth/2.0);
            }else {
                
                CGContextAddLineToPoint(context, self.arrowHeight + 1, h/2 + self.arrowWidth/2.0);
                CGContextAddLineToPoint(context, 0, h/2);
                CGContextAddLineToPoint(context,self.arrowHeight + 1, h / 2.0 - self.arrowWidth/2.0);
            }
        }
            break;
            
        default:
            break;
    }
    
    

    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
}


#pragma mark ---初始化---
/// 初始化
- (void)initialize {
    
    self.radian = 8;
    self.arrowHeight = 15;
    self.arrowWidth = 10;
    self.fillColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
    self.borderColor = [UIColor grayColor];
    self.borderArrowDirect = sf_borderArrowDirectBottom;
}

#pragma mark ---set方法---
- (void)setRadian:(CGFloat)radian {
    _radian = radian;
    [self setNeedsDisplay];
}

- (void)setArrowHeight:(CGFloat)arrowHeight {
    _arrowHeight = arrowHeight;
    [self setNeedsDisplay];
}

- (void)setArrowWidth:(CGFloat)arrowWidth {
    _arrowWidth = arrowWidth;
    [self setNeedsDisplay];
}

- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    [self setNeedsDisplay];
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    [self setNeedsDisplay];
}

- (void)setBorderArrowDirect:(SF_borderArrowDirect)borderArrowDirect {
    _borderArrowDirect = borderArrowDirect;
    [self setNeedsDisplay];
}

@end
