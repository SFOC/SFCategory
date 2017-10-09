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
+ (id)replaceNilForObject:(id)object;


/**
 *  url加盐
 *
 *  @param urlStr url
 *  @param parDic 参数
 *
 *  @return 加盐后的字符串
 */
+ (NSString *)encryptionUrl:(NSString *)urlStr parmaters:(NSDictionary *)parDic;


/**
 对参数添加sign
 
 @param paramDic 原始参数Dic
 @return 添加过Sign的Dic
 */
+ (NSDictionary *)appendSignWithParam:(NSDictionary *)paramDic;

/** 判断纯数字（整数） */
+ (BOOL)isPureInt:(NSString *)str;

@end
