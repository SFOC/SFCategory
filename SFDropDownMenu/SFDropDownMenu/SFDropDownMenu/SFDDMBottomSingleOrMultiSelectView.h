//
//  SFDDMBottomSingleOrMultiSelectView.h
//  SFDropDownMenu
//  单选或多选view
//  Created by fly on 2018/5/6.
//  Copyright © 2018年 石峰(fly). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFArrowView.h"

/// 单选或多选type
typedef enum : NSUInteger {
    /// 单选
    SF_DDMB_SingleSelectView,
    
    /// 多选
    SF_DDMB_MultiSelectView,
} SF_DDMB_SelectType;

@interface SFDDMBottomSingleOrMultiSelectView : SFArrowView

/*! 单选或多选 */
@property (nonatomic, assign) SF_DDMB_SelectType selectType;

@end
