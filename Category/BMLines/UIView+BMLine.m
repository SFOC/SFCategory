//
//  BMLine.m
//  BMLine
//
//  Created by NADA_BM on 15/10/21.
//  Copyright © 2015年 NADA_BM. All rights reserved.
//

#import "UIView+BMLine.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

NSString *const BMLineType = @"BMLineType";
NSString *const BMLineOffset = @"BMLineOffset";
NSString *const BMLineBothSides = @"BMLineBothSides";

@implementation UIView (BMLine)

- (void)addLine {
  [self addLineWithColor:nil];
}

- (void)addLineWithColor:(UIColor *)color {
  [self addLineWithColor:color position:BMLinePostionCustomBottom];
}

- (void)addLineWithColor:(UIColor *)color
                position:(BMLinePostionCustom)position {
  [self addLineWithColor:color position:position attributes:nil];
}

- (void)addLineWithColor:(UIColor *)color
                position:(BMLinePostionCustom)position
              attributes:(NSDictionary *)attributes {
  if ([attributes isKindOfClass:[NSDictionary class]]) {
    BMLineTypeCustom type = BMLineTypeCustomDefault;
    if (attributes[BMLineType]) {
      if ([attributes[BMLineType] isKindOfClass:[NSNumber class]] ||
          [attributes[BMLineType] isKindOfClass:[NSString class]]) {
        type = [attributes[BMLineType] integerValue];
      }
    }
    [self addLineWithType:type
                    color:color
                 position:position
               attributes:attributes];
  } else {
    [self addLineWithType:BMLineTypeCustomDefault
                    color:color
                 position:position
               attributes:nil];
  }
}

