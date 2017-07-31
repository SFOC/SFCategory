//
//  UIView+LJC.h
//
//
//  Created by  on 12-1-13.
//  Copyright (c) 2012年 LJC. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FlexibleT UIViewAutoresizingFlexibleTopMargin
#define FlexibleB UIViewAutoresizingFlexibleBottomMargin
#define FlexibleL UIViewAutoresizingFlexibleLeftMargin
#define FlexibleR UIViewAutoresizingFlexibleRightMargin
#define FlexibleH UIViewAutoresizingFlexibleHeight
#define FlexibleW UIViewAutoresizingFlexibleWidth

#define FixedMarginT FlexibleW | FlexibleB
#define FixedMarginB FlexibleW | FlexibleT
#define FixedMarginL FlexibleH | FlexibleR
#define FixedMarginR FlexibleH | FlexibleL
#define FixedHorizental FlexibleW | FlexibleT | FlexibleB
#define FixedVertical FlexibleH | FlexibleL | FlexibleR
#define FixedALL FlexibleW | FlexibleH
#define FixedCenter FlexibleL | FlexibleR | FlexibleT | FlexibleB

@interface UIView (LJC)

//+ (UIImageView *)viewWithColor:(UIColor *)color;

- (void)setTagName:(NSString *)name;
- (UIView *)viewWithName:(NSString *)name;
- (void)addToolbar:(UIView *)toolbar;
- (void)setPosition:(CGRect)position;

- (UIView *)getFirstResponder;
- (BOOL)haveSubview:(UIView *)subView;
- (UIView *)superViewIsKindOfClass:(Class)cls;

- (void)setRoundedCornersRadius:(CGFloat)radius;
- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius;

- (void)setShadowRadius:(CGFloat)radius;
- (void)setShadowCorners:(UIRectCorner)corners radius:(CGFloat)radius;

//- (void)pauseAnimation;
//- (void)resumeAnimation;

@property(nonatomic) float x;
@property(nonatomic) float y;
@property(nonatomic) float w;
@property(nonatomic) float h;

@end
