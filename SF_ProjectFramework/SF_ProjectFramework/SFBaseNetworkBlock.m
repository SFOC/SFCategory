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
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window animated:YES];
            });
            
            id dic; // 要返回的数据
            NSInteger statusCode = 9876173748482; // 服务器返回的状态码，乱写的
//            BOOL isInt =[SFBaseNetworkTool isPureInt:model.httpStatusCodeStr];
//            // 如果返回的task的相应不是NSHTTPURLResponse类，则状态如下(乱写的)
//            NSInteger statusCode = isInt?model.httpStatusCodeStr.integerValue:9876173748482;
            dic = [model.responseObject mutableCopy];
            // 替换返回的对象中有nil，<null>的空字符为@""
            dic = [SFBaseNetworkTool replaceNilForObject:dic];
            
            // 由于每次请求的_requestId不一样，所以需要过滤
            if ([dic isKindOfClass:[NSDictionary class]]) {
                
                NSMutableDictionary *tempDic = [(NSMutableDictionary *)dic mutableCopy];
                if ([tempDic.allKeys containsObject:@"_requestId"]) {
                    
                    [tempDic removeObjectForKey:@"_requestId"];
                    dic = tempDic;
                }
                
                if ([tempDic.allKeys containsObject:@"error"]) {
                    
                    statusCode =  [tempDic[@"error"] integerValue];
                    model.serviceStatusCodeStr = tempDic[@"error"];
                }
            }
            
            // 如果本次返回的数据和上次缓存的数据一样，则不用返回
            if (model.useCache && [dic isEqual:[model.cache objectForKey:model.httpUrlStr]]) {
                
                return ;
            }
            NSLog(@"请求到的数据和缓存数据做对比======%zd",[dic isEqual:[model.cache objectForKey:model.httpUrlStr]]);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // block返回
                if (successBlock) {
                    
                    successBlock(dic, statusCode);
                }
            });
            
            
            // 如果需要缓存，同时状态吗成功则进行缓存
            if (model.useCache && statusCode == ResponseStatusSuccess) {
                
                [model.cache setObject:dic forKey:model.httpUrlStr];
            }
        });
    }
}

// 请求失败处理
+ (void)dealFailureResponse:(SFBaseHttpModel *)model requestFailure:(SF_RequestFailure)failureBlock {
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window animated:YES];
    if (failureBlock) {
        
        failureBlock(model.responseErr);
    }
    
    if (-1001 == model.responseErr.code) {
#ifdef DEBUG
        NSLog(@"--------------------请求超时------------------");
#endif
    }
}
@end
