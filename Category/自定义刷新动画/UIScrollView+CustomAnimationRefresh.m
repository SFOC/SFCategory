//
//  UIScrollView+CustomAnimationRefresh.m
//  
//  设置自定义刷新动画
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 Fly. All rights reserved.
//

#import "UIScrollView+CustomAnimationRefresh.h"
#import <objc/runtime.h>

//定义常量 必须是C语言字符串
static char *gifHeaderRefreshKey = "gifHeaderRefreshKey";
static char *gifFooterRefreshKey = "gifFooterRefreshKey";

@implementation UIScrollView (CustomAnimationRefresh)


#pragma mark ---set方法---

- (void)setGifHeaderSetting:(MJRefreshGifHeader *)gifHeaderSetting {
    gifHeaderSetting.stateLabel.hidden = YES;
    gifHeaderSetting.lastUpdatedTimeLabel.hidden = YES;
    [gifHeaderSetting setImages:@[[self getImagesArr][0]] forState:MJRefreshStateIdle];
    [gifHeaderSetting setImages:[self getImagesArr] forState:MJRefreshStateRefreshing];
    objc_setAssociatedObject(self, gifHeaderRefreshKey, gifHeaderSetting, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (void)setGifFooterSetting:(MJRefreshAutoGifFooter *)gifFooterSetting {
    gifFooterSetting.stateLabel.hidden = YES;
    gifFooterSetting.refreshingTitleHidden = YES;
    [gifFooterSetting setImages:@[[self getImagesArr][0]] forState:MJRefreshStateIdle];
    [gifFooterSetting setImages:[self getImagesArr] forState:MJRefreshStateRefreshing];
    objc_setAssociatedObject(self, gifFooterRefreshKey, gifFooterSetting, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark ---get方法---
- (MJRefreshGifHeader *)gifHeader {
    return objc_getAssociatedObject(self, gifHeaderRefreshKey);
}

- (MJRefreshAutoGifFooter *)gifFooter {
    return objc_getAssociatedObject(self, gifFooterRefreshKey);
}


#pragma mark ---私有方法---
- (NSMutableArray *)getImagesArr {
    NSMutableArray *headerImages = [NSMutableArray array];
    for (int i = 0; i <= 12; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_%d",i]];
        [headerImages addObject:image];
        NSLog(@"%@",image);
    }
    
    return headerImages;
}

@end
