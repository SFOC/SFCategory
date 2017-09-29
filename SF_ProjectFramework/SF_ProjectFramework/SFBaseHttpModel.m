//
//  SFBaseHttpModel.m
//  SF_ProjectFramework
//  请求model
//  Created by mac on 2017/9/26.
//  Copyright © 2017年 石峰. All rights reserved.
//

#import "SFBaseHttpModel.h"

@implementation SFBaseHttpModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self configInfo];
    }
    return self;
}

/*! 配置信息 */
- (void)configInfo {
    
    self.needPrintResponse = NO;
}

/*! 设置任务的同时设置状态码 */
- (void)setTask:(NSURLSessionDataTask *)task {
    
    _task = task;
    
    if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) { // 响应式HTTP响应
        
        // HTTP响应
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        _httpStatusCodeStr = [NSString stringWithFormat:@"%zd",response.statusCode];
    }else {
        
        _httpStatusCodeStr = @"未知错误码(非NSHTTPURLResponse类型)";
    }
}

// 打印输出（dubug模式下有打印）
- (NSString *)debugDescription {
    
    NSString *type;
    switch (self.requestType) {
        case MethodTypeGet:
            type = @"Get";
            break;
        case MethodTypePost:
            type = @"Post";
            break;
        case MethodTypePut:
            type = @"Put";
            break;
        case MethodTypePatch:
            type = @"Path";
            break;
        case MethodTypeDelete:
            type = @"Delete";
            break;
            
        default:
            type = @"Unknow";
            break;
    }
    
    return [NSString stringWithFormat:@"\n\n*****************************************************\n*****************************************************\n\n请求方式记录：%@\n请求URL记录：%@\n请求参数记录：%@\n返回值记录：%@\n\n*****************************************************\n*****************************************************\n\n",type,self.httpUrlStr,self.requestParamDic,self.responseObject];
}
@end
