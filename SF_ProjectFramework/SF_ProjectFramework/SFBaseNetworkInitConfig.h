//
//  SFBaseNetworkInitConfig.h
//  SF_ProjectFramework
//
//  Created by mac on 2017/9/26.
//  Copyright © 2017年 石峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface SFBaseNetworkInitConfig : NSObject
/*! afn的sessionManager */
@property (nonatomic, strong) AFHTTPSessionManager *afManager;
@end
