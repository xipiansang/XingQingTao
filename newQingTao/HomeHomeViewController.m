//
//  HomeHomeViewController.m
//  XingQingTao
//
//  Created by 刘中天 on 2016/12/6.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import "HomeHomeViewController.h"
#import "SDCycleScrollView.h"
#import "HomeHomeTJTableViewCell.h"
#import "FlashPurchaseTableViewCell.h"
#import "QTTimerService.h"
#import "FPDetailsViewController.h"
@interface HomeHomeViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)UIPageControl *pageC;

//倒计时
@property(nonatomic,strong)UILabel *lableS;
@property(nonatomic,strong)UILabel *lableM;
@property(nonatomic,strong)UILabel *lableH;


@property(nonatomic,strong)UICollectionView *collectionV;
//时间定时器
@property(nonatomic,strong)QTTimerService *timerService;
@end

@implementation HomeHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getInfo];
    [self addView];
}

-(void)getInfo{
    WS(weakSelf);
    if(!_timerService){
        _timerService=[[QTTimerService alloc]initWithEndTime:@"2016-12-09 15:18:00" countdown:^(QTTimerService *timer, NSTimeInterval timeInterval) {
            [weakSelf updateTimeLable];
        }];
    }else{
        [_timerService setEndTime:@"2016-12-23 01:44:44"];
    }
}

-(void)updateTimeLable{
    if (_timerService.remainingTime<=0) {
        [_timerService invalidateTimer];
        [self routerEventWithName:@"定时器结束" userInfo:nil];
        return;
    }
    CGFloat remainingTime=_timerService.remainingTime;
    CGFloat hourLength=60*60;
    NSUInteger hour=(NSInteger)(remainingTime/hourLength);
    NSUInteger minutes=(NSInteger)((remainingTime-hour*hourLength)/60);
    NSUInteger seconds=(NSInteger)(remainingTime-hour*hourLength-minutes*60);
    _lableH.text=[NSString stringWithFormat:@"%02lu",(unsigned long)hour];
    _lableM.text=[NSString stringWithFormat:@"%02lu",(unsigned long)minutes];
    _lableS.text=[NSString stringWithFormat:@"%02lu",(unsigned long)seconds];
}

-(void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    if ([eventName isEqualToString:@"定时器结束"]) {
        NSLog(@"222222");
    }
}

-(void)addView{
    _tableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-SP_Floatt(131)) style:UITableViewStyleGrouped];
    _tableV.backgroundColor=[UIColor clearColor];
    _tableV.delegate=self;
    _tableV.dataSource=self;
    _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableV];
    
    //添加头视图
    UIView *tableHeardV=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SP_Floatt(191))];
    
    NSArray *array=@[@"1",@"1",@"1"];
    NSMutableArray *photoA=[NSMutableArray array];
    for (NSString *str in array) {
        UIImage *image=[UIImage imageNamed:str];
        [photoA addObject:image];
    }
    //第三方轮播
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(12,0, kScreenWidth-24, SP_Floatt(191))imageNamesGroup:photoA];
    cycleScrollView2.showPageControl=NO;
    cycleScrollView2.delegate=self;
    [tableHeardV addSubview:cycleScrollView2];
    
    //设置分页控件
    _pageC=[[UIPageControl alloc] initWithFrame:CGRectMake(0, SP_Floatt(191), kScreenWidth, SP_Floatt(13))];
    _pageC.backgroundColor=[UIColor clearColor];
    _pageC.numberOfPages=3;
    _pageC.currentPage=0;
    _pageC.pageIndicatorTintColor=[UIColor whiteColor];
    _pageC.currentPageIndicatorTintColor=HEX_COLOR(@"aeb1c4");
    [tableHeardV addSubview:_pageC];
    _tableV.tableHeaderView=tableHeardV;
}

//scrollview代理
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    _pageC.currentPage=(int)index;
}

//tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

