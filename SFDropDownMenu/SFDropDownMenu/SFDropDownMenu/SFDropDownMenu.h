//
//  SFDropDownMenu.h
//  SFDropDownMenu
//  类似买房类软件的点击下拉选择菜单
//  Created by fly on 2018/5/6.
//  Copyright © 2018年 石峰(fly). All rights reserved.
//

#import <UIKit/UIKit.h>

@class SFDropDownMenu;
/*! 一般的代理  */
@protocol SFDropDownMenuDelegate <NSObject>

@optional

/// 点击了顶部按钮的代理 index点击按的位置
- (void) sf_dropDownMenu:(SFDropDownMenu *)dropDownMenu didSelectIndex:(NSInteger)index;

/// 每个item点击对应要弹出的view类型
- () 

@end

/*! 数据信息代理 */
@protocol SFDropDownMenuDataSource <NSObject>

@required
/// 标题数组
- (NSMutableArray <NSString *> *) sf_dropDownMenu:(SFDropDownMenu *)dropDownMenu;

@optional
/// 标题个数
- (NSInteger) titleNumInSf_dropDownMenu:(SFDropDownMenu *)dropDownMenu;



@end

#pragma mark ---SFDropDownMenu---

@interface SFDropDownMenu : UIView

/// 数据代理
@property (nonatomic, weak) id<SFDropDownMenuDataSource> dataSource;

/// 一般代理
@property (nonatomic, weak) id<SFDropDownMenuDelegate> delegate;

@end













