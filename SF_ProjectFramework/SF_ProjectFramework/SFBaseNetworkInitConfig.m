//
//  SFBaseNetworkInitConfig.m
//  SF_ProjectFramework
//  网路请求初始化配置
//  Created by mac on 2017/9/26.
//  Copyright © 2017年 石峰. All rights reserved.
//

#import "SFBaseNetworkInitConfig.h"

@implementation SFBaseNetworkInitConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.afManager = [self sessionManager];
    }
    return self;
}

#pragma mark ---私有方法---
- (AFHTTPSessionManager *)sessionManager{
    
    AFHTTPSessionManager *afManager = [AFHTTPSessionManager manager];
    //        afManager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    afManager.responseSerializer.acceptableContentTypes =
    [NSSet setWithObjects:@"application/json", @"text/json", @"text/txt",
     @"text/html",@"text/plain",nil];
    return afManager;
}
@end
