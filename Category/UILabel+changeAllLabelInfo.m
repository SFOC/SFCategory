//
//  UILabel+changeAllLabelInfo.m
//  SF信号量使用
//
//  Created by fly on 2018/5/2.
//  Copyright © 2018年 fly(石峰). All rights reserved.
//

#import "UILabel+changeAllLabelInfo.h"
#import <objc/runtime.h>

static char name;

@implementation UILabel (changeAllLabelInfo)

+ (void)load {
    
    /*!
     方法交换，
     需求：将所有label上的文字大小或颜色设置为固定
     */
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ // 单利模式保证替换仅仅替换一次
        
        Class cls = [UILabel class];
        /// didMoveToSuperview 已经移动到父视图上
        SEL originalSelector = @selector(didMoveToSuperview);
        SEL swizzleSelector = @selector(myDidMoveToSuperview);
        
        /// 获取此类的实例方法
        Method originalMethod = class_getInstanceMethod(cls, originalSelector);
        Method swizzleMethod = class_getInstanceMethod(cls, swizzleSelector);
        
        /// class_addMethod 给类添加一个方法
        BOOL didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
        if (didAddMethod) { // 如果此方法已经添加了，则进行替换
            
            /*!
             swizzleSelector 要替换的方法
             method_getImplementation(originalMethod)原方法实现
             method_getTypeEncoding(originalMethod)原方法编码
             */
            class_replaceMethod(cls, swizzleSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else {
            
            /*!
             方法交换
             
             */
            method_exchangeImplementations(originalMethod, swizzleMethod);
        }
        
    });
}

/// 替换后的方法实现
- (void) myDidMoveToSuperview {
    [self myDidMoveToSuperview]; //注意 由于方法 myDidMoveToSuperview 与方法 didMoveToSuperview 进行了交换，所以这里调用的实际上为 didMoveToSuperview 方法
    if (self) {
        
        self.font = [UIFont systemFontOfSize:30];
        self.textColor = [UIColor redColor];
    }
}

#pragma mark ----set方法---
- (void)setName:(NSString *)name {
    
    objc_setAssociatedObject(self, &name, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


#pragma mark ---get方法---
- (NSString *)name {
    
    return objc_getAssociatedObject(self, &name);
}
@end
