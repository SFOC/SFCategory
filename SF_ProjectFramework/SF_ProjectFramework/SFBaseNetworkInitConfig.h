//
//  SFBaseNetworkInitConfig.h
//  SF_ProjectFramework
//
//  Created by mac on 2017/9/26.
//  Copyright © 2017年 石峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYCache.h"

@interface SFBaseNetworkInitConfig : NSObject

/*! 超时时间 */
@property (nonatomic, assign) NSInteger timeOut;

/*! 缓存 */
@property (nonatomic, strong) YYCache   *cache;

/*! 是否需要缓存（默认NO） */
@property (nonatomic, assign) BOOL useCache;

/*! 是否展示HUD (默认YES)*/
@property (nonatomic, assign) BOOL showHud;
@end
