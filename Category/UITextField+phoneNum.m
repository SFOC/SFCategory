//
//  UITextField+phoneNum.m
//  phoneNumFieldDemo
//
//  Created by mac on 17/3/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UITextField+phoneNum.h"
#import <objc/runtime.h>
#import <CoreText/CoreText.h>

static const NSString * phoneNumMode = @"phoneNumMode";
static const NSString * phoneNum = @"phoneNumber";
@implementation UITextField (phoneNum)

NSUInteger _lastLength = 0;
/* 初始赋值的时候建议用 phoneNumber */
-(void)commonInit{
    
     __block NSUInteger _lastLength = 0;
    if(self.phoneMode){
        self.keyboardType = UIKeyboardTypeNumberPad;
        [self addTarget:self action:@selector(changeText) forControlEvents:UIControlEventEditingChanged];
    }
    else{
        _lastLength = 0;
        self.phoneNumber = @"";
    }
}

-(void)changeText{

    if(!self.phoneMode) return;
        if(_lastLength < self.text.length){
            if(self.text.length ==4 || self.text.length ==9){
                NSString * lastCharacter = @" ";
                lastCharacter=[lastCharacter stringByAppendingString: [self.text substringFromIndex:self.text.length-1]];
                self.text = [[self.text substringToIndex:self.text.length-1]stringByAppendingString:lastCharacter];
            }
        }
        if(self.text.length == 14){
            self.text = [self.text substringToIndex:self.text.length-1];
        }
        _lastLength = self.text.length;
        self.phoneNumber = [self.text stringByReplacingOccurrencesOfString:@" " withString:@""];
}

-(void)setPhoneMode:(BOOL)phoneMode{
    
    objc_setAssociatedObject(self, &phoneNumMode, @(phoneMode), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self commonInit];
}

-(BOOL)phoneMode{
    return [objc_getAssociatedObject(self, &phoneNumMode) boolValue];
}

-(void)setPhoneNumber:(NSString *)phoneNumber{
    /* 初始直接赋值 */
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(!self.text.length && phoneNumber.length == 11){
        NSMutableString * string =[[NSMutableString alloc]initWithString:phoneNumber];
        [string insertString:@" " atIndex:3];
        [string insertString:@" " atIndex:8];
        self.text = string;
    }
    objc_setAssociatedObject(self, &phoneNum, phoneNumber, OBJC_ASSOCIATION_COPY_NONATOMIC);

}

-(NSString*)phoneNumber{
    if(!objc_getAssociatedObject(self, &phoneNum) && self.text.length){
        return [self.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    return objc_getAssociatedObject(self, &phoneNum);
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
