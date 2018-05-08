//
//  ViewController.m
//  SFDropDownMenu
//
//  Created by fly on 2018/5/6.
//  Copyright © 2018年 石峰(fly). All rights reserved.
//

#import "ViewController.h"
#import "SFDropDownMenu.h"

@interface ViewController ()<SFDropDownMenuDataSource,SFDropDownMenuDelegate>

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    SFDropDownMenu *menu = [[SFDropDownMenu alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
    menu.backgroundColor = [UIColor redColor];
    menu.dataSource = self;
    menu.delegate = self;
    [self.view addSubview:menu];
}

- (NSMutableArray<NSString *> *)sf_dropDownMenu:(SFDropDownMenu *)dropDownMenu {
    
    return @[@"附近",@"总价",@"户型",@"更多"].mutableCopy;
}

- (SF_DDMB_ShowViewType)sf_dropDownMenu:(SFDropDownMenu *)dropDownMenu index:(NSInteger)index {
    
    if (index == 0) {
        
        return SF_DDMB_ShowViewSingleRowType;
    }else {
        
        return SF_DDMB_ShowViewLinkageType;
    }
}

- (void)sf_dropDownMenu:(SFDropDownMenu *)dropDownMenu didSelectIndex:(NSInteger)index {
    
    NSLog(@"点击了==%ld",index);
}

@end
