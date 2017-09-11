//
//  NSObject+SF_ModelPropertyLog.m
//  test
//  打印模型的时候会打印模型的属性
//  Created by fly on 2017/7/6.
//  Copyright © 2017年 flyfly. All rights reserved.
//

#import "NSObject+SF_ModelPropertyLog.h"
#import <objc/runtime.h>

@implementation NSObject (SF_ModelPropertyLog)
-(NSString *)description {

    NSArray *propertyNames = [self allPropertyNames];
    NSMutableString *strLog = [NSMutableString string];
    [strLog appendFormat:@"<%@ %p>",[self class],self];
    
    for (int i = 0; i < propertyNames.count; i++) {
        if (propertyNames.count - 1 == i) {
            [strLog appendFormat:@"%@ = %@",propertyNames[i],[self valueForKey:propertyNames[i]]];
        }else {
            [strLog appendFormat:@"%@ = %@,",propertyNames[i],[self valueForKey:propertyNames[i]]];
        }
    }
    return strLog;
}

///通过运行时获取当前对象的所有属性的名称，以数组的形式返回
- (NSArray *) allPropertyNames{
    ///存储所有的属性名称
    NSMutableArray *allNames = [[NSMutableArray alloc] init];
    
    ///存储属性的个数
    unsigned int propertyCount = 0;
    
    ///通过运行时获取当前类的属性
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
    
    //把属性放到数组中
    for (int i = 0; i < propertyCount; i ++) {
        ///取出第一个属性
        objc_property_t property = propertys[i];
        
        const char * propertyName = property_getName(property);
        
        [allNames addObject:[NSString stringWithUTF8String:propertyName]];
    }
    
    return allNames;
}

@end
