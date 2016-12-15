//
//  ChangeNameViewController.m
//  newQingTao
//
//  Created by 刘中天 on 2016/12/8.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import "ChangeNameViewController.h"
#import "TitleTextFieldClearView.h"
@interface ChangeNameViewController ()

@end

@implementation ChangeNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self addView];
}


-(void)addView{
    UITextField *text=[[UITextField alloc] initWithFrame:CGRectMake(0, SP_Floatt(74), kScreenWidth, SP_Floatt(60))];
    UILabel *labl=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, SP_Floatt(85), SP_Floatt(60))];
    text.leftView=labl;
    text.backgroundColor=[UIColor redColor];
    text.leftViewMode=UITextFieldViewModeAlways;
    [self.view addSubview:text];
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
