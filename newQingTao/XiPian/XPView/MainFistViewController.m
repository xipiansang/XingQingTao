//
//  MainFistViewController.m
//  newQingTao
//
//  Created by 刘中天 on 2016/12/8.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import "MainFistViewController.h"

@interface MainFistViewController ()

@end

@implementation MainFistViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    XPTabBarViewController * ct =(XPTabBarViewController *) window.rootViewController;
    [ct hidCBTabbar:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
