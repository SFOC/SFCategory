//
//  SFDropDownMenuMaro.h
//  SFDropDownMenu
//
//  Created by fly on 2018/5/6.
//  Copyright © 2018年 石峰(fly). All rights reserved.
//

#ifndef SFDropDownMenuMaro_h
#define SFDropDownMenuMaro_h

#define SF_DDM_Width [UIScreen mainScreen].bounds.size.width

#define SF_DDM_Height [UIScreen mainScreen].bounds.size.height

/// RGBA颜色处理
#define SF_UIColorFromRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

/// RGBA_十六进制颜色处理
#define SF_UIColorFromRGBAHEX(rgbaHex) [UIColor colorWithRed:((float)((rgbaHex & 0xFF0000) >> 16))/255.0 green:((float)((rgbaHex & 0xFF00) >> 8))/255.0 blue:((float)(rgbaHex & 0xFF))/255.0 alpha:1.0]



#endif /* SFDropDownMenuMaro_h */
