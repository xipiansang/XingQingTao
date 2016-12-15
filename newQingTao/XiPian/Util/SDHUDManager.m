//
//  SDHUDManager.m
//  QingTao
//
//  Created by yu on 16/2/24.
//  Copyright © 2016年 Yu. All rights reserved.
//

#import "SDHUDManager.h"

@implementation SDHUDManager

+ (SDHUDManager *)shareManager
{
    static SDHUDManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SDHUDManager alloc] init];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD setBackgroundColor:[UIColor sd_colorWithHexString:@"#000000" alpha:0.45]];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD setMinimumDismissTimeInterval:0.8];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    });
    return manager;
}

- (void)setupWithViewController:(UIViewController *)bgVC
{
    if (bgVC) {
        [SVProgressHUD setViewForExtension:bgVC.view];
        if (bgVC.navigationController.navigationBarHidden || !bgVC.navigationController) {
            [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0, - 20)];
        }else {
            [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0, - 64)];
        }
    }else {
        [SVProgressHUD setViewForExtension:[UIApplication sharedApplication].keyWindow];
        [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0, - 20)];
    }
}

+ (void)showWithBgViewController:(UIViewController *)bgVC
{
    [self showWithStatus:nil bgViewController:bgVC];
}

+ (void)showWithStatus:(NSString*)status bgViewController:(UIViewController *)bgVC
{
    [self showProgress:-1 status:status bgViewController:bgVC];
}

+ (void)showProgress:(float)progress bgViewController:(UIViewController *)bgVC
{
    [self showProgress:progress status:nil bgViewController:bgVC];
}

+ (void)showProgress:(float)progress status:(NSString*)status bgViewController:(UIViewController *)bgVC
{
    [[self shareManager] setupWithViewController:bgVC];
    [SVProgressHUD showProgress:progress status:status];
}

+ (void)dismiss
{
    [self dismissWithDelay:0];
}

+ (void)dismissWithDelay:(NSTimeInterval)delay
{
    [SVProgressHUD dismissWithDelay:delay];
}

+ (void)setStatus:(NSString*)status
{
    [SVProgressHUD setStatus:status];
}// change the HUD loading status while it's showing

// stops the activity indicator, shows a glyph + status, and dismisses the HUD a little bit later
+ (void)showInfoWithStatus:(NSString*)status bgViewController:(UIViewController *)bgVC
{
    [[self shareManager] setupWithViewController:bgVC];
    if ([status isKindOfClass:[NSNull class]]) {
        status = nil;
    }
    [SVProgressHUD showInfoWithStatus:status];
}

+ (void)showSuccessWithStatus:(NSString*)status bgViewController:(UIViewController *)bgVC
{
    [[self shareManager] setupWithViewController:bgVC];
    if ([status isKindOfClass:[NSNull class]]) {
        status = nil;
    }
    [SVProgressHUD showSuccessWithStatus:status];
}

+ (void)showErrorWithStatus:(NSString*)status bgViewController:(UIViewController *)bgVC
{
    [[self shareManager] setupWithViewController:bgVC];
    if ([status isKindOfClass:[NSNull class]]) {
        status = nil;
    }
    [SVProgressHUD showErrorWithStatus:status];
}

// shows a image + status, use 28x28 white PNGs
+ (void)showImage:(UIImage *)image status:(NSString*)status bgViewController:(UIViewController *)bgVC
{
    [[self shareManager] setupWithViewController:bgVC];
    if ([status isKindOfClass:[NSNull class]]) {
        status = nil;
    }
    [SVProgressHUD showImage:image status:status];
}


@end
