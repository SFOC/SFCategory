//
//  NSString+Hashes.h
//  MGGKit
//
//  Created by Apple on 16/1/4.
//  Copyright © 2016年 MaGuGi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Hashes)

/**
 *  Sha1加密
 *
 *  @return
 */
- (NSString *)sha1;

/**
 *  Base64加密
 *
 *  @return
 */
- (NSString *)base64;

/**
 *  Base64解密
 *
 *  @return
 */
- (NSString *)base64Decode;

/**
 *  @author John, 16-05-12
 *
 *  md5
 *
 *  @return
 */
- (NSString *)md5;
@end