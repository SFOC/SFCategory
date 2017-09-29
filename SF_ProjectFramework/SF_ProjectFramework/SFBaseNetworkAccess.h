//
//  SFBaseNetworkAccess.h
//  SF_ProjectFramework
//
//  Created by mac on 2017/9/26.
//  Copyright © 2017年 石峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYCache.h"
#import "SFBaseNetworkBlock.h"
#import "SFBaseNetworkTool.h"
#import "SFBaseNetworkStatusCodeEnum.h"

@interface SFBaseNetworkAccess : NSObject

#pragma mark ---设置属性---
/*! 是否需要缓存（默认NO） */
-(SFBaseNetworkAccess * (^)(BOOL))useCache;

/*! 是否展示HUD (默认YES)*/
-(SFBaseNetworkAccess * (^)(BOOL))showHud;

/*! 超时时间 */
-(SFBaseNetworkAccess * (^)(NSUInteger))timeOut;

#pragma mark ---请求方法---
/** AFN Get 参数排序传值格式: /{value} */
- (void)sendGetRequestWithUrl:(NSString *)urlStr params:(NSDictionary *)parDic successBlock:(SF_RequestSuccess)success failureBlock:(SF_RequestFailure)failure;

/** AFN Post */
- (void)sendPostRequestWithUrl:(NSString *)urlStr params:(NSDictionary *)parDic successBlock:(SF_RequestSuccess)success failureBlock:(SF_RequestFailure)failure;

/** AFN Put */
- (void)sendPutRequestWithUrl:(NSString *)urlStr params:(NSDictionary *)parDic successBlock:(SF_RequestSuccess)success failureBlock:(SF_RequestFailure)failure;

/** AFN Delete */
- (void)sendDeleteRequestWithUrl:(NSString *)urlStr params:(NSDictionary *)parDic successBlock:(SF_RequestSuccess)success failureBlock:(SF_RequestFailure)failure;

/** AFN patch */
- (void)sendPatchRequestWithUrl:(NSString *)urlStr params:(NSDictionary *)parDic successBlock:(SF_RequestSuccess)success failureBlock:(SF_RequestFailure)failure;

#pragma mark ---初始化---
/*! 初始化网络请求基类 */
+ (SFBaseNetworkAccess *)sharedManager;
@end