- (void)addLineWithType:(BMLineTypeCustom)type
                  color:(UIColor *)color
               position:(BMLinePostionCustom)position
             attributes:(NSDictionary *)attributes {

  CGFloat offset = 0.0;
  BOOL bothSides = NO;
  if ([attributes isKindOfClass:[NSDictionary class]]) {
    if (attributes[BMLineBothSides]) {
      if ([attributes[BMLineBothSides] isKindOfClass:[NSNumber class]] ||
          [attributes[BMLineBothSides] isKindOfClass:[NSString class]]) {
        bothSides = [attributes[BMLineBothSides] integerValue] == 0 ? NO : YES;
      }
    }
    if (attributes[BMLineOffset]) {
      if ([attributes[BMLineOffset] isKindOfClass:[NSNumber class]] ||
          [attributes[BMLineOffset] isKindOfClass:[NSString class]]) {
        offset = [attributes[BMLineOffset] floatValue];
      }
    }
  }

  UIView *line;
  //判断此View上的这个位置是否已经存在线，如果存在则覆盖
  NSMutableDictionary *dic =
      [objc_getAssociatedObject(self, kBMLineStoreKey) mutableCopy];
  if ([dic objectForKey:[NSString stringWithFormat:@"%lu", position]]) {
    [self removeLineWithPosition:position];
  }
  if (position == BMLinePostionCustomAll) {
    [self addLineAll:type color:color attributes:attributes];
    return;
  } else if (position == BMLinePostionCustomTB) {
    [self addLineTB:type color:color attributes:attributes];
    return;
  }

  switch (type) {
  case BMLineTypeCustomDefault: {
    line = [[BMLineCumstomDefault alloc] init];
    [self setUpLine:line
           position:position
              width:BMDefaultLineWidth
             offset:offset
          BothSides:bothSides];

  } break;
  case BMLineTypeCustomDash: {
    line = [[BMLineCumstomDash alloc] init];
    [self setUpLine:line
           position:position
              width:BMDashLineWidth
             offset:offset
          BothSides:bothSides];

  } break;
  case BMLineTypeCustomDot: {
    line = [[BMLineCumstomDot alloc] init];
    [self setUpLine:line
           position:position
              width:2 * BMDotLineRadius
             offset:offset
          BothSides:bothSides];
  } break;
  default:
    break;
  }
  //将对象关联到此View
  if (!dic) {
    dic = @{}.mutableCopy;
  }
  [(BMLineCumstomDefault *)line setLineColor:color ? color : bgColor];
  [line isKindOfClass:[BMLineCumstomDefault class]]
      ? 0
      : (line.backgroundColor = [UIColor clearColor]);
  [dic setObject:line forKey:[NSString stringWithFormat:@"%lu", position]];
  objc_setAssociatedObject(self, kBMLineStoreKey, dic,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  [self addSubview:line];
}

- (void)addLineAll:(BMLineTypeCustom)type
             color:(UIColor *)color
        attributes:(NSDictionary *)attributes {

  [self addLineWithType:type
                  color:color
               position:BMLinePostionCustomTop
             attributes:attributes];
  [self addLineWithType:type
                  color:color
               position:BMLinePostionCustomRight
             attributes:attributes];
  [self addLineWithType:type
                  color:color
               position:BMLinePostionCustomBottom
             attributes:attributes];
  [self addLineWithType:type
                  color:color
               position:BMLinePostionCustomLeft
             attributes:attributes];
}

- (void)addLineTB:(BMLineTypeCustom)type
            color:(UIColor *)color
       attributes:(NSDictionary *)attributes {
  [self addLineWithType:type
                  color:color
               position:BMLinePostionCustomTop
             attributes:attributes];
  [self addLineWithType:type
                  color:color
               position:BMLinePostionCustomBottom
             attributes:attributes];
}

- (void)setUpLine:(UIView *)line
         position:(BMLinePostionCustom)position
            width:(CGFloat)lineWidth
           offset:(CGFloat)offset
        BothSides:(BOOL)both {

  CGFloat lienX = 0.0, lineY = 0.0;
  if (position == BMLinePostionCustomTop ||
      position == BMLinePostionCustomCenterY ||
      position == BMLinePostionCustomBottom) {
    if (position == BMLinePostionCustomCenterY)
      lineY = BMFrameHeight / 2;
    if (position == BMLinePostionCustomBottom)
      lineY = BMFrameHeight - lineWidth;
    if (both) {
      line.frame = CGRectMake(fabs(offset), lineY,
                              BMFrameWidth - 2 * fabs(offset), lineWidth);
    } else {
      line.frame = CGRectMake(offset > 0 ? offset : 0, lineY,
                              BMFrameWidth - fabs(offset), lineWidth);
    }
  } else if (position == BMLinePostionCustomLeft ||
             position == BMLinePostionCustomCenterX ||
             position == BMLinePostionCustomRight) {
    if (position == BMLinePostionCustomCenterX)
      lienX = BMFrameWidth / 2;
    if (position == BMLinePostionCustomRight)
      lienX = BMFrameWidth - lineWidth;

    if (both) {
      line.frame = CGRectMake(lienX, fabs(offset), lineWidth,
                              BMFrameHeight - 2 * fabs(offset));
    } else {
      line.frame = CGRectMake(lienX, offset > 0 ? offset : 0, lineWidth,
                              BMFrameHeight - fabs(offset));
    }
  }
}

- (void)removeLineWithPosition:(BMLinePostionCustom)position {
  NSMutableDictionary *dic =
      [objc_getAssociatedObject(self, kBMLineStoreKey) mutableCopy];
  if (!dic) {
    return;
  }
  NSString *dicKey = [NSString stringWithFormat:@"%lu", position];
  UIView *view = [dic objectForKey:dicKey];
  if (!view) {
    return;
  }
  [view removeFromSuperview];
  [dic removeObjectForKey:dicKey];
  objc_setAssociatedObject(self, kBMLineStoreKey, dic,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)removeAllLines {
  NSMutableDictionary *dic =
      [objc_getAssociatedObject(self, kBMLineStoreKey) mutableCopy];
  if (!dic) {
    return;
  }
  if (dic.count > 0) {
    for (UIView *view in [dic allValues]) {
      [view removeFromSuperview];
    }
    [dic removeAllObjects];
  }
  objc_setAssociatedObject(self, kBMLineStoreKey, nil,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  return;
}





@end
