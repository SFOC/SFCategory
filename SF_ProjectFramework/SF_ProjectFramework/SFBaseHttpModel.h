//
//  SFBaseHttpModel.h
//  SF_ProjectFramework
//
//  Created by mac on 2017/9/26.
//  Copyright © 2017年 石峰. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    
    MethodTypeUnknow,
    MethodTypeGet,
    MethodTypePost,
    MethodTypePut,
    MethodTypePatch,
    MethodTypeDelete,
    
} SFRequestMethodType; // 请求的类型

@interface SFBaseHttpModel : NSObject


/** 请求Url*/
@property (copy, nonatomic) NSString *httpUrlStr;

/** 请求类型*/
@property (assign, nonatomic)  SFRequestMethodType requestType;

/** 请求参数*/
@property (strong, nonatomic) NSDictionary *requestParamDic;

/** 返回值*/
@property (strong, nonatomic) id responseObject;

/** 错误返回值*/
@property (strong, nonatomic) NSError *responseErr;

/** 需要打印返回信息 (默认为NO)*/
@property (assign, nonatomic) BOOL needPrintResponse;

/** 请求任务*/
@property (strong, nonatomic) NSURLSessionDataTask *task;

/** 请求响应码*/
@property (copy, nonatomic, readonly) NSString *httpStatusCodeStr;

@end
