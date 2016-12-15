//
//  FPWebViewController.m
//  newQingTao
//
//  Created by 刘中天 on 2016/12/15.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import "FPWebViewController.h"
#import "MJRefresh.h"
@interface FPWebViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation FPWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addWebView];
}

-(void)addWebView{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-SP_Floatt(130))];
    _webView.delegate = self;
    _webView.scrollView.delegate =self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    [self.view addSubview:_webView];
    
    WS(weakself);
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if(weakself.returnTextBlock != nil){
            weakself.returnTextBlock();
        } // 返回基本详情界面的动画
        [_webView.scrollView.mj_header endRefreshing];

    }];
    [header setTitle:@"下拉返回宝贝详情" forState:MJRefreshStateIdle];
    [header setTitle:@"释放返回宝贝详情" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    _webView.scrollView.mj_header =header;

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
