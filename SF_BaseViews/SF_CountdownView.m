//
//  SF_CountdownView.m
//  测试
//  倒计时View
//  Created by fly on 2018/6/27.
//  Copyright © 2018年 fly(石峰). All rights reserved.
//

#import "SF_CountdownView.h"


@interface SF_CountdownView (){
    
    CAShapeLayer *circleLayer;
}

/// 倒计时按钮
@property (nonatomic, strong) UIButton *countdownBtn;

/// 倒计时定时器
@property (nonatomic, strong) NSTimer *timer;

/// 圆环定时器
@property (nonatomic, strong) NSTimer *circleTimer;

/// 圆环当前秒数
@property (nonatomic, assign) CGFloat circleCurrentSecond;

/// 当前秒数
@property (nonatomic, assign) NSInteger currentSecond;
@end

@implementation SF_CountdownView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeData];
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self initializeData];
}

#pragma mark ---初始化---
/// 初始化
- (void) initializeData {
    
    self.totalSeconds = 10;
    self.countdownBtnBackgroundColor = [UIColor whiteColor];
    self.countdownBtnTitleColor = [UIColor blackColor];
    self.circleColor = [UIColor blueColor];
    self.circleCurrentSecond = 0.0;
    
    
    [self addSubview:self.countdownBtn];
}

#pragma mark ---按钮回调---
/// 点击了倒计时按钮
- (void) countdownAction:(UIButton *)sender {
    
    [self.timer invalidate];
    self.timer = nil;
    
    [self.circleTimer invalidate];
    self.circleTimer = nil;
    
    if (self.clickCountdownBtnBlock) {
        
        self.clickCountdownBtnBlock();
    }
    
    NSLog(@"点击了倒计时按钮");
}

/// 定时器回调
- (void) countdownTimerAction {
    
    
    self.currentSecond--;
    if (self.currentSecond <= 0) {
        
        NSLog(@"倒计时完成");
        [self.timer invalidate];
        self.timer = nil;
        
        [self.circleTimer invalidate];
        self.circleTimer = nil;
        
        
        if (self.countdownCompleteBlock) {
            
            self.countdownCompleteBlock();
        }
    }
}

/// 圆环定时器回调
- (void) circleTimerAction {
    
    self.circleCurrentSecond += 1.0/60.0;
    [circleLayer removeFromSuperlayer];
    CGRect rect = self.frame;
    CGFloat width = MIN(rect.size.width, rect.size.height);
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2, width/2) radius:width/2 startAngle:-M_PI/2 + self.circleCurrentSecond/self.totalSeconds*M_PI*2  endAngle:M_PI/2*3 clockwise:YES];
    circleLayer = [CAShapeLayer layer];
    circleLayer.path = circlePath.CGPath;
    circleLayer.strokeColor = self.circleColor.CGColor;
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    circleLayer.lineWidth = 2;
    [self.layer addSublayer:circleLayer];
}

#pragma mark ---set方法---
- (void)setTotalSeconds:(NSInteger)totalSeconds {
    
    _totalSeconds = totalSeconds;
    
    _currentSecond = totalSeconds;
    [self.countdownBtn setTitle:[NSString stringWithFormat:@"%zd秒",totalSeconds] forState:UIControlStateNormal];
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    CGRect rect = self.frame;
    CGFloat width = MIN(rect.size.width, rect.size.height);
    self.countdownBtn.frame = CGRectMake(2, 2, width - 4, width - 4);
    self.countdownBtn.layer.masksToBounds = YES;
    self.countdownBtn.layer.cornerRadius = (width - 4)/2.0;
    
    
    UIBezierPath *trickCirclePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2, width/2) radius:width/2 startAngle:-M_PI/2 endAngle:M_PI/2*3 clockwise:YES];
    CAShapeLayer *trickCircleLayer = [CAShapeLayer layer];
    trickCircleLayer.path = trickCirclePath.CGPath;
    trickCircleLayer.strokeColor = [UIColor colorWithRed:220.0/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
    trickCircleLayer.fillColor = [UIColor clearColor].CGColor;
    trickCircleLayer.lineWidth = 2;
    [self.layer addSublayer:trickCircleLayer];
    
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2, width/2) radius:width/2 startAngle:-M_PI/2 endAngle:M_PI/2*3 clockwise:YES];
    circleLayer = [CAShapeLayer layer];
    circleLayer.path = circlePath.CGPath;
    circleLayer.strokeColor = self.circleColor.CGColor;
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    circleLayer.lineWidth = 2;
    [self.layer addSublayer:circleLayer];
    
    
}

- (void)setCurrentSecond:(NSInteger)currentSecond {
    
    _currentSecond = currentSecond;
    
    [self.countdownBtn setTitle:[NSString stringWithFormat:@"%zd秒",currentSecond] forState:UIControlStateNormal];
}

- (void)setCountdownBtnBackgroundColor:(UIColor *)countdownBtnBackgroundColor {
    _countdownBtnBackgroundColor = countdownBtnBackgroundColor;
    
    [self.countdownBtn setBackgroundColor:countdownBtnBackgroundColor];
}

- (void)setCountdownBtnTitleColor:(UIColor *)countdownBtnTitleColor {
    _countdownBtnTitleColor = countdownBtnTitleColor;
    
    [self.countdownBtn setTitleColor:countdownBtnTitleColor forState:UIControlStateNormal];
}

- (void)setCircleColor:(UIColor *)circleColor {
    
    _circleColor = circleColor;
    
    circleLayer.strokeColor = circleColor.CGColor;
}

#pragma mark ---外部调用方法---
- (void)startAnimation {
    
    NSLog(@"开始进行动画了");
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdownTimerAction) userInfo:nil repeats:YES];
    
    [self.circleTimer invalidate];
    self.circleTimer = nil;
    self.circleTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(circleTimerAction) userInfo:nil repeats:YES];
}

#pragma mark ---懒加载---
- (UIButton *)countdownBtn {
    
    if (!_countdownBtn) {
        
        _countdownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _countdownBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_countdownBtn addTarget:self action:@selector(countdownAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _countdownBtn;
}

@end
