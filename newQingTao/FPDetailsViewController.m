//
//  FPDetailsViewController.m
//  newQingTao
//
//  Created by 刘中天 on 2016/12/12.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import "FPDetailsViewController.h"
#import "SDCycleScrollView.h"
#import "FPWebViewController.h"
#import "PFMuseumViewController.h"
#import "PFEvaluateViewController.h"
#import "YBPopupMenu.h"

@interface FPDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,UIScrollViewDelegate,YBPopupMenuDelegate>
@property(nonatomic,strong)UIScrollView *scroll;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UIPageControl *page;
//产品名字
@property(nonatomic,strong)UILabel *productName;

//承接scrollview的视图
@property(nonatomic,strong)UIView *scrollVVV;
//透明头部
@property(nonatomic,strong)UIView *headView;
//判断是否跳转
@property(nonatomic,assign)BOOL yesOrN;
@property(nonatomic,assign)BOOL yesOrN2;

//
@property(nonatomic,assign)CGFloat oldContentOffsetY;

//顶部购物车
@property(nonatomic,strong)UIButton *carB;
@property(nonatomic,strong)UIButton *mored;
@end

@implementation FPDetailsViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    _yesOrN=NO;
    _yesOrN2=NO;
    [self addChild];
    
    [self makeUI];
    
    [self addScroll];
    
    [self addSJL];
    [self addNavB];
    
}

-(void)addNavB{
    WS(weakSelf);
    _headView=[[UIView alloc] initWithFrame:CGRectMake(0, -20, kScreenWidth, 84)];
    _headView.backgroundColor=RGBA_COLOR(255,255,255,0);
    UIButton *black=[UIButton buttonWithType:UIButtonTypeCustom];
    [black setImage:[UIImage imageNamed:@"sz_back_icon"] forState:UIControlStateNormal];
    [black addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:black];
    [black mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.headView).offset(-5);
        make.left.equalTo(weakSelf.headView).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 32));
    }];
    
    _mored=[UIButton buttonWithType:UIButtonTypeCustom];
    [_mored setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [_mored addTarget:self action:@selector(moredd) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:_mored];
    [_mored mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.headView).offset(-5);
        make.right.equalTo(weakSelf.headView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(40, 32));
    }];
//    UIButton
    _carB=[UIButton buttonWithType:UIButtonTypeCustom];
    [_carB setImage:[UIImage imageNamed:@"Cart"] forState:UIControlStateNormal];
    [_headView addSubview:_carB];
    [_carB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.headView).offset(-5);
        make.right.equalTo(weakSelf.mored.mas_left).offset(-10);
        make.size.mas_equalTo(CGSizeMake(40, 32));
    }];
    
    UIView *hong=[[UIView alloc] init];
    hong.backgroundColor=[UIColor redColor];
    hong.layer.masksToBounds=YES;
    hong.layer.cornerRadius=8;
    [_headView addSubview:hong];
    [hong mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.headView).offset(-62);
        make.bottom.equalTo(weakSelf.headView).offset(-20);
        make.size.mas_equalTo(CGSizeMake(17, 17));
    }];
    
    [self.view addSubview:_headView];
}

-(void)makeUI{
    
    
    _table=[[UITableView alloc] initWithFrame:CGRectMake(0, -20, kScreenWidth, kScreenHeight-SP_Floatt(33)+15) style:UITableViewStyleGrouped];
    _table.delegate=self;
    _table.dataSource=self;
    _table.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view  addSubview:_table];
    //添加头视图
    UIView *tableHeardV=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SP_Floatt(374))];
    
    NSArray *array=@[@"1",@"1",@"1"];
    NSMutableArray *photoA=[NSMutableArray array];
    for (NSString *str in array) {
        UIImage *image=[UIImage imageNamed:str];
        [photoA addObject:image];
    }
    //第三方轮播
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0, kScreenWidth, SP_Floatt(374))imageNamesGroup:photoA];
    cycleScrollView2.showPageControl=NO;
    cycleScrollView2.delegate=self;
    [tableHeardV addSubview:cycleScrollView2];
    
    //设置分页控件
    _page=[[UIPageControl alloc] initWithFrame:CGRectMake(0, SP_Floatt(374)-30, kScreenWidth, SP_Floatt(13))];
    _page.backgroundColor=[UIColor clearColor];
    _page.numberOfPages=3;
    _page.currentPage=0;
    _page.pageIndicatorTintColor=[UIColor whiteColor];
    _page.currentPageIndicatorTintColor=HEX_COLOR(@"aeb1c4");
    [tableHeardV addSubview:_page];
    _table.tableHeaderView=tableHeardV;
    
    //
    
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(goToDetailAnimation)];
    
    // 设置尾部
    _table.mj_footer = footer;
    
}

