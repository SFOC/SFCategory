//
//  UIScrollView+CustomAnimationRefresh.h
//
//  设置自定义刷新动画
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 Fly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface UIScrollView (CustomAnimationRefresh)
@property (nonatomic, strong) MJRefreshGifHeader *gifHeaderSetting;
@property (nonatomic, strong) MJRefreshAutoGifFooter *gifFooterSetting;
@end
