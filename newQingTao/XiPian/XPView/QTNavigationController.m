//
//  QTNavigationController.m
//  QingTao_Manage
//
//  Created by 管振东 on 16/4/20.
//  Copyright © 2016年 guanzd. All rights reserved.
//

#import "QTNavigationController.h"
#import "UIBarButtonItem+Sunday.h"

@interface QTNavigationController ()<UINavigationControllerDelegate>

@end

@implementation QTNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate=self;
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self.navigationBar setShadowImage:[UIImage imageWithColor:LINE_COLOR]];
    
//    NSDictionary *attrs = @{NSForegroundColorAttributeName : HEX_COLOR(@"#323232")};
//    [self.navigationBar setTitleTextAttributes:attrs];
//    
//    self.navigationBar.tintColor = MAIN_COLOR;
    
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.interactivePopGestureRecognizer.delegate = nil;
//    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        
        /* 设置导航栏上面的内容 */
        // 设置左边的返回按钮
        UIBarButtonItem *backItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"sz_back_icon" highlightedImage:@"sz_back_icon"];
        
//        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
//                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
//                                           target:nil action:nil];
//        negativeSpacer.width = -10;
        viewController.navigationItem.leftBarButtonItems = @[backItem];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 删除系统自带的tabBarButton
    for (UIView *tabBar in self.tabBarController.tabBar.subviews) {
        if ([tabBar isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBar removeFromSuperview];
        }
    }
    UITabBar *tabbar=self.tabBarController.tabBar;
    tabbar.hidden=YES;
}

- (void)back {
    [self popViewControllerAnimated:YES];
}


@end
