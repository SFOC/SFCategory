//
//  UIImage+SFInterceptionSquareImage.h
//  SD加载图片后裁剪为正方形1
//  截取正方形图片
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 Fly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SFInterceptionSquareImage)
/*!
 截取正方形图片,以图片中心开始截取
 */
- (UIImage*)interceptionSquareImage:(UIImage *)image;
@end
