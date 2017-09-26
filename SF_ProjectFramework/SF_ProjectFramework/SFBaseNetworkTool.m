//
//  SFBaseNetworkTool.m
//  SF_ProjectFramework
//  网络请求的工具类
//  Created by mac on 2017/9/26.
//  Copyright © 2017年 石峰. All rights reserved.
//

#import "SFBaseNetworkTool.h"

@implementation SFBaseNetworkTool

// 替换返回的对象中有为nil的字段
- (id)replaceNilForObject:(id)object {
    
    if ([object isEqual:[NSNull class]] || [object isEqual:[NSNull null]]) {
        object = (NSString *)object;
        object = nil;
    } else if ([object isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *tempDict = [object mutableCopy];
        for (id key in object) {
            id value = [self replaceNilForObject:object[key]];
            [tempDict setObject:value forKey:key];
        }
        object = [tempDict copy];
    } else if ([object isKindOfClass:[NSArray class]]) {
        
        NSMutableArray *tempArray = [object mutableCopy];
        
        for (id value in object) {
            id newValue = [self replaceNilForObject:value];
            [tempArray replaceObjectAtIndex:[tempArray indexOfObject:value]
                                 withObject:newValue];
        }
        object = [tempArray copy];
    } else if ([object isKindOfClass:[NSString class]]) {
        if ([object isEqualToString:@" "]) {
            object = @"";
        }
    } else if ([object isKindOfClass:[NSNumber class]]) {
        
        NSString *d2Str = [NSString stringWithFormat:@"%lf", [object doubleValue]];
        NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:d2Str];
        object  = [num1 stringValue];
        
    }
    if (!object)
        object = @"";
    return object;
}
@end