-(void)addScroll{
    NSArray *array=@[@"商品详情",@"商品评价",@"品牌馆"];
    _scrollVVV=[[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-SP_Floatt(33)+15, kScreenWidth, kScreenHeight-SP_Floatt(33)+15)];
    _scrollVVV.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_scrollVVV];
    for (int i=0; i<3; i++) {
        UIButton *lable=[UIButton buttonWithType:UIButtonTypeCustom];
        lable.frame=CGRectMake(kScreenWidth/3*i,0, kScreenWidth/3, SP_Floatt(45));
        lable.tag=400+i;
        [lable setTitle:array[i] forState:UIControlStateNormal];
        lable.titleLabel.font=[UIFont systemFontOfSize:15];
        [lable setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [lable addTarget:self action:@selector(qiehuan:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollVVV addSubview:lable];
    }
    
    _scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, SP_Floatt(45), kScreenWidth, kScreenHeight-SP_Floatt(130))];
//    _scroll.backgroundColor=[UIColor redColor];
    _scroll.contentSize=CGSizeMake(kScreenWidth*3, 0);
    _scroll.showsHorizontalScrollIndicator=NO;
    _scroll.bounces=NO;
    _scroll.pagingEnabled=YES;
    //禁止滑动
    _scroll.scrollEnabled=NO;
    _scroll.backgroundColor=[UIColor redColor];
    _scroll.delegate=self;
    [self.view addSubview:_scroll];
    [self addChild];
    UIViewController *viewC=self.childViewControllers[0];
    [_scroll addSubview:viewC.view];
    [_scrollVVV addSubview:_scroll];
}

-(void)addSJL{
    
    //添加购物车控件
    UIView *carBGV=[[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-SP_Floatt(33)-15, kScreenWidth, SP_Floatt(53))];
    carBGV.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:carBGV];
    
    
    //收藏
    UIButton *collectB=[UIButton buttonWithType:UIButtonTypeCustom];
    [collectB setImage:[UIImage imageNamed:@"shoucang2"] forState:UIControlStateNormal];
    collectB.layer.masksToBounds=YES;
    collectB.layer.borderWidth=1;
//    collectB.backgroundColor=[UIColor redColor];
    collectB.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
    [carBGV addSubview:collectB];
    [collectB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(carBGV);
        make.size.mas_equalTo(CGSizeMake(SP_Floatt(100), SP_Floatt(53)));
    }];
    
    //加入购物车
    UIButton *carB=[UIButton buttonWithType:UIButtonTypeCustom];
    [carB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [carB setImage:[UIImage imageNamed:@"jiarugwc"] forState:UIControlStateNormal];
//    carB.backgroundColor=[UIColor yellowColor];
    [carBGV addSubview:carB];
    
    
    UIButton *buyB=[UIButton buttonWithType:UIButtonTypeCustom];
    [buyB setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    [buyB setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buyB.backgroundColor=HEX_COLOR(@"fe4c56");
    [carBGV addSubview:buyB];
    [carB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(carBGV);
        make.left.equalTo(collectB.mas_right);
        make.right.equalTo(buyB.mas_left);
        make.width.equalTo(buyB);
    }];
    [buyB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(carBGV);
        make.left.equalTo(carB.mas_right);
        make.right.bottom.equalTo(carBGV);
        make.width.equalTo(carB);
    }];
}



- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section==0) {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SP_Floatt(320))];
        view.backgroundColor=[UIColor whiteColor];
        //分享按钮
        UIButton *shareB=[UIButton buttonWithType:UIButtonTypeCustom];
        [shareB setImage:[UIImage imageNamed:@"Share"] forState:UIControlStateNormal];
        [shareB addTarget:self action:@selector(shareB) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:shareB];
        [shareB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view).offset(SP_Floatt(13));
            make.right.equalTo(view).offset(SP_Floatt(-10));
            make.size.mas_equalTo(CGSizeMake(SP_Floatt(SP_Floatt(30)), SP_Floatt(30)));
        }];
        
        //分享文字
        UILabel *shareL=[[UILabel alloc] init];
        shareL.text=@"分享";
        shareL.font=[UIFont systemFontOfSize:12];
        shareL.textColor=HEX_COLOR(@"888888");
        [view addSubview:shareL];
        [shareL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(shareB.mas_bottom);
            make.right.equalTo(shareB);
            make.size.mas_equalTo(CGSizeMake(SP_Floatt(30), SP_Floatt(20)));
        }];
        
        //产品名字
        _productName = [[UILabel alloc] init];
        _productName.numberOfLines = 0;
        _productName.textAlignment=NSTextAlignmentLeft;
