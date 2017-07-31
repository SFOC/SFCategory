//
//  BMLineType.m
//  BMLine
//
//  Created by NADA_BM on 15/10/21.
//  Copyright © 2015年 NADA_BM. All rights reserved.
//

#import "BMLineCumstomDefault.h"

@implementation BMLineCumstomDefault

- (void)setLineColor:(UIColor *)lineColor {
  _lineColor = lineColor;
  self.backgroundColor = _lineColor;

}

@end

@implementation BMLineCumstomDash

- (void)drawRect:(CGRect)rect {

  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetLineWidth(context, BMDashLineWidth);
  CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
  CGFloat lengths[] = {BMDashLineLength};
  CGContextSetLineDash(context, 0, lengths, 1);
  //  CGFloat lengths[] = {2,1};
  //  CGContextSetLineDash(context, 0, lengths, 2);
  if (BMFrameWidth > BMFrameHeight) {
    CGContextMoveToPoint(context, 0, BMDashLineWidth / 2.0);
    CGContextAddLineToPoint(context, BMFrameWidth, BMDashLineWidth / 2.0);
  } else {
    CGContextMoveToPoint(context, BMDashLineWidth / 2.0, 0);
    CGContextAddLineToPoint(context, BMDashLineWidth / 2.0, BMFrameHeight);
  }
  CGContextStrokePath(context);
  CGContextClosePath(context);
}
@end

@implementation BMLineCumstomDot

- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, self.lineColor.CGColor);
  if (BMFrameWidth > 10) {
    for (float i = BMDotLineRadius; i < BMFrameWidth;
         i += 4 * BMDotLineRadius) {
      CGContextAddArc(context, i, BMDotLineRadius, BMDotLineRadius, 0, 2 * M_PI,
                      0);
      CGContextDrawPath(context, kCGPathFill);
    }
  } else {
    for (float i = BMDotLineRadius; i < BMFrameHeight;
         i += 4 * BMDotLineRadius) {
      CGContextAddArc(context, BMDotLineRadius, i, BMDotLineRadius, 0, 2 * M_PI,
                      0);
      CGContextDrawPath(context, kCGPathFill);
    }
  }
}

@end
