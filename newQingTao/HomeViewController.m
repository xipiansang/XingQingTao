//
//  HomeViewController.m
//  XingQingTao
//
//  Created by 刘中天 on 2016/12/3.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeHomeViewController.h"
#import "LimitViewController.h"
#import "PackClusterViewController.h"
#import "DirectPurchasingViewController.h"
#import "CashbackViewController.h"
@interface HomeViewController ()<UIScrollViewDelegate>{
    UIScrollView *scrollV;
    UIScrollView *scrollBV;
    UIImageView *line;
    UITableView *tableV1;
    UITableView *tableV2;
    UITableView *tableV3;
    UITableView *tableV4;
    UITableView *tableV5;
}

@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the
    UIImageView *BGImage=[[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    BGImage.image=[UIImage imageNamed:@"back1"];
    [self.view addSubview:BGImage];
    [self addView];
}

-(void)addView{

    
    NSArray *array=@[@"首页",@"限量闪购",@"爆款拼团",@"品牌直购",@"轻淘返现"];
    UIView *whiteV=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SP_Floatt(87))];
    whiteV.backgroundColor=[UIColor whiteColor];
    UIImageView *yyImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, SP_Floatt(45), kScreenWidth, SP_Floatt(42))];
    yyImage.image=[UIImage imageNamed:@"liebiao"];
    [whiteV addSubview:yyImage];
//    [self.view bringSubviewToFront:whiteV];
    //添加加载Button的scroll
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [whiteV addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(whiteV).offset(SP_Floatt(20));
        make.right.equalTo(whiteV).offset(-SP_Floatt(15));
        make.size.mas_equalTo(CGSizeMake(SP_Floatt(30), SP_Floatt(30)));
    }];
    
    scrollBV =[[UIScrollView alloc] initWithFrame:CGRectMake(0, SP_Floatt(45), kScreenWidth, SP_Floatt(35))];
    //循环加载lable
    for (int i=0; i<5; i++) {
        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0+i*(kScreenWidth/4-4), 0, kScreenWidth/4-4, SP_Floatt(35))];
        lable.text=array[i];
        lable.textAlignment=NSTextAlignmentCenter;
        lable.font=[UIFont systemFontOfSize:13];
        lable.tag=30+i;
        lable.textColor=[UIColor blackColor];
        lable.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lableC:)];
        [lable addGestureRecognizer:tap];
        [scrollBV addSubview:lable];
    }
    scrollBV.contentSize=CGSizeMake((kScreenWidth/4-4)*5, 0);
    scrollBV.showsHorizontalScrollIndicator=NO;
//    scrollBV.delegate=self;
    
    //添加信息展示的scroll
    scrollV=[[UIScrollView alloc] initWithFrame:CGRectMake(0, SP_Floatt(87), kScreenWidth, kScreenHeight-SP_Floatt(87))];
    scrollV.contentSize=CGSizeMake(kScreenWidth*5, 0);
    scrollV.showsHorizontalScrollIndicator=NO;
    scrollV.bounces=NO;
    scrollV.pagingEnabled=YES;
    scrollV.delegate=self;
    [self.view addSubview:scrollV];
    
    line=[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/16-1, SP_Floatt(33), kScreenWidth/8-2, 2)];
    line.image=[UIImage imageNamed:@"juxing"];
    [scrollBV addSubview:line];
    [whiteV addSubview:scrollBV];
    
    [self addChild];
    
    UIViewController *viewC=self.childViewControllers[0];
    [scrollV addSubview:viewC.view];
    
    [self.view addSubview:whiteV];
}

//添加子视图
-(void)addChild{
    HomeHomeViewController *vc1=[[HomeHomeViewController alloc] init];
    LimitViewController *vc2=[[LimitViewController alloc] init];
    PackClusterViewController *vc3=[[PackClusterViewController alloc] init];
    DirectPurchasingViewController *vc4=[[DirectPurchasingViewController alloc] init];
    CashbackViewController *vc5=[[CashbackViewController alloc] init];
    NSArray *array=@[vc1,vc2,vc3,vc4,vc5];
    for (int i=0; i<5; i++) {
        UIViewController *vc=array[i];
        vc.view.frame=CGRectMake(0+i*kScreenWidth, 0, kScreenWidth, kScreenHeight);
        [self addChildViewController:vc];
        [scrollV addSubview:vc.view];
    }
}

//选择加载那个子视图
-(void)selectViewController:(NSUInteger)index{
    UIViewController *vc=self.childViewControllers[index];
    //要注意加载的承接是哪个
    [scrollV addSubview:vc.view];
}

//搜索按钮的点击事件
-(void)search{

}

//lable 的点击手势的执行事件
-(void)lableC:(UITapGestureRecognizer *)tapg{
    //通过手势来获得view
    UILabel *lab=(UILabel *)tapg.view;
    int i=(int)lab.tag-30;
    //制定scrollV滚动到某个位置
    CGPoint point=CGPointMake(i*kScreenWidth, 0);
    [scrollV setContentOffset:point animated:YES];
}


//1
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSUInteger index=scrollV.contentOffset.x/scrollV.frame.size.width;
    
    UILabel *lable=(UILabel *)scrollBV.subviews[index];

    CGFloat offsetx=lable.center.x-scrollBV.frame.size.width*0.5;
    CGFloat offectMax=scrollBV.contentSize.width-scrollBV.frame.size.width;
    if (offsetx<0) {
        offsetx=0;
    }else if(offsetx>offectMax){
        offsetx=offectMax;
    }
    CGPoint offset=CGPointMake(offsetx, scrollBV.contentOffset.y);
    [scrollBV setContentOffset:offset animated:NO];
//    [self selectViewController:index];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSUInteger index=scrollView.contentOffset.x/scrollView.frame.size.width;
    [self selectViewController:index];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSUInteger index=scrollView.contentOffset.x/scrollView.frame.size.width;
    UILabel *lable=(UILabel *)scrollBV.subviews[index];
    [UIView transitionWithView:line duration:0 options:2 animations:^{
        line.frame=CGRectMake((kScreenWidth/16-1)+index*(kScreenWidth/4-4), SP_Floatt(33), kScreenWidth/8-2, 2);
    } completion:^(BOOL finished) {
        
    }];

    CGFloat offsetx=lable.center.x-scrollBV.frame.size.width*0.5;
    CGFloat offectMax=scrollBV.contentSize.width-scrollBV.frame.size.width;
    if (offsetx<0) {
        offsetx=0;
    }else if(offsetx>offectMax){
        offsetx=offectMax;
    }
    CGPoint offset=CGPointMake(offsetx, scrollBV.contentOffset.y);
    [scrollBV setContentOffset:offset animated:NO];
    
//    [self selectViewController:index];
   
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
