//
//  SFBaseNetworkBlock.m
//  SF_ProjectFramework
//  网络请求成功和失败的回调
//  Created by mac on 2017/9/26.
//  Copyright © 2017年 石峰. All rights reserved.
//

#import "SFBaseNetworkBlock.h"
#import "SFBaseNetworkTool.h"
#import "SFBaseNetworkInitConfig.h"

@interface SFBaseNetworkBlock ()

@end

@implementation SFBaseNetworkBlock

// 请求成功的处理
+ (void)dealSuccessResponse:(SFBaseHttpModel *)model requestSuccess:(SF_RequestSuccess)successBlock {
    
    if ([model.responseObject isKindOfClass:[NSDictionary class]]) { // 请求成功后的返回值是字典
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            id dic;
            NSInteger statusCode = model.httpStatusCodeStr.integerValue;
            dic = [model.responseObject mutableCopy];
            dic = [[SFBaseNetworkTool new] replaceNilForObject:dic];
            
            
        });
    }
}

// 请求失败处理
+ (void)dealFailureResponse:(SFBaseHttpModel *)model requestFailure:(SF_RequestFailure)failureBlock {
    
}
@end
