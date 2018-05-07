//
//  UILabel+changeAllLabelInfo.h
//  SF信号量使用
//
//  Created by fly on 2018/5/2.
//  Copyright © 2018年 fly(石峰). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (changeAllLabelInfo)


/// 动态生成getter和setter方法
@property (nonatomic, copy) NSString *name;
@end
