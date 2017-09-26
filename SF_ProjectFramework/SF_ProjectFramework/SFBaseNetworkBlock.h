//
//  SFBaseNetworkBlock.h
//  SF_ProjectFramework
//
//  Created by mac on 2017/9/26.
//  Copyright © 2017年 石峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFBaseHttpModel.h"

/**
 *  成功的回调
 *
 *  @param responseObject 返回的数据
 *  @param stateCode      返回的状态码
 */
typedef void (^SF_RequestSuccess)(id responseObject, NSInteger stateCode);

/**
 *  失败的回调
 *
 *  @param error 返回失败的信息
 */
typedef void (^SF_RequestFailure)(NSError *error);

@interface SFBaseNetworkBlock : NSObject

/**
 *  请求成功的处理
 *
 *  @param model        httpModel
 *  @param successBlock 成功的回调
 */
+ (void)dealSuccessResponse:(SFBaseHttpModel *)model requestSuccess:(SF_RequestSuccess)successBlock;

/**
 *  请求失败的处理
 *
 *  @param model        httpModel
 *  @param failureBlock 失败的回调
 */
+ (void)dealFailureResponse:(SFBaseHttpModel *)model requestFailure:(SF_RequestFailure)failureBlock;

@end