//        _productName.backgroundColor=[UIColor redColor];
        _productName.font=[UIFont systemFontOfSize:19];
        _productName.text = @"OWEN韩国代购日系zipper刺绣独角兽领口宽口T恤teeZF";
        [self setupEmojiAndLink];
        [view addSubview:_productName];
        
        //获取自定义的高度
        CGSize maximumLabelSize=CGSizeMake(SP_Floatt(kScreenWidth-65), 1000);
        CGSize expectSize = [_productName sizeThatFits:maximumLabelSize];
        
        [_productName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view).offset(SP_Floatt(13));
            make.left.equalTo(view).offset(SP_Floatt(10));
            make.height.offset(expectSize.height);
            make.width.offset(SP_Floatt(kScreenWidth-65));
        }];
        
        //金额
        UILabel *priceL=[[UILabel alloc] init];
        priceL.text=@"¥ 99999";
        priceL.font=[UIFont systemFontOfSize:24];
        priceL.textColor=HEX_COLOR(@"e31430");
        [view addSubview:priceL];
        [priceL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_productName.mas_bottom).offset(SP_Floatt(0));
            make.left.equalTo(_productName);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth/2, SP_Floatt(35)));
        }];
        
        UILabel *baoyou=[[UILabel alloc] init];
        baoyou.textColor=HEX_COLOR(@"888888");
        baoyou.font=[UIFont systemFontOfSize:12];
        baoyou.text=@"全场包邮";
        baoyou.textAlignment=NSTextAlignmentLeft;
        [view addSubview:baoyou];
        [baoyou mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(priceL.mas_bottom).offset(SP_Floatt(0));
            make.left.equalTo(priceL);
            make.size.mas_equalTo(CGSizeMake(SP_Floatt((kScreenWidth-20)/3), SP_Floatt(20)));
        }];
        
        //产地
        UILabel *chandi=[[UILabel alloc] init];
        chandi.textColor=HEX_COLOR(@"888888");
        chandi.font=[UIFont systemFontOfSize:12];
        chandi.text=@"柬埔寨";
        chandi.textAlignment=NSTextAlignmentRight;
        [view addSubview:chandi];
        [chandi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(baoyou);
            make.right.equalTo(view).offset(-10);
            make.size.mas_equalTo(CGSizeMake(SP_Floatt((kScreenWidth-20)/3), SP_Floatt(20)));
        }];
        
        //售出多少
        UILabel *shouchu=[[UILabel alloc] init];
        shouchu.textColor=HEX_COLOR(@"888888");
        shouchu.font=[UIFont systemFontOfSize:14];
        NSString *ccc=@"ccc";
        shouchu.text=[NSString stringWithFormat:@"已售%@笔",ccc];
        shouchu.textAlignment=NSTextAlignmentCenter;
        [view addSubview:shouchu];
        [shouchu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(baoyou);
            make.left.equalTo(baoyou.mas_right);
            make.right.equalTo(chandi.mas_left);
            make.height.offset(SP_Floatt(20));
        }];
        
        UIView *line=[[UIView alloc] init];
        line.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [view addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(shouchu.mas_bottom).offset(SP_Floatt(7));
            make.size.mas_equalTo(CGSizeMake(kScreenWidth,1));
        }];
        
        UIImageView *logo=[[UIImageView alloc] init];
        logo.image=[UIImage imageNamed:@"ZYXtouxiang"];
        logo.layer.masksToBounds=YES;
        logo.layer.cornerRadius=5;
        [view addSubview:logo];
        [logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom).offset(SP_Floatt(10));
            make.left.equalTo(view).offset(SP_Floatt(10));
            make.size.mas_equalTo(CGSizeMake(SP_Floatt(60), SP_Floatt(60)));
        }];
        
        UIImageView *logo2=[[UIImageView alloc] init];
        logo2.image=[UIImage imageNamed:@"ZYXtouxiang"];
        logo2.layer.masksToBounds=YES;
        logo2.layer.cornerRadius=5;
        [view addSubview:logo2];
        [logo2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(logo.mas_bottom);
            make.left.equalTo(logo.mas_right).offset(SP_Floatt(13));
            make.size.mas_equalTo(CGSizeMake(SP_Floatt(120), SP_Floatt(30)));
        }];
        
        UILabel *company=[[UILabel alloc] init];
        company.text=@"OWEN国际店";
        company.textAlignment=NSTextAlignmentLeft;
        company.font=[UIFont systemFontOfSize:16];
        company.textColor=HEX_COLOR(@"888888");
        [view addSubview:company];
        [company mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(logo);
            make.left.equalTo(logo2);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth/3, SP_Floatt(30)));
        }];
        
        //关注
        UIButton *concernB=[UIButton buttonWithType:UIButtonTypeCustom];
        [concernB setTitle:@"关注" forState:UIControlStateNormal];
        [concernB setImage:[UIImage imageNamed:@"guanzhu"] forState:UIControlStateNormal];
        [concernB setTitleColor:HEX_COLOR(@"fe4c56") forState:UIControlStateNormal];
        [view addSubview:concernB];
        [concernB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom).offset(SP_Floatt(33));
            make.right.equalTo(chandi);
            make.size.mas_equalTo(CGSizeMake(SP_Floatt(70), SP_Floatt(20)));
        }];
        
        //所有产品
        for (int i=0; i<3; i++) {
            UILabel *allProduct=[[UILabel alloc] init];
            allProduct.text=@"6201";
            allProduct.font=[UIFont systemFontOfSize:16];
            allProduct.textColor=HEX_COLOR(@"333333");
            allProduct.textAlignment=NSTextAlignmentCenter;
            [view addSubview:allProduct];
            UILabel *allProduct2=[[UILabel alloc] init];
            allProduct2.text=@"全部商品";
            allProduct2.font=[UIFont systemFontOfSize:15];
            allProduct2.textColor=HEX_COLOR(@"888888");
            allProduct2.textAlignment=NSTextAlignmentCenter;
            [view addSubview:allProduct2];
            [allProduct mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(logo.mas_bottom).offset(SP_Floatt(15));
                make.left.equalTo(view).offset(i*kScreenWidth/3);
                make.size.mas_equalTo(CGSizeMake(kScreenWidth/3, SP_Floatt(17)));
            }];
            [allProduct2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(allProduct.mas_bottom);
                make.left.equalTo(view).offset(i*kScreenWidth/3);
                make.size.mas_equalTo(CGSizeMake(kScreenWidth/3, SP_Floatt(17)));
            }];
        }
        
        for (int i=0; i<2; i++) {
            UIView *line2=[[UIView alloc] init];
            line2.backgroundColor=[UIColor groupTableViewBackgroundColor];
            [view addSubview:line2];
            [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(logo.mas_bottom).offset(SP_Floatt(11));
                make.left.equalTo(view).offset(kScreenWidth/3*(i+1)-1);
                make.size.mas_equalTo(CGSizeMake(SP_Floatt(2), SP_Floatt(32)));
            }];
        }
        //进馆
        UIButton *jinguan=[[UIButton alloc] init];
        [jinguan setTitle:@"进馆" forState:UIControlStateNormal];
        [jinguan setTitleColor:HEX_COLOR(@"fe4c56") forState:UIControlStateNormal];
        jinguan.titleLabel.font=[UIFont systemFontOfSize:14];
        jinguan.layer.masksToBounds=YES;
        jinguan.layer.cornerRadius=5;
        jinguan.layer.borderColor=HEX_COLOR(@"fe4c56").CGColor;
        jinguan.layer.borderWidth=1;
        [view addSubview:jinguan];
        [jinguan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(view).offset(SP_Floatt(-19));
            make.centerX.equalTo(view);
            make.size.mas_equalTo(CGSizeMake(SP_Floatt(76), SP_Floatt(28)));
        }];
            return view;
    }else if(section==1){
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SP_Floatt(138))];
        view.backgroundColor=[UIColor whiteColor];

        UILabel *pinpai=[[UILabel alloc] init];
        pinpai.text=@"品牌承诺";
        pinpai.font=[UIFont systemFontOfSize:17];
        pinpai.textColor=HEX_COLOR(@"fe4c56");
        pinpai.textAlignment=NSTextAlignmentCenter;
        [view addSubview:pinpai];
        [pinpai mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view).offset(SP_Floatt(17));
            make.left.equalTo(view);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, SP_Floatt(25)));
        }];
        
        NSArray *array=@[@"zheng",@"qitian",@"fahuo",@"guanjia"];
        NSArray *array2=@[@"正品保障",@"7天包退",@"48小时发货",@"星管家"];
        for (int i=0; i<4; i++) {
            UIImageView *imageV=[[UIImageView alloc] init];
            imageV.image=[UIImage imageNamed:array[i]];
            [view addSubview:imageV];
            [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(pinpai.mas_bottom).offset(SP_Floatt(14));
                make.left.equalTo(view).offset(SP_Floatt(40)+SP_Floatt(84)*i);
                make.size.mas_equalTo(CGSizeMake(SP_Floatt(44), SP_Floatt(44)));
            }];
            UILabel *lable=[[UILabel alloc] init];
            lable.text=array2[i];
            lable.font=[UIFont systemFontOfSize:14];
            lable.textColor=HEX_COLOR(@"888888");
            lable.textAlignment=NSTextAlignmentCenter;
            [view addSubview:lable];
            [lable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(imageV.mas_bottom).offset(SP_Floatt(8));
                make.centerX.equalTo(imageV);
                make.width.offset(kScreenWidth/4);
                make.bottom.equalTo(view).offset(SP_Floatt(-20));
            }];
            
        }
       
        return view;
    }else{
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SP_Floatt(146))];
        view.backgroundColor=[UIColor whiteColor];
        
        //评价条数
        UILabel *lable=[[UILabel alloc] init];
        NSString *string=@"999+";
        lable.textColor=HEX_COLOR(@"888888");
        lable.text=[NSString stringWithFormat:@"商品评价%@",string];
        lable.font=[UIFont systemFontOfSize:12];
        [view addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view).offset(SP_Floatt(10));
            make.left.equalTo(view).offset(SP_Floatt(10));
            make.size.mas_equalTo(CGSizeMake(kScreenWidth/2, SP_Floatt(20)));
        }];
   
        //头像
        UIImageView *image=[[UIImageView alloc] init];
        image.image=[UIImage imageNamed:@"ZYXtouxiang"];
        image.layer.masksToBounds=YES;
        image.layer.cornerRadius=SP_Floatt(23);
        [view addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lable);
            make.top.equalTo(lable.mas_bottom).offset(SP_Floatt(5));
            make.size.mas_equalTo(CGSizeMake(SP_Floatt(46), SP_Floatt(46)));
        }];

        //用户名
        UILabel *userName=[[UILabel alloc] init];
        userName.text=@"赵允熙";
        userName.font=[UIFont systemFontOfSize:12];
        userName.textColor=HEX_COLOR(@"333333");
        [view addSubview:userName];
        [userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(image);
            make.left.equalTo(image.mas_right).offset(SP_Floatt(20));
            make.size.mas_equalTo(CGSizeMake(kScreenWidth/4, SP_Floatt(20)));
        }];

        for (int i=0; i<5; i++) {
            UIImageView *star=[[UIImageView alloc] init];
            if (i<1) {
                star.image=[UIImage imageNamed:@"star2"];
            }else{
                star.image=[UIImage imageNamed:@"star1"];
            }
            [view addSubview:star];
            [star mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(SP_Floatt(20), SP_Floatt(20)));
                make.right.equalTo(view).offset(-SP_Floatt(15+i*SP_Floatt(20)));
                make.centerY.equalTo(userName);
            }];
        }
        
        //评价内容
        UILabel *good=[[UILabel alloc] init];
        good.text=@"YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮YX好漂亮";
        good.font=[UIFont systemFontOfSize:14];
        good.numberOfLines=2;
