//
//  NSString+Hashes.m
//  MGGKit
//
//  Created by Apple on 16/1/4.
//  Copyright © 2016年 MaGuGi. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>

#import "NSString+Hashes.h"

@implementation NSString (Hashes)

- (NSString *)sha1 {
  NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
  uint8_t digest[CC_SHA1_DIGEST_LENGTH];

  CC_SHA1(data.bytes, data.length, digest);

  NSMutableString *output =
      [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];

  for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
    [output appendFormat:@"%02x", digest[i]];
  }

  return output;
}

- (NSString *)base64 {
  NSData *strData = [self dataUsingEncoding:NSUTF8StringEncoding];
  NSString *encodeStr = [strData base64EncodedStringWithOptions:0];
  return encodeStr;
}

- (NSString *)base64Decode {

  NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];

  NSString *resultStr =
      [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

  return resultStr;
}

- (NSString *)md5 {
  const char *cStr = [self UTF8String];
  unsigned char digest[CC_MD5_DIGEST_LENGTH];
  CC_MD5(cStr, (unsigned int)strlen(cStr), digest);
  NSMutableString *output =
      [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
  for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    [output appendFormat:@"%02X", digest[i]];
  return output;
}
@end