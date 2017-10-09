//
//  SFBaseNetworkTool.m
//  SF_ProjectFramework
//  网络请求的工具类
//  Created by mac on 2017/9/26.
//  Copyright © 2017年 石峰. All rights reserved.
//

#import "SFBaseNetworkTool.h"
#import <CommonCrypto/CommonDigest.h>

@implementation SFBaseNetworkTool

// 替换返回的对象中有为nil的字段
+ (id)replaceNilForObject:(id)object {

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

/**
 *  url加盐
    加密算法简介
 使用接口时，必须将所提交的参数和签名（也作为一个参数）提交给服务端。签名计算方法：
 假设要提交三个参数给服务端，三个参数分别为：nikename=xiaozhang, cellphone=13788996655, sex=0;
 第一步，将三个参数按参数名字典序排序，用”&”连接各个参数名和参数值，得到：“cellphone=13788996655&nikename=xiaozhang&sex=0”；
 第二步，md5加密所得多的字符串，得到：”0cfdde1a0a5d867af39440448c3c173a”；
 第三步，将加密后的字符串用“&”字符拼接上一个盐值（“zhwy#2017
 ”），得到：”0cfdde1a0a5d867af39440448c3c173a& htdc”；
 第四步，md5加密所得到的字符串，得到签名值：“857fcfabb124b5b5c068cb56496ac9f1”；
 第五步，将此值作为参数“sign”的值连同其他参数一起传递给服务端。


 */
+ (NSString *)encryptionUrl:(NSString *)urlStr parmaters:(NSDictionary *)parDic {
    
    if (!parDic)
    {
        //没有参数则不拼接Sign
        return urlStr;
    }
    
    //key排序
    NSArray *keySortedArr = [self sortKeyWithDictionary:parDic];
    
    NSMutableString *paramStr = [NSMutableString string];
    for (NSInteger i = 0; i< keySortedArr.count; i++)
    {
        //拼参数
        NSString *keyStr = keySortedArr[i];
        NSString *valueStr = parDic[keyStr];
        //  格式：/XX
        [paramStr appendFormat:@"/%@",valueStr];
    }
    
    //计算签名
    NSString *signStr = [self getSignWithParams:parDic keySortedArr:keySortedArr];
    //拼sign
    [paramStr appendFormat:@"/%@",signStr];
    //拼接url
    NSString *linkStr = [NSString stringWithFormat:@"%@%@",urlStr,paramStr];
    //UTF8编码
    //    NSString *encoded = [linkStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *encoded = [linkStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    return encoded;
}

/**
 对参数添加sign
 
 @param paramDic 原始参数Dic
 @return 添加过Sign的Dic
 */
+ (NSDictionary *)appendSignWithParam:(NSDictionary *)paramDic{
    
    NSArray *keySortedArr = [self sortKeyWithDictionary:paramDic];
    NSString *signStr = [self getSignWithParams:paramDic keySortedArr:keySortedArr];
    NSMutableDictionary *appendDic = [NSMutableDictionary dictionaryWithDictionary:paramDic];
    [appendDic setValue:signStr forKey:@"sign"];
    return appendDic;
}

/** 判断纯数字*/
+ (BOOL)isPureInt:(NSString *)str
{
    NSScanner* scan = [NSScanner scannerWithString:str];
    int val;
    return ([scan scanInt:&val] && [scan isAtEnd]);
}
#pragma mark ---私有方法--
/**
 根据字典中key字母排序
 
 @param paramDic 需要排序的Dic
 @return key的排序结果
 */
+ (NSArray *)sortKeyWithDictionary:(NSDictionary *)paramDic
{
    NSMutableArray *arr = [NSMutableArray array];
    
    for (NSString *key in paramDic)
    {
        //        NSString *lowerKey = [key lowercaseString];
        //        [arr addObject:lowerKey];
        [arr addObject:key];
    }
    
    //arr排序 升续
    [arr sortUsingComparator:^NSComparisonResult(NSString * _Nonnull obj1, NSString * _Nonnull obj2){
        
        return [obj1 compare:obj2];
    }];
    
    return arr;
}

/**
 计算 sign
 
 @param paramDic 参数dic
 @param keySortedArr 排序过后的key
 @return sign
 */
+ (NSString *)getSignWithParams:(NSDictionary *)paramDic keySortedArr:(NSArray *)keySortedArr
{
    NSMutableArray *keyValueArr = [NSMutableArray array];
    
    for (NSInteger i = 0; i < keySortedArr.count; i++)
    {
        NSString *key = keySortedArr[i];
        id value = [paramDic objectForKey:key];
        
        NSString *valueStr = nil;
        if ([value isKindOfClass:[NSArray class]])
        {
            //数组用,分割
            valueStr = [(NSArray *)value componentsJoinedByString:@","];
        }
        else if ([value isKindOfClass:[NSString class]])
        {
            valueStr = value;
        }
        else if ([value isKindOfClass:[NSNumber class]])
        {
            valueStr = [(NSNumber *)value stringValue];
        }
        else
        {
            return @"加密失败";
        }
        
        NSString *keyValueStr = [NSString stringWithFormat:@"%@=%@",key,valueStr];
        [keyValueArr addObject:keyValueStr];
    }
    
    //组合
    NSString *combStr = [keyValueArr componentsJoinedByString:@"&"];
    //md5
    NSString *md5EncryptedStr = [self md5Encryption:combStr];
    //加盐
    NSString *newStr = [NSString stringWithFormat:@"%@&%@",md5EncryptedStr,@"zhwy#2017"];
    //再md5
    return [self md5Encryption:newStr];
}

/** md5加密*/
+ (NSString *)md5Encryption:(NSString *)orignalStr
{
    const char *original_str = [orignalStr UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *encodeStr = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [encodeStr appendFormat:@"%02X", result[i]];
    }
    return [encodeStr lowercaseString];
}
@end