//        good.backgroundColor=[UIColor redColor];
        [view addSubview:good];
        [good mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(image.mas_bottom);
            make.right.equalTo(view).offset(SP_Floatt(-10));
            make.left.equalTo(view).offset(SP_Floatt(10));
            make.height.offset(50);
        }];
        
        //查看
        UIButton *jinguan=[[UIButton alloc] init];
        [jinguan setTitle:@"查看" forState:UIControlStateNormal];
        [jinguan setTitleColor:HEX_COLOR(@"fe4c56") forState:UIControlStateNormal];
        jinguan.titleLabel.font=[UIFont systemFontOfSize:SP_Floatt(14)];
        jinguan.layer.masksToBounds=YES;
        jinguan.layer.cornerRadius=5;
        jinguan.layer.borderColor=HEX_COLOR(@"fe4c56").CGColor;
        jinguan.layer.borderWidth=1;
        [view addSubview:jinguan];
        [jinguan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(view).offset(SP_Floatt(-10));
            make.centerX.equalTo(view);
            make.size.mas_equalTo(CGSizeMake(SP_Floatt(76), SP_Floatt(28)));
        }];
        
        //评论时间
        UILabel *time=[[UILabel alloc] init];
        time.text=@"161213";
        time.textColor=HEX_COLOR(@"888888");
        time.font=[UIFont systemFontOfSize:12];
        [view addSubview:time];
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(good.mas_bottom);
            make.left.equalTo(view).offset(SP_Floatt(10));
            make.size.mas_equalTo(CGSizeMake(kScreenWidth/2, SP_Floatt(20)));
        }];
        return view;
    }

}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)moredd{
    [YBPopupMenu showRelyOnView:_mored titles:@[@"1",@"3",@"4"] icons:@[@"ZYXtouxiang",@"ZYXtouxiang",@"ZYXtouxiang"] menuWidth:120 delegate:self];
}

- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{
    NSLog(@"点击了 %@ 选项",@[@"1",@"3",@"4"][index]);
}

/**
 *  向文本中添加表情等
 */
- (void)setupEmojiAndLink
{
//    NSMutableParagraphStyle *paraStyle02 = [[NSMutableParagraphStyle alloc] init];
//    paraStyle02.lineHeightMultiple = 2.5;
//    NSDictionary *attrDict02 = @{ NSParagraphStyleAttributeName: paraStyle02,
//                                  NSFontAttributeName: [UIFont systemFontOfSize: 12] };
//    _productName.attributedText = [[NSAttributedString alloc] initWithString: _productName.text attributes: attrDict02];
    NSMutableAttributedString * mutStr = [_productName.attributedText mutableCopy];
    //添加表情
        //创建一个图片
        UIImage * image1 =  [UIImage imageNamed:[NSString stringWithFormat:@"1"]];
        NSTextAttachment * attachment1 = [[NSTextAttachment alloc] init];
        attachment1.bounds = CGRectMake(0, -1, SP_Floatt(20), SP_Floatt(20));
        attachment1.image = image1;
        NSAttributedString * attachStr1 = [NSAttributedString attributedStringWithAttachment:attachment1];
        //最后一个参数为图片在证据话的位置下标。
        [mutStr insertAttributedString:attachStr1 atIndex:0];
    _productName.attributedText = [mutStr copy];
}

