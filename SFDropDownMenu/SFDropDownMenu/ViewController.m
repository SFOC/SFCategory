//
//  ViewController.m
//  SFDropDownMenu
//
//  Created by fly on 2018/5/6.
//  Copyright © 2018年 石峰(fly). All rights reserved.
//

#import "ViewController.h"
#import "SFDropDownMenu.h"
#import "SFDDMBottomSingleOrMultiSelectView.h"
#import "SFDropDownMenuBottomMultistageView.h"

@interface ViewController ()<SFDropDownMenuDataSource,SFDropDownMenuDelegate>

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    SFDropDownMenu *menu = [[SFDropDownMenu alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
    menu.backgroundColor = [UIColor redColor];
    
    [menu registerClass:[SFDDMBottomSingleOrMultiSelectView class] forViewReuseIdentifier:@"cell1"];
    [menu registerClass:[SFDropDownMenuBottomMultistageView class] forViewReuseIdentifier:@"cell2"];
    
    menu.dataSource = self;
    menu.delegate = self;
    [self.view addSubview:menu];
    
}

- (NSInteger)titleNumInSf_dropDownMenu:(SFDropDownMenu *)dropDownMenu {
    
    return 6;
}

- (NSMutableArray<NSString *> *)sf_dropDownMenu:(SFDropDownMenu *)dropDownMenu {
    
    return @[@"附近",@"总价",@"户型",@"更多"].mutableCopy;
}


- (UIView *)sf_dropDownMenuShowView:(SFDropDownMenu *)dropDownMenu index:(NSInteger)index {
    
    if (index == 0 || index == 2) {
    
        SFDDMBottomSingleOrMultiSelectView *view = [dropDownMenu dequeueReusableViewWithIdentifier:@"cell1" index:index];
        view.backgroundColor = [UIColor greenColor];
       
        return view;
    }else {

        SFDropDownMenuBottomMultistageView *view = [dropDownMenu dequeueReusableViewWithIdentifier:@"cell2" index:index];
        return view;
    }
    
    return nil;
}

- (CGRect)sf_dropDownMenu:(SFDropDownMenu *)dropDownMenu rectReturnIndex:(NSInteger)index {
    
    return CGRectMake(0, 55, [UIScreen mainScreen].bounds.size.width, 150 + index*40);
}

- (void)sf_dropDownMenu:(SFDropDownMenu *)dropDownMenu didSelectIndex:(NSInteger)index {
    if (index == 0 || index == 2) {
        
        SFDDMBottomSingleOrMultiSelectView *view = [dropDownMenu dequeueReusableViewWithIdentifier:@"cell1" index:index];
        view.backgroundColor = [UIColor greenColor];
        
        view.arrowSpaceX_YLength = [UIScreen mainScreen].bounds.size.width/6*index + [UIScreen mainScreen].bounds.size.width/12;
    }else {
        
        SFDropDownMenuBottomMultistageView *view = [dropDownMenu dequeueReusableViewWithIdentifier:@"cell2" index:index];
        view.arrowSpaceX_YLength = [UIScreen mainScreen].bounds.size.width/6*index + [UIScreen mainScreen].bounds.size.width/12;
    }
    
    NSLog(@"点击了==%ld",index);
}

@end
