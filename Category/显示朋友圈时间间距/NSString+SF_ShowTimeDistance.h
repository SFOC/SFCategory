//
//  NSString+SF_ShowTimeDistance.h
//  IntellectualProperty
//
//  Created by mac on 2017/9/11.
//  Copyright © 2017年 mengotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SF_ShowTimeDistance)

/*!
 计算给定时间与当前时间的距离  SF_添加
 beTime 为传入的时间戳
 */
+ (NSString *)sf_distanceTimeWithBeforeTime:(NSString *)beTimeStamp;


/*! 获取当前时间的时间戳 SF添加 */
+ (NSString*)sf_getCurrentTimestamp;
@end
