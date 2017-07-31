//
//  UITextField + LeftTitle.m
//  OA
//
//  Created by mac on 16/6/27.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UITextField + LeftTitle.h"
#import <objc/runtime.h>

static const char *leftLabel = "leftLabel";

@implementation UITextField (LeftTitle)

- (UILabel *)leftLb {
    
    if (!objc_getAssociatedObject(self, &leftLabel)) {
        [self setLeftLb:nil];
    }
    return objc_getAssociatedObject(self, &leftLabel);
}

- (void)setLeftLb:(UILabel *)leftLb {
    
    CGFloat width = 60;
    if (!leftLb) {
        leftLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, self.frame.size.height)];
        leftLb.textColor = [UIColor blackColor];
        leftLb.font = [UIFont systemFontOfSize:15];
        leftLb.textAlignment = NSTextAlignmentCenter;
        leftLb.backgroundColor = [UIColor clearColor];
        leftLb.numberOfLines = 0;
    }
    else{
        width =CGRectGetMaxX(leftLb.frame);
    }
    objc_setAssociatedObject(self, &leftLabel, leftLb,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(!self.leftView){
        [self setLeftSpace:width];
    }
    [self.leftView addSubview:leftLb];
 
}

- (void)setLeftTitle:(NSString *)title {
    self.leftLb.text = title;
}

- (void)setLeftSpace:(CGFloat)space {
    
    UIView *blankV = [UIView new];
    blankV.backgroundColor = [UIColor clearColor];
    blankV.frame = CGRectMake(0, 0, space, self.frame.size.height);
    self.leftView = blankV;
    self.leftViewMode = UITextFieldViewModeAlways;
}


@end
