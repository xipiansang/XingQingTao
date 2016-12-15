//
//  MyViewController.m
//  XingQingTao
//
//  Created by 刘中天 on 2016/12/3.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import "MyViewController.h"
#import "MyOrderTableViewCell.h"
#import "MyWordTableViewCell.h"
#import "LikeTableViewCell.h"
#import "FootstepsTableViewCell.h"
#import "SettingsViewController.h"
#import "sssssssViewController.h"


@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *userImageV;
@property(nonatomic,strong)UILabel *userName;
@end

@implementation MyViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加整体的tableview
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-SP_Floatt(30)) style:UITableViewStyleGrouped];
    //设置代理
    _tableView.delegate=self;
    _tableView.dataSource=self;
//    _tableView.backgroundColor=[UIColor redColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    //隐藏垂直滑块
    _tableView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_tableView];
    
    WS(weakSelf);
    //添加头视图
    UIView *heardView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SP_Floatt(205))];
    UIImageView *myBg=[[UIImageView alloc] init];
    myBg.image=[UIImage imageNamed:@"沙发(1)"];
    [heardView addSubview:myBg];
    [myBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(heardView);
    }];
    
    UIButton *sz=[UIButton buttonWithType:UIButtonTypeCustom];
    [sz setImage:[UIImage imageNamed:@"wd_sz_icon_nor"] forState:UIControlStateNormal];
    [sz addTarget:self action:@selector(sz) forControlEvents:UIControlEventTouchUpInside];
    [heardView addSubview:sz];
    [sz mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(heardView).offset(SP_Floatt(30));
        make.right.equalTo(heardView).offset(-SP_Floatt(20));
        make.size.mas_equalTo(CGSizeMake(SP_Floatt(25), SP_Floatt(25)));
    }];
    
    _userImageV=[UIButton buttonWithType:UIButtonTypeCustom];
    //设置头像的圆角和弧度
    _userImageV.layer.masksToBounds=YES;
    _userImageV.layer.cornerRadius=SP_Floatt(30);
    [_userImageV setImage:[UIImage imageNamed:@"wd_tx_icon_"] forState:UIControlStateNormal];
    [heardView addSubview:_userImageV];
    [_userImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(heardView).offset(SP_Floatt(60));
        make.size.mas_equalTo(CGSizeMake(SP_Floatt(60), SP_Floatt(60)));
        make.centerX.equalTo(heardView);
    }];
    
    
    //设置用户名
    _userName=[[UILabel alloc] init];
    _userName.textColor=[UIColor whiteColor];
    _userName.text=@"西片桑";
    _userName.textAlignment=NSTextAlignmentCenter;
    _userName.font=[UIFont systemFontOfSize:14];
    [heardView addSubview:_userName];
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.userImageV.mas_bottom).offset(SP_Floatt(20));
        make.centerX.equalTo(heardView);
        make.width.equalTo(heardView);
        make.height.offset(SP_Floatt(15));
    }];
    
    UIView *wdBlackBG=[[UIView alloc] init];
    wdBlackBG.backgroundColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.3];
    [heardView addSubview:wdBlackBG];
    [wdBlackBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(SP_Floatt(40));
        make.right.left.bottom.equalTo(heardView);
    }];
    
    //添加积分、淘粉、招兵送码
    NSArray *array=@[@"积分:200",@"星粉:90",@"招兵送码"];
    for (int i=0; i<3; i++) {
        UIButton *buttonB=[UIButton buttonWithType:UIButtonTypeCustom];
        buttonB.frame=CGRectMake(0+kScreenWidth/3*i, 0, kScreenWidth/3, SP_Floatt(40));
        buttonB.titleLabel.font=[UIFont systemFontOfSize:12];
        [buttonB setTitle:array[i] forState:UIControlStateNormal];
        [buttonB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        if (i!=2) {
            UIView *lineV=[[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/3*(i+1), SP_Floatt(12), 1, SP_Floatt(16))];
            lineV.backgroundColor=[UIColor whiteColor];
            [wdBlackBG addSubview:lineV];
        }
        
        [wdBlackBG addSubview:buttonB];
    }
    
    //添加尾视图
//    UILabel *footL=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SP_Floatt(75))];
//    footL.backgroundColor=[UIColor whiteColor];
//    footL.text=@"木有了,加载完了";
//    footL.textColor=HEX_COLOR(@"595d75");
//    footL.font=[UIFont systemFontOfSize:14];
//    footL.textAlignment=NSTextAlignmentCenter;
    
//    _tableView.tableFooterView=[UIView new];
    _tableView.tableHeaderView=heardView;
}

