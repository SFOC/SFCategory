//
//  SFDropDownMenuTopView.m
//  SFDropDownMenu
//
//  Created by fly on 2018/5/6.
//  Copyright © 2018年 石峰(fly). All rights reserved.
//

#import "SFDropDownMenuTopView.h"
#import "SFDropDownMenuMaro.h"

@interface SFDropDownMenuTopView ()

@property (nonatomic, strong) NSMutableArray *titleMArr;

@property (nonatomic, assign) CGRect rect;
@end

@implementation SFDropDownMenuTopView

+ (instancetype)initWithFrame:(CGRect)rect titleArr:(NSMutableArray *)titleArr {
    
    SFDropDownMenuTopView *topView;
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
        
        topView = [[self alloc] initWithFrame:CGRectMake(0, 0, SF_DDM_Width, 50)];
        topView.rect = CGRectMake(0, 0, SF_DDM_Width, 50);
    }else {
        
        topView = [[self alloc] initWithFrame:rect];
        topView.rect = rect;
    }
    
    topView.titleMArr = titleArr;
    
    [topView initialize];
    [topView createUI];
    [topView segmentLineCreate];
    return topView;
}

#pragma mark ---私有方法---
/// 创建UI
- (void) createUI {
    
    CGFloat width = self.rect.size.width / self.titleMArr.count;
    
    for (int i = 0; i < self.titleMArr.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:self.titleFont];
        [btn setTitleColor:self.titleColor forState:UIControlStateNormal];
//        [btn setBackgroundImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#>]
        [btn setTitle:self.titleMArr[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(width*i, 0, width, self.rect.size.height);
        btn.tag = 8000 + i;
        [btn addTarget:self action:@selector(btnTitleAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

/// 创建分割线
- (void) segmentLineCreate {
    CGFloat width = self.rect.size.width / self.titleMArr.count;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = 1;
    shapeLayer.strokeColor = self.segmentLineColor.CGColor;
    
    UIBezierPath *topLinePath = [UIBezierPath bezierPath];
    [topLinePath moveToPoint:CGPointMake(self.rect.origin.x, 0)];
    [topLinePath addLineToPoint:CGPointMake(self.rect.size.width, 0)];
    
    for (int i = 1; i < self.titleMArr.count; i++) {
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(i*width, self.rect.origin.y + 4)];
        [path addLineToPoint:CGPointMake(i*width, self.rect.size.height - 4)];
        [topLinePath appendPath:path];
    }
    
    shapeLayer.path = topLinePath.CGPath;
    [self.layer addSublayer:shapeLayer];
}

#pragma mark ---初始化变量---
- (void) initialize {
    
    self.backgroundColor = [UIColor whiteColor];
    self.titleFont = 15;
    self.titleColor = SF_UIColorFromRGBAHEX(0x333333);
    self.segmentLineColor = [UIColor lightGrayColor];
}

#pragma mark ---按钮的点击方法---
- (void) btnTitleAction:(UIButton *)sender {
    
    if (self.clickAction) {
        
        self.clickAction(sender.tag - 8000);
    }
}
@end













