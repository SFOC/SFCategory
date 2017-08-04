//
//  UIImage+SFInterceptionSquareImage.m
//  SD加载图片后裁剪为正方形1
//  截取正方形图片
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 Fly. All rights reserved.
//

#import "UIImage+SFInterceptionSquareImage.h"

@implementation UIImage (SFInterceptionSquareImage)
/*!
 截取正方形图片
 */
- (UIImage*)interceptionSquareImage:(UIImage *)image{
    
    if (image) {
        CGFloat width = MIN(image.size.width, image.size.height);
        CGFloat maxHeightOrWidth = MAX(image.size.width, image.size.height);
        CGPoint X_Y = CGPointMake(0, 0);
        if (image.size.width >= image.size.height) {
            X_Y = CGPointMake((maxHeightOrWidth-width)/2, 0);
        }else {
            X_Y = CGPointMake(0, (maxHeightOrWidth-width)/2);
        }
        
        CGRect myRect = CGRectMake(X_Y.x, X_Y.y, width, width);
        NSLog(@"%@",image);
        NSLog(@"%f==%f==%f==%f",myRect.origin.x,myRect.origin.y,myRect.size.width,myRect.size.height);
        CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, myRect);
        CGRect smallBounds = CGRectMake(0,0,CGImageGetWidth(subImageRef),CGImageGetHeight(subImageRef));
        
        UIGraphicsBeginImageContext(smallBounds.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextDrawImage(context, smallBounds, subImageRef);
        UIImage *smallImage = [UIImage imageWithCGImage:subImageRef];
        UIGraphicsEndImageContext();
        
        return smallImage;
    }
    return nil;
}

@end