//返回组头
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section==4){
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SP_Floatt(217))];
        view.backgroundColor=[UIColor clearColor];
        UILabel *qttj=[[UILabel alloc] init];
        qttj.text=@"轻淘推荐";
        qttj.textColor=HEX_COLOR(@"c9c9c9");
        qttj.font=[UIFont systemFontOfSize:12];
        qttj.textAlignment=NSTextAlignmentCenter;
        qttj.layer.masksToBounds=YES;
        qttj.layer.cornerRadius=5;
        qttj.layer.borderWidth=1;
        qttj.layer.borderColor=HEX_COLOR(@"c9c9c9").CGColor;
        [view addSubview:qttj];
        [qttj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view);
            make.centerX.equalTo(view);
            make.size.mas_equalTo(CGSizeMake(SP_Floatt(100), SP_Floatt(25)));
        }];
        
        UIView *line=[[UIView alloc] init];
        line.backgroundColor=HEX_COLOR(@"c9c9c9");
        [view addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view);
            make.size.mas_equalTo(CGSizeMake(SP_Floatt(100), 1));
            make.centerY.equalTo(qttj);
        }];
        
        UIView *line2=[[UIView alloc] init];
        line2.backgroundColor=HEX_COLOR(@"c9c9c9");
        [view addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view);
            make.size.mas_equalTo(CGSizeMake(SP_Floatt(100), 1));
            make.centerY.equalTo(qttj);
        }];
        
        UIImageView *image=[[UIImageView alloc] init];
        image.image=[UIImage imageNamed:@"tuijian1"];
        [view addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(qttj.mas_bottom);
            make.left.right.bottom.equalTo(view);
        }];
        
        UIImageView *picture=[[UIImageView alloc] init];
        picture.backgroundColor=[UIColor redColor];
        [view addSubview:picture];
        [picture mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(qttj.mas_bottom).offset(SP_Floatt(5));
            make.left.equalTo(view).offset(SP_Floatt(10));
            make.size.mas_equalTo(CGSizeMake(SP_Floatt(185), SP_Floatt(198)));
        }];
        
        UILabel *commodityName=[[UILabel alloc] init];
        commodityName.text=@"这个是产品的名字巴拉巴拉巴拉巴拉巴拉巴拉";
        commodityName.numberOfLines=2;
        commodityName.textColor=HEX_COLOR(@"333333");
        commodityName.textAlignment=NSTextAlignmentLeft;
        commodityName.font=[UIFont systemFontOfSize:12];
        [view addSubview:commodityName];
        [commodityName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(qttj.mas_bottom).offset(SP_Floatt(60));
            make.left.equalTo(picture.mas_right).offset(SP_Floatt(8));
            make.right.equalTo(view).offset(SP_Floatt(-10));
            make.height.offset(SP_Floatt(50));
        }];
        
        UILabel *price=[[UILabel alloc] init];
        price.text=[NSString stringWithFormat:@"¥10000"];
        price.textColor=HEX_COLOR(@"e31430");
        price.textAlignment=NSTextAlignmentLeft;
        price.font=[UIFont systemFontOfSize:16];
        [view addSubview:price];
        [price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(commodityName.mas_bottom);
            make.left.right.equalTo(commodityName);
            make.height.offset(SP_Floatt(20));
        }];
        
        UILabel *number=[[UILabel alloc] init];
        number.text=[NSString stringWithFormat:@"已售9999笔"];
        number.textColor=HEX_COLOR(@"c9c9c9");
        number.textAlignment=NSTextAlignmentLeft;
        number.font=[UIFont systemFontOfSize:11];
        [view addSubview:number];
        [number mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(price.mas_bottom);
            make.left.right.equalTo(commodityName);
            make.height.offset(SP_Floatt(35));
        }];
        
        UILabel *buy=[[UILabel alloc] init];
        buy.text=@"立即购买";
        buy.textColor=HEX_COLOR(@"f34c56");
        buy.font=[UIFont systemFontOfSize:12];
        buy.textAlignment=NSTextAlignmentCenter;
        buy.layer.masksToBounds=YES;
        buy.layer.cornerRadius=5;
        buy.layer.borderWidth=1;
        buy.layer.borderColor=HEX_COLOR(@"f34c56").CGColor;
        [view addSubview:buy];
        [buy mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view).offset(SP_Floatt(-15));
            make.top.equalTo(number.mas_bottom).offset(SP_Floatt(5));
            make.size.mas_equalTo(CGSizeMake(SP_Floatt(76), SP_Floatt(28)));
        }];
        return view;
    
    }else{
        NSArray *array=@[@"shangou",@"pintuan",@"zhigou",@"fanxian"];
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SP_Floatt(186))];
        UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SP_Floatt(186))];
        image.userInteractionEnabled=YES;
        image.image=[UIImage imageNamed:array[section]];
        [view addSubview:image];
        if (section==0) {
            _lableS=[[UILabel alloc] init];
            _lableS.textColor=HEX_COLOR(@"ffffff");
            _lableS.text=@"60";
            _lableS.textAlignment=NSTextAlignmentCenter;
            _lableS.font=[UIFont systemFontOfSize:SP_Floatt(21) weight:7];
            [view addSubview:_lableS];
            [_lableS mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(view).offset(SP_Floatt(-35));
                make.top.equalTo(view).offset(SP_Floatt(45));
                make.size.mas_equalTo(CGSizeMake(SP_Floatt(37), SP_Floatt(37)));
            }];
            _lableM=[[UILabel alloc] init];
            _lableM.textColor=HEX_COLOR(@"ffffff");
            _lableM.text=@"60";
            _lableM.textAlignment=NSTextAlignmentCenter;
            _lableM.font=[UIFont systemFontOfSize:SP_Floatt(21) weight:7];
            [view addSubview:_lableM];
            [_lableM mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(view).offset(SP_Floatt(-82));
                make.top.equalTo(view).offset(SP_Floatt(45));
                make.size.mas_equalTo(CGSizeMake(SP_Floatt(37), SP_Floatt(37)));
            }];
            _lableH=[[UILabel alloc] init];
            _lableH.textColor=HEX_COLOR(@"ffffff");
            _lableH.text=@"60";
            _lableH.textAlignment=NSTextAlignmentCenter;
            _lableH.font=[UIFont systemFontOfSize:SP_Floatt(21) weight:7];
            [view addSubview:_lableH];
            [_lableH mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(view).offset(SP_Floatt(-129));
                make.top.equalTo(view).offset(SP_Floatt(45));
                make.size.mas_equalTo(CGSizeMake(SP_Floatt(37), SP_Floatt(37)));
            }];
        }
        return view;
 
    }
}

//返回组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==4) {
        return SP_Floatt(271);
    }else{
        return SP_Floatt(186);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==4){
        return SP_Floatt(210);
    }else{
        return SP_Floatt(542);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section!=4){
        static NSString *cellID=@"cellID";
        FlashPurchaseTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[FlashPurchaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.backgroundColor=[UIColor clearColor];
        self.collectionV=cell.collect;
        self.collectionV.tag=indexPath.section+300;
        self.collectionV.delegate=self;
        return cell;
    }else{
        static NSString *cellID2=@"cellID2";
        HomeHomeTJTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID2];
        if (cell==nil) {
            cell=[[HomeHomeTJTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
        }
        cell.backgroundColor=[UIColor clearColor];
        return cell;

    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FPDetailsViewController *vc=[[FPDetailsViewController alloc] init];
    NSIndexPath *indd=[NSIndexPath indexPathForItem:indexPath.row inSection:collectionView.tag-300];
    vc.indexP=indd;
    [self.navigationController pushViewController:
     vc animated:YES];
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    XPTabBarViewController * ct =(XPTabBarViewController *) window.rootViewController;
    [ct hidCBTabbar:YES];
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
