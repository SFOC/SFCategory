//
//  SFBaseNetworkStatusCodeEnum.h
//  SF_ProjectFramework
//
//  Created by mac on 2017/9/29.
//  Copyright © 2017年 石峰. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, StatusCode) {
    
    ResponseStatusSuccess = 0,       // 请求成功
    ResponseStatusError = 7000,         // 处理数据失败
    ResponseStatusUnknowError = 7003, // 未知错误
    ResponseStatusUserError = 9002, // 用户不存在
    ResponseStatusDeviceError = 8001, // 设备不存在
    ResponseStatusSecretkeyError = 8002 // 密钥过期
    
};

@interface SFBaseNetworkStatusCodeEnum : NSObject

@end
