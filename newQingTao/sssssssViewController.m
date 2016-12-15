//
//  sssssssViewController.m
//  newQingTao
//
//  Created by 刘中天 on 2016/12/9.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import "sssssssViewController.h"
#import "SonOneViewController.h"
#import "SonTwoViewController.h"
@interface sssssssViewController ()
@property (nonatomic,strong)UIView *bgV;
@property (nonatomic,strong)UIScrollView *scroll;
@property (nonatomic,strong)UICollectionView *collect;
@property (nonatomic,assign)float historyY;
@property (nonatomic,assign)float xxxxxx;
@end

@implementation sssssssViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChild];
    [self addView];
}

-(void)addView{
    _bgV=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight+100)];
    _bgV.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_bgV];
    
    _scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 164, kScreenWidth, kScreenHeight)];
    _scroll.backgroundColor=[UIColor yellowColor];
    _scroll.contentSize=CGSizeMake(kScreenWidth*2,0 );
    _scroll.pagingEnabled=YES;
    _scroll.bounces=YES;
    [_bgV addSubview:_scroll];
    UIViewController *viewC=self.childViewControllers[0];
    [_scroll addSubview:viewC.view];
}

-(void)addChild{
    SonOneViewController *vc1=[[SonOneViewController alloc] init];
    SonTwoViewController *vc2=[[SonTwoViewController alloc] init];
    NSArray *array=@[vc1,vc2];
    for (int i=0; i<2; i++) {
        UIViewController *vc=array[i];
        vc.view.frame=CGRectMake(0+i*kScreenWidth, 0, kScreenWidth, kScreenHeight);
        [self addChildViewController:vc];
        [_scroll addSubview:vc.view];
    }
}

-(void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    NSString *f=[userInfo objectForKey:@"num"];
    CGFloat ff=[f floatValue];
    if ([eventName isEqualToString:@"向上滑动"]) {
        CGRect rect=CGRectMake(0, _scroll.frame.origin.y-ff, kScreenWidth, kScreenHeight);
        _scroll.frame=rect;
    }else if ([eventName isEqualToString:@"向下滑动"]) {
        CGRect rect=CGRectMake(0, _scroll.frame.origin.y+ff, kScreenWidth, kScreenHeight);
        _scroll.frame=rect;
    }
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
