//
//  SF_BaseTextView.m
//  YN_PassWordView
//  密码框
//  Created by fly（石峰） on 2018/6/13.
//  Copyright © 2018年 ijianghu. All rights reserved.
//

#import "SF_BaseTextView.h"

@interface SF_BaseTextView ()<UITextViewDelegate>

/// 占位字符label
@property (nonatomic, strong) UILabel *placeholderLabel;

@end

// RGBA_十六进制颜色处理
#define ColorFromRGBAHEX(rgbaHex) [UIColor colorWithRed:((float)((rgbaHex & 0xFF0000) >> 16))/255.0 green:((float)((rgbaHex & 0xFF00) >> 8))/255.0 blue:((float)(rgbaHex & 0xFF))/255.0 alpha:1.0]
@implementation SF_BaseTextView

#pragma mark ---初始化---

/// 直接init的时候先调用initWithFrame在调用init
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initializeSetting];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializeSetting];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    [self initializeSetting];
}

#pragma mark ---初始化设置---
/// 初始化设置
- (void) initializeSetting {
    
    self.limitWordsNum = -1;
    self.isRoundCorner = YES;
    self.paddingEdgeInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.borderColor = ColorFromRGBAHEX(0xf2f2f2);
    self.borderWidth = 1;
    self.roundCornerValue = 5;
    self.fontSize = 15;
    /// 设置光标颜色
    self.cursorColor = [UIColor blueColor];
    
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    self.textColor = ColorFromRGBAHEX(0x333333);
    self.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChangeAction:) name:UITextViewTextDidChangeNotification object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidEndEditorAction:) name:UITextViewTextDidEndEditingNotification object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewBeginEditorAction:) name:UITextViewTextDidBeginEditingNotification object:self];
    
    [self addObserver:self forKeyPath:@"font" options:NSKeyValueObservingOptionNew |
     NSKeyValueObservingOptionOld context:nil];
    [self addObserver:self forKeyPath:@"textContainerInset" options:NSKeyValueObservingOptionNew |
     NSKeyValueObservingOptionOld context:nil];
   
    [self addSubview:self.placeholderLabel];
}

#pragma mark ---观察者方法---
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"font"]) {
        
        UITextView *textView = (UITextView *)object;
        self.placeholderLabel.font = textView.font;
        
        self.placeholderLabel.frame = CGRectMake(self.paddingEdgeInset.left, self.paddingEdgeInset.top, self.frame.size.width - self.paddingEdgeInset.left - self.paddingEdgeInset.right, self.placeholderLabel.font.lineHeight);
    }else if ([keyPath isEqualToString:@"textContainerInset"]) {
        
        UITextView *textView = (UITextView *)object;
        UIEdgeInsets edgeInset = textView.textContainerInset;
        self.placeholderLabel.frame = CGRectMake(edgeInset.left, edgeInset.top, self.frame.size.width - edgeInset.left - edgeInset.right, self.placeholderLabel.font.lineHeight);
    }
}

#pragma mark ---set方法---
- (void)setPaddingEdgeInset:(UIEdgeInsets)paddingEdgeInset {
    _paddingEdgeInset = paddingEdgeInset;
    
    self.textContainerInset = paddingEdgeInset;
    self.textContainer.lineFragmentPadding = 0;
}

- (void)setIsRoundCorner:(BOOL)isRoundCorner {
    _isRoundCorner = isRoundCorner;
    
    if (isRoundCorner) {
        
        self.layer.cornerRadius = 0;
    }else {
        
        self.layer.cornerRadius = self.roundCornerValue;
    }
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    
     self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}

- (void)setRoundCornerValue:(CGFloat)roundCornerValue {
    _roundCornerValue = roundCornerValue;
    
    self.layer.cornerRadius = roundCornerValue;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    
    self.placeholderLabel.text = placeholder;
}

- (void)setFontSize:(CGFloat)fontSize {
    
    _fontSize = fontSize;
    
    self.font = [UIFont systemFontOfSize:fontSize];
}

- (void)setCursorColor:(UIColor *)cursorColor {
    _cursorColor = cursorColor;
    
    self.tintColor = cursorColor;
}

#pragma mark ---懒加载---
- (UILabel *)placeholderLabel {
    
    if (!_placeholderLabel) {
        
        _placeholderLabel = [UILabel new];
        _placeholderLabel.font = [UIFont systemFontOfSize:self.fontSize];
        _placeholderLabel.frame = CGRectMake(self.paddingEdgeInset.left, self.paddingEdgeInset.top, self.frame.size.width - self.paddingEdgeInset.left - self.paddingEdgeInset.right, _placeholderLabel.font.lineHeight);
        
        _placeholderLabel.backgroundColor = [UIColor clearColor];
        _placeholderLabel.textColor = ColorFromRGBAHEX(0xbbbbbb);
    }
    
    return _placeholderLabel;
}

#pragma mark ---通知回调---
- (void) textViewDidChangeAction:(NSNotification *)sender {
    
    if (self.text.length == 0) {
        
        self.placeholderLabel.hidden = NO;
    }else {
        
        self.placeholderLabel.hidden = YES;
    }
}

- (void) textViewDidEndEditorAction:(NSNotification *)sender {
    
    if (self.textEndEditorBlock) {
        
        self.textEndEditorBlock(self.text);
    }
}

- (void) textViewBeginEditorAction:(NSNotification *)sender {
    
    if (self.textBeginEditorBlock) {
        
        self.textBeginEditorBlock();
    }
}

#pragma mark ---UITextViewDelegate---
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    
    if (self.textChangeBlock) {
        
        self.textChangeBlock(self.text, self.text.length);
    }
    
    if (self.limitWordsNum <= 0) {
        
        return YES;
    }else if (text.length == 0) {
        
        return YES;
    }else if (textView.text.length >= self.limitWordsNum) {
        
        if (self.beyondLimitWords) {
            
            self.beyondLimitWords();
        }
        return NO;
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    self.placeholderLabel.hidden = YES;
}

@end






















