//
//  SDMacro.h
//  SundayFramework
//
//  Created by 管振东 on 16/4/20.
//  Copyright © 2016年 guanzd. All rights reserved.
//

#ifndef SDMacro_h
#define SDMacro_h

// 个人信息相关
#define USERID  [QTAccount sharedAccount].ID
#define USER_TYPE   [QTAccount sharedAccount].type

// weakSelf
#define WS(weakSelf) __weak __typeof(self)weakSelf = self;

// 屏幕相关
#define kScreenWidth    ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight    ([UIScreen mainScreen].bounds.size.height)
#define kStatusBarHeight    ([UIApplication sharedApplication].statusBarFrame.size.height)
#define kNavigationBarHeight    44
#define SCREEN_SCALE    [UIScreen mainScreen].scaled

//适配
#define SP_BeiShu (kScreenWidth/375)
#define SP_Floatt(floatt) (floatt*SP_BeiShu)

// 颜色相关
#define RGBA_COLOR(r, g, b, a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define RGB_COLOR(r, g, b)  RGBA_COLOR(r, g, b, 1)

#define HEX_COLOR(hex)  [UIColor sd_colorWithHexString:hex]

#define RANDOM_COLOR   RGB_COLOR(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define MAIN_COLOR  HEX_COLOR(@"317FFF")

#define LINE_COLOR  HEX_COLOR(@"#E5E5E5")

#define SEPARATOR_COLOR  HEX_COLOR(@"#E5E5E5")

#define BORDER_COLOR    HEX_COLOR(@"#C1C1C1")

#define BACKGROUND_COLOR  HEX_COLOR(@"#EFF0F4")

// 默认背景
#define kPlaceholderImage   [UIImage imageNamed:@"default"]
#define kAvatarPlaceholderImage [UIImage imageNamed:@"default"]

// 型号(尺寸相关)
#define iPhone4 (480 == ([[UIScreen mainScreen] bounds].size.height) ? YES : NO)
#define iPhone5 (568 == ([[UIScreen mainScreen] bounds].size.height) ? YES : NO)
#define iPhone6 (667 == [[UIScreen mainScreen] bounds].size.height ? YES : NO)
#define iPhone6p (736 == [[UIScreen mainScreen] bounds].size.height ? YES : NO)

// 系统相关
#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define iOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)
#define iOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? YES : NO)


#endif /* SDMacro_h */
