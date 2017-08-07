//
//  UILabel+SFChangeStringDifferentLocationScaleOrColor.m
//  
//  设置label富文本
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 Fly. All rights reserved.
//

#import "UILabel+SFChangeStringDifferentLocationScaleOrColor.h"

@implementation UILabel (SFChangeStringDifferentLocationScaleOrColor)

- (void)setLabelTextScaleOrColorWith:(NSString *)contentStr BigFontSize:(CGFloat)bigFontSize BigColor:(UIColor *)bigColor BigStrRange:(NSRange)bigRange otherFontSize:(CGFloat)otherFontSize otherColor:(UIColor *)otherColor otherRange:(NSRange)otherRange {
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:contentStr];
    UIFont *bigFont = [UIFont systemFontOfSize:bigFontSize];
    [attrString addAttribute:NSFontAttributeName value:bigFont range:bigRange];
    [attrString addAttribute:NSForegroundColorAttributeName value:bigColor range:bigRange];
    
    UIFont *otherFont = [UIFont systemFontOfSize:otherFontSize];
    [attrString addAttribute:NSFontAttributeName value:otherFont range:otherRange];
    [attrString addAttribute:NSForegroundColorAttributeName value:otherColor range:otherRange];
    
    [self setAttributedText:attrString];
}


@end
