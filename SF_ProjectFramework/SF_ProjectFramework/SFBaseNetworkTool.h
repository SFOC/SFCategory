//
//  SFBaseNetworkTool.h
//  SF_ProjectFramework
//
//  Created by mac on 2017/9/26.
//  Copyright © 2017年 石峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFBaseNetworkTool : NSObject

/**
 *  遍历替换返回的数据中为空的为@""
 *
 *  @param object 要被替换的对象
 *
 *  @return 返回新的对象
 */
- (id)replaceNilForObject:(id)object;

@end
