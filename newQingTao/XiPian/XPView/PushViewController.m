//
//  PushViewController.m
//  newQingTao
//
//  Created by 刘中天 on 2016/12/8.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()

@end

@implementation PushViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    XPTabBarViewController * ct =(XPTabBarViewController *) window.rootViewController;
    [ct hidCBTabbar:YES];
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
