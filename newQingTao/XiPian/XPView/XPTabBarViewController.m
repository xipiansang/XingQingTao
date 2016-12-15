//
//  XPTabBarViewController.m
//  newQingTao
//
//  Created by 刘中天 on 2016/12/7.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import "XPTabBarViewController.h"

@interface XPTabBarViewController ()<UITabBarDelegate>{
    UIView *view;
    NSArray *aarray;
    NSArray *sselectArray;
    NSMutableArray *buttonA;
}
@end

@implementation XPTabBarViewController

-(instancetype)initWithArray:(NSArray *)array :(NSArray *)selectArray{
    self=[super init];
    if (self) {
        aarray=array;
        sselectArray=selectArray;
        buttonA=[NSMutableArray array];
        [self addTabBar];
    }
    return self;
}

-(void)addTabBar{
    CGRect rect=self.tabBar.frame;
    [self.tabBar removeAllSubviews];
    view=[[UIView alloc] init];
    view.frame=rect;
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    
    for (int i=0; i<aarray.count; i++) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:aarray[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:sselectArray[i]] forState:UIControlStateSelected];
        button.tag=i+100;
//        button.backgroundColor=[UIColor redColor];
        button.frame=CGRectMake(kScreenWidth/aarray.count*i+0, 0, kScreenWidth/aarray.count, rect.size.height);
        [button addTarget:self action:@selector(buttonC:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        [buttonA addObject:button];
        if (i==0) {
            button.selected=YES;
        }
    }
}

-(void)buttonC:(UIButton *)b{
    for (UIButton *bb in buttonA) {
        bb.selected=NO;
        if (bb.tag==b.tag) {
            bb.selected=YES;
        }
    }
    [self clickBtn:b];
}

//通过点击tabBar上面的button来跳转控制器
- (void)clickBtn:(UIButton *)button {
    //4.跳转到相应的视图控制器. (通过selectIndex参数来设置选中了那个控制器)
    self.selectedIndex = button.tag-100;
    NSLog(@"%ld",(long)button.tag);
    
}

//通过设置View的透明度来隐藏tabBar
-(void)hidCBTabbar:(BOOL)ishid{
    if (ishid) {
        view.alpha = 0;
    }else{
        view.alpha = 1;
    }
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
