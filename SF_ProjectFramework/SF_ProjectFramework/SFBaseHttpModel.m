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

- (void)setTask:(NSURLSessionDataTask *)task {
    
    _task = task;
    
    if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) { // 响应式HTTP响应
        
        
    }
}
@end
