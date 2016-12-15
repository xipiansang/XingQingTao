//
//  SDHUDManager.h
//  QingTao
//
//  Created by yu on 16/2/24.
//  Copyright © 2016年 Yu. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface SDHUDManager : NSObject

/**
 *  HUD管理工具
 *
 *  @param bgVC       设置HUD展示的视图容器，nil时为window
 *  @param status     设置HUD的提示语
 *  @param progress   设置HUD的进度
 *  @param image      设置HUD的自定义图片   use 28x28 white PNGs
 */

+ (void)showWithBgViewController:(UIViewController *)bgVC;
+ (void)showWithStatus:(NSString*)status bgViewController:(UIViewController *)bgVC;
+ (void)showProgress:(float)progress bgViewController:(UIViewController *)bgVC;
+ (void)showProgress:(float)progress status:(NSString*)status bgViewController:(UIViewController *)bgVC;

+ (void)setStatus:(NSString*)status;  // change the HUD loading status while it's showing

+ (void)showInfoWithStatus:(NSString*)status bgViewController:(UIViewController *)bgVC;
+ (void)showSuccessWithStatus:(NSString*)status bgViewController:(UIViewController *)bgVC;
+ (void)showErrorWithStatus:(NSString*)status bgViewController:(UIViewController *)bgVC;
+ (void)showImage:(UIImage *)image status:(NSString*)status bgViewController:(UIViewController *)bgVC;

+ (void)dismiss;
+ (void)dismissWithDelay:(NSTimeInterval)delay;

@end
