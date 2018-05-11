//
//  SFDDMBottomSingleOrMultiSelectView.m
//  SFDropDownMenu
//  单选或多选view
//  Created by fly on 2018/5/6.
//  Copyright © 2018年 石峰(fly). All rights reserved.
//

#import "SFDDMBottomSingleOrMultiSelectView.h"
#import "SFDropDownMenuMaro.h"

@implementation SFDDMBottomSingleOrMultiSelectView
#pragma mark -------------------------初始化-------------------
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self sfinitialize];
        [self createUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self sfinitialize];
        [self createUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self sfinitialize];
    [self createUI];
}

#pragma mark ----私有方法---
- (void) createUI {
    
    
}

/// 初始化值
- (void) sfinitialize {

    self.borderArrowDirect = sf_borderArrowDirectTop;
    self.arrowSpaceX_YLength = 20;
    self.radian = 10;
    self.borderColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor greenColor];

}

@end
