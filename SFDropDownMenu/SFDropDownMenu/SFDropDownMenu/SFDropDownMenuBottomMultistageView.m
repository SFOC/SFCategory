//
//  SFDropDownMenuBottomMultistageView.m
//  SFDropDownMenu
//  底部联动的多级view
//  Created by fly on 2018/5/6.
//  Copyright © 2018年 石峰(fly). All rights reserved.
//

#import "SFDropDownMenuBottomMultistageView.h"
#import "SFDropDownMenuMaro.h"

@implementation SFDropDownMenuBottomMultistageView

#pragma mark -------------------------初始化-------------------
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initializesf];
        [self createUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializesf];
        [self createUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initializesf];
    [self createUI];
}

#pragma mark ----私有方法---
- (void) createUI {
    
    
}

/// 初始化值
- (void) initializesf {
    
    self.borderArrowDirect = sf_borderArrowDirectTop;
    self.arrowSpaceX_YLength = 20;
    self.radian = 10;
    self.borderColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor orangeColor];
    
}

@end
