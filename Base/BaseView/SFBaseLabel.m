//
//  SFBaseLabel.m
//  带有删除线的label
//
//  Created by fly on 2018/5/4.
//  Copyright © 2018年 fly(石峰). All rights reserved.
//

#import "SFBaseLabel.h"

#define SFSTRING_IS_NOT_NULL(string) !(string == nil || [string isEqualToString:@""] || [string isEqual:[NSNull null]])

@implementation SFBaseLabel

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    [self inititalize];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self inititalize];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self inititalize];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    [self layoutIfNeeded];
    
    /// 获取文本
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    CGFloat textWidth = [self widthReturnWithHeight:self.frame.size.height font:self.font.pointSize text:self.text];
    
    CGFloat startPointX = 0;
    if (self.textAlignment == NSTextAlignmentCenter) {
        
        startPointX = (rect.size.width - textWidth)/2.0;
    }else if (self.textAlignment == NSTextAlignmentLeft) {
        
        startPointX = 0;
    }else if (self.textAlignment == NSTextAlignmentRight) {
        
        startPointX = rect.size.width - textWidth;
    }
    
    
    
    /// 设置起始点坐标
    CGContextMoveToPoint(context, startPointX, rect.size.height/2.0);
    
    /// 设置连线点
    CGContextAddLineToPoint(context, textWidth + startPointX, rect.size.height / 2.0);
    
    /// 设置颜色，宽度
    [self.deleteLineColor set];
    CGContextSetLineWidth(context, 1);
    
    CGContextStrokePath(context);
}

#pragma mark ----私有方法---
/// 计算label的宽度
- (CGFloat) widthReturnWithHeight:(CGFloat)height font:(CGFloat)font text:(NSString *)text  {
    
    if (!SFSTRING_IS_NOT_NULL(text)) {
        
        return 0;
    }
    CGRect rect = [text boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return rect.size.width;
}

/// 初始化值
- (void) inititalize {
    
    self.deleteLineColor = [UIColor redColor];
}
@end













