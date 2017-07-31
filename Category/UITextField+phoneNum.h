//
//  UITextField+phoneNum.h
//  phoneNumFieldDemo
//
//  Created by mac on 17/3/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (phoneNum)
@property (nonatomic,assign) BOOL phoneMode;
@property (nonatomic,copy) NSString *phoneNumber;
@end