//跳转至设置界面
-(void)sz{
//    SettingsViewController *vc=[[SettingsViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];

    sssssssViewController *vc=[[sssssssViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES ];
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    XPTabBarViewController * ct =(XPTabBarViewController *) window.rootViewController;
    [ct hidCBTabbar:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return SP_Floatt(43);
    }else{
        return SP_Floatt(55);
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *array=@[@"我的订单",@"我的世界",@"您可能喜欢的",@"浏览足迹"];
    UIView *view=[[UIView alloc] init];
    view.backgroundColor=[UIColor whiteColor];
    //根据不同的section加载不同的组头
    if (section==0) {
        view.frame=CGRectMake(0, 0, kScreenWidth, SP_Floatt(43));
        UIImageView *imageV=[[UIImageView alloc] init];
        imageV.image=[UIImage imageNamed:@"wd_RIGHT_icon"];
        [view addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view).offset(SP_Floatt(-10));
            make.centerY.equalTo(view);
            make.size.mas_equalTo(CGSizeMake(SP_Floatt(10), SP_Floatt(15)));
        }];
        UILabel *lable2=[[UILabel alloc] init];
        lable2.text=@"查看全部订单";
        lable2.font=[UIFont systemFontOfSize:12];
        lable2.textColor=HEX_COLOR(@"9c9c9c");
        lable2.textAlignment=NSTextAlignmentRight;
        [view addSubview:lable2];
        [lable2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(imageV.mas_left).offset(-4);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth/3, view.bounds.size.height));
        }];
        UILabel *lableV=[[UILabel alloc] init];
        lableV.text=array[section];
        lableV.textColor=HEX_COLOR(@"595d75");
        lableV.font=[UIFont systemFontOfSize:14];
        lableV.textAlignment=NSTextAlignmentLeft;
        [view addSubview:lableV];
        [lableV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(SP_Floatt(15));
            make.size.mas_equalTo(CGSizeMake(kScreenWidth/3, view.bounds.size.height));
            //            make.size.mas_equalTo(CGSizeMake(kScreenWidth/3, view.bounds.size.height-SP_Floatt(10)));
            //            make.top.equalTo(vieww.mas_bottom);
        }];

    }else{
        view.frame=CGRectMake(0, 0, kScreenWidth, SP_Floatt(55));
//        //添加阴影
//        UIView *vieww=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenHeight, SP_Floatt(10))];
//        vieww.backgroundColor=HEX_COLOR(@"f0f0f0");
//        [view addSubview:vieww];
        UILabel *lableV=[[UILabel alloc] init];
        lableV.text=array[section];
        lableV.textColor=HEX_COLOR(@"595d75");
        lableV.font=[UIFont systemFontOfSize:14];
        lableV.textAlignment=NSTextAlignmentLeft;
        [view addSubview:lableV];
        [lableV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(SP_Floatt(15));
            make.size.mas_equalTo(CGSizeMake(kScreenWidth/3, view.bounds.size.height));
//            make.size.mas_equalTo(CGSizeMake(kScreenWidth/3, view.bounds.size.height-SP_Floatt(10)));
//            make.top.equalTo(vieww.mas_bottom);
        }];
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return SP_Floatt(65);
    }else if(indexPath.section==1){
        return SP_Floatt(220);
    }else if(indexPath.section==2){
        return SP_Floatt(98);
    }else{
        return SP_Floatt(144);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * const cellID = @"cellID";
    if (indexPath.section==0) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID ];
        cell=[[MyOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        return cell;
    }else if(indexPath.section==2){
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID ];
        cell=[[LikeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        return cell;
    }else if(indexPath.section==3){
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID ];
        cell=[[FootstepsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        return cell;
    }else{
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID ];
        cell=[[MyWordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        return cell;
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
