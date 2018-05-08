//
//  SFDropDownMenu.h
//  SFDropDownMenu
//  类似买房类软件的点击下拉选择菜单
//  Created by fly on 2018/5/6.
//  Copyright © 2018年 石峰(fly). All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark ---------------枚举-------------
/// 点击顶部item要弹出的view类型枚举
typedef enum : NSUInteger {
    
    /// 多表联动类型
    SF_DDMB_ShowViewLinkageType = 1,
    
    /// 垂直排列单选或多选view
    SF_DDMB_ShowViewSingleRowType,
} SF_DDMB_ShowViewType;

#pragma mark ----------------协议---------------
@class SFDropDownMenu;
/*! 一般的代理  */
@protocol SFDropDownMenuDelegate <NSObject>

@optional

/*!
 点击了顶部按钮的代理 index点击按的位置
 */
- (void) sf_dropDownMenu:(SFDropDownMenu *)dropDownMenu didSelectIndex:(NSInteger)index;



@end

/*! 数据信息代理 */
@protocol SFDropDownMenuDataSource <NSObject>

@required
/// 标题数组
- (NSMutableArray <NSString *> *) sf_dropDownMenu:(SFDropDownMenu *)dropDownMenu;

/*!
 每个item点击对应要弹出的view类型
 */
- (SF_DDMB_ShowViewType) sf_dropDownMenu:(SFDropDownMenu *)dropDownMenu index:(NSInteger)index;

@optional
/// 标题个数
- (NSInteger) titleNumInSf_dropDownMenu:(SFDropDownMenu *)dropDownMenu;



@end

#pragma mark --------------SFDropDownMenu-------------------
@interface SFDropDownMenu : UIView

/// 数据代理
@property (nonatomic, weak) id<SFDropDownMenuDataSource> dataSource;

/// 一般代理
@property (nonatomic, weak) id<SFDropDownMenuDelegate> delegate;

@end













