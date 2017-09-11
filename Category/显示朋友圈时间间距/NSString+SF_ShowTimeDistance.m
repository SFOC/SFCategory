//
//  NSString+SF_ShowTimeDistance.m
//  IntellectualProperty
//
//  Created by mac on 2017/9/11.
//  Copyright © 2017年 mengotech. All rights reserved.
//

#import "NSString+SF_ShowTimeDistance.h"

@implementation NSString (SF_ShowTimeDistance)

/*! 获取当前时间的时间戳 SF添加 */
+ (NSString*)sf_getCurrentTimestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}

/*!
 计算给定时间与当前时间的距离  SF_添加
 beTime 为传入的时间戳
 */
+ (NSString *)sf_distanceTimeWithBeforeTime:(NSString *)beTimeStamp {
    
    
    
    // 获取当前的时间戳
    NSString *currentTimeStamp = [self sf_getCurrentTimestamp];
    if (currentTimeStamp.length >= 13) {
        
        currentTimeStamp = [NSString stringWithFormat:@"%.f",currentTimeStamp.doubleValue / 1000];
    }
    
    if (beTimeStamp.length >= 13) {
        
        beTimeStamp = [NSString stringWithFormat:@"%.f",beTimeStamp.doubleValue / 1000];
    }
    Log(@"当前时间的时间戳===%@",beTimeStamp);
    NSDate * beDate = [NSDate dateWithTimeIntervalSince1970:beTimeStamp.doubleValue];
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"HH:mm"];
    NSString * timeStr = [df stringFromDate:beDate];
    [df setDateFormat:@"dd"];
    
    NSString * nowDay = [df stringFromDate:[NSDate date]];
    NSString * lastDay = [df stringFromDate:beDate];
    
    CGFloat distanceTimeSeconds = currentTimeStamp.doubleValue -beTimeStamp.doubleValue;
    NSString *distanceStr = @"";
    if (distanceTimeSeconds < 60) { // 小于一分钟
        
        distanceStr = @"刚刚";
    }else if (distanceTimeSeconds < 60*60) { // 时间小于一个小时
        
        distanceStr = [NSString stringWithFormat:@"%ld分钟前",(long)distanceTimeSeconds/60];
    }else if(distanceTimeSeconds <= 24*60*60*2 + 10){//时间小于二天 (10代表的是服务器返回的时间和手机时间的误差)
        
        if ([nowDay isEqualToString:lastDay]) {
            
            distanceStr = [NSString stringWithFormat:@"今天 %@",timeStr];
        }else {
            
            distanceStr = [NSString stringWithFormat:@"昨天 %@",timeStr];
        }
        
    }else if(distanceTimeSeconds < 24*60*60*365){
        
        [df setDateFormat:@"MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }else{
        [df setDateFormat:@"yyyy-MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }
    return distanceStr;
}


@end