//页面内分享
-(void)shareB{
    
}

//三个界面的切换
-(void)qiehuan:(UIButton *)b{
    [_scroll setContentOffset:CGPointMake((b.tag-400)*kScreenWidth, 0) animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return SP_Floatt(320);
    }else if(section==1){
        return SP_Floatt(138);
    }else{
        return SP_Floatt(200);
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid=@"cellid";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    return cell;
}

//第三方轮播代理
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    _page.currentPage=(int)index;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _oldContentOffsetY = scrollView.contentOffset.y;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat f=_table.contentOffset.y;
    CGFloat alpha = MIN(1, 1 - ((20 + 64 - f) / 128));
    _headView.backgroundColor=RGBA_COLOR(255,255,255,alpha);
//    CGFloat valueNum = _table.contentSize.height -kScreenHeight+SP_Floatt(33)+20;
//    if (scrollView.contentOffset.y<_oldContentOffsetY){
//        _yesOrN2=NO;
//    }else if (scrollView.contentOffset.y>_oldContentOffsetY) {
//        _yesOrN2=YES;
//        if (scrollView.contentOffset.y>valueNum) {
//            if(_yesOrN){
//                [self goToDetailAnimation];
//            }
//        }
//    }
}



//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    if (_yesOrN2) {
//        _yesOrN=!_yesOrN;
//    }
//}

// 进入详情的动画
- (void)goToDetailAnimation
{
    [UIView animateWithDuration:0.8 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _scrollVVV.frame = CGRectMake(0, 44, kScreenWidth, kScreenHeight-SP_Floatt(33)+15);
        _table.frame = CGRectMake(0, -kScreenHeight-SP_Floatt(33)+15-20, kScreenWidth, kScreenHeight-SP_Floatt(33)+15);
        [_table.mj_footer endRefreshing];
    } completion:^(BOOL finished) {
        
    }];
}

//添加子视图
-(void)addChild{

    FPWebViewController *vc1=[[FPWebViewController alloc] init];
//    __block FPWebViewController *BlockSelf = self;
    // block方法实现
    vc1.returnTextBlock= ^()
    {
        [UIView animateWithDuration:0.8 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _table.frame = CGRectMake(0, -20, kScreenWidth, kScreenHeight-SP_Floatt(33)+15);
        _scrollVVV.frame = CGRectMake(0, kScreenHeight-SP_Floatt(33)+15, kScreenWidth, kScreenHeight-SP_Floatt(78));
//            _yesOrN2=NO;
//            _yesOrN=NO;
    } completion:^(BOOL finished) {
        
    }];
        
    };
    PFEvaluateViewController *vc2=[[PFEvaluateViewController alloc] init];
    PFMuseumViewController *vc3=[[PFMuseumViewController alloc] init];
    NSArray *array=@[vc1,vc2,vc3];
    for (int i=0; i<3; i++) {
        UIViewController *vc=array[i];
        vc.view.frame=CGRectMake(0+i*kScreenWidth, 0, kScreenWidth, kScreenHeight);
        [self addChildViewController:vc];
        [_scroll addSubview:vc.view];
    }
}
//选择加载那个子视图
-(void)selectViewController:(NSUInteger)index{
    UIViewController *vc=self.childViewControllers[index];
    //要注意加载的承接是哪个
    [_scroll addSubview:vc.view];
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
