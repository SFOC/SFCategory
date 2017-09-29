//
//  SFBaseNetworkAccess.m
//  SF_ProjectFramework
//  网络请求基础类
//  Created by mac on 2017/9/26.
//  Copyright © 2017年 石峰. All rights reserved.
//

#import "SFBaseNetworkAccess.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "SFBaseNetworkInitConfig.h"

NSString * const PLHttpCache = @"PLHttpCache";
@interface SFBaseNetworkAccess () {
    
    NSInteger _timeOut; // 超时时长
    BOOL _useCache; // 是否缓存
    BOOL _showHud; // 是否展示hud
    YYCache * _cache; // YYCache缓存
}
/*! afn网络配置管理 */
@property (nonatomic, strong) SFBaseNetworkInitConfig *baseNetworkInitConfig;

/*! 请求model */
@property (nonatomic, strong) SFBaseHttpModel *model;
@end

@implementation SFBaseNetworkAccess

#pragma mark ---外部调用方法---
/** AFN Get 参数排序传值格式: /{value} */
- (void)sendGetRequestWithUrl:(NSString *)urlStr params:(NSDictionary *)parDic successBlock:(SF_RequestSuccess)success failureBlock:(SF_RequestFailure)failure {
    
    // 加盐
    self.model.httpUrlStr = [SFBaseNetworkTool encryptionUrl:urlStr parmaters:parDic];
    self.model.requestParamDic = parDic;
    self.model.requestType = MethodTypeGet;
    self.model.cache = _cache;
    self.model.cacheData = [self.model.cache objectForKey:self.model.httpUrlStr];
    [self isShowHud];
    
    
    if (self.model.cacheData && self.useCache) { // 如果这个链接有缓存数据（同时需要缓存），则直接返回数据，再进行请求
        
        if (success) {
            
            success(self.model.cacheData, ResponseStatusSuccess);
        }
    }
    [self.baseNetworkInitConfig.afManager GET:self.model.httpUrlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.model.responseObject = responseObject; // 返回值
        self.model.task = task; // task里面包括状态码
        [SFBaseNetworkBlock dealSuccessResponse:self.model requestSuccess:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        self.model.responseErr = error;
        self.model.task = task; // task里面包括状态码
        [SFBaseNetworkBlock dealFailureResponse:self.model requestFailure:failure];
    }];
}

/** AFN Post */
- (void)sendPostRequestWithUrl:(NSString *)urlStr params:(NSDictionary *)parDic successBlock:(SF_RequestSuccess)success failureBlock:(SF_RequestFailure)failure {
    
    // 加盐
    self.model.httpUrlStr = [SFBaseNetworkTool encryptionUrl:urlStr parmaters:parDic];
    self.model.requestParamDic = parDic;
    self.model.requestType = MethodTypeGet;
    self.model.cache = _cache;
    self.model.cacheData = [self.model.cache objectForKey:self.model.httpUrlStr];
    [self isShowHud];
    
    
    if (self.model.cacheData && self.useCache) { // 如果这个链接有缓存数据（同时需要缓存），则直接返回数据，再进行请求
        
        if (success) {
            
            success(self.model.cacheData, ResponseStatusSuccess);
        }
    }
    
    [self.baseNetworkInitConfig.afManager POST:self.model.httpUrlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.model.responseObject = responseObject; // 返回值
        self.model.task = task; // task里面包括状态码
        [SFBaseNetworkBlock dealSuccessResponse:self.model requestSuccess:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        self.model.responseErr = error;
        self.model.task = task; // task里面包括状态码
        [SFBaseNetworkBlock dealFailureResponse:self.model requestFailure:failure];
    }];
}

/** AFN Put */
- (void)sendPutRequestWithUrl:(NSString *)urlStr params:(NSDictionary *)parDic successBlock:(SF_RequestSuccess)success failureBlock:(SF_RequestFailure)failure {
    
}

/** AFN Delete */
- (void)sendDeleteRequestWithUrl:(NSString *)urlStr params:(NSDictionary *)parDic successBlock:(SF_RequestSuccess)success failureBlock:(SF_RequestFailure)failure {
    
}

/** AFN patch */
- (void)sendPatchRequestWithUrl:(NSString *)urlStr params:(NSDictionary *)parDic successBlock:(SF_RequestSuccess)success failureBlock:(SF_RequestFailure)failure {
    
}

#pragma mark ---初始化相关---
/*! 初始化网络请求基类 */
+ (SFBaseNetworkAccess *)sharedManager {
    return [[self alloc]init];
}

/*! 初始化 */ 
- (instancetype)init
{
    _timeOut = 20;
    _cache = [[YYCache alloc] initWithName:PLHttpCache]; // 缓存的类型
    _cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES; // 当内存收到内存警告，将删除所有缓存
    _cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES; // 进入后台，缓存将移除所有对象
    _useCache = NO; // 默认不需要缓存
    _showHud = YES; // 默认需要HUD
    
    // 设置网络超时
    self.baseNetworkInitConfig.afManager.requestSerializer.timeoutInterval = _timeOut;
    
    // 是否缓存和展示hud
    self.model.useCache = _useCache;
    self.model.showHud = _showHud;
    return self;
}

#pragma mark ---block---
-(SFBaseNetworkAccess * (^)(BOOL))useCache{
    return ^id(BOOL allow){
        _useCache = allow;
        return self;
    };
}

-(SFBaseNetworkAccess * (^)(BOOL))showHud{
    return ^id(BOOL show){
        _showHud = show;
        return self;
    };
}

-(SFBaseNetworkAccess * (^)(NSUInteger))timeOut{
    return ^id(NSUInteger time){
        _timeOut = time;
        return self;
    };
}

#pragma mark ---懒加载---
- (SFBaseNetworkInitConfig *)baseNetworkInitConfig {
    
    if (!_baseNetworkInitConfig) {
        
        _baseNetworkInitConfig = [SFBaseNetworkInitConfig new];
    }
    return _baseNetworkInitConfig;
}

- (SFBaseHttpModel *)model {
    
    if (!_model) {
        _model = [SFBaseHttpModel new];
    }
    return _model;
}

#pragma mark ---私有方法--
/*! 是否展示hud */
- (void)isShowHud {
    if (self.model.showHud) {
        
        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    }
}
@end
