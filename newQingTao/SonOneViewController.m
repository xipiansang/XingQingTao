//
//  SonOneViewController.m
//  newQingTao
//
//  Created by 刘中天 on 2016/12/12.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import "SonOneViewController.h"

@interface SonOneViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
{
    CGFloat superRect;
    
    CGFloat contentOffsetY;
    
    CGFloat oldContentOffsetY;
    
    CGFloat newContentOffsetY;
    
    UIView *superView;
}
@property (nonatomic,strong)UICollectionView *coll;
@end

@implementation SonOneViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addView];
    
}

-(void)addView{
    //创建一个layout布局类
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    //设置布局方向
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize=CGSizeMake((kScreenWidth-SP_Floatt(35))/3, SP_Floatt(176));
    
    _coll=[[UICollectionView alloc]initWithFrame:CGRectMake(0, -64, kScreenWidth,kScreenHeight) collectionViewLayout:flowLayout];
    _coll.bounces=NO;
    //设置代理
    _coll.delegate=self;
    _coll.dataSource=self;
    //注册cell
    _coll.alwaysBounceVertical=YES;
    [_coll registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    
    [self.view addSubview:_coll];
    superRect=164;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdent=@"cellID";
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellIdent forIndexPath:indexPath];
    UIImageView *imageV=[[UIImageView alloc ]initWithFrame:CGRectMake(0,0,(kScreenWidth-SP_Floatt(35))/3, SP_Floatt(176))];
    imageV.image=[UIImage imageNamed:@"shangpin"];
    
    UIImageView *imageVV=[[UIImageView alloc]initWithFrame:CGRectMake(SP_Floatt(7), SP_Floatt(5), SP_Floatt(90), SP_Floatt(112))];
    imageVV.backgroundColor=[UIColor redColor];
    [cell.contentView addSubview:imageV];
    [cell.contentView addSubview:imageVV];
    return cell;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    oldContentOffsetY = scrollView.contentOffset.y;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y<oldContentOffsetY) {
        NSLog(@"down");
        CGFloat f=oldContentOffsetY-scrollView.contentOffset.y;
        NSMutableDictionary *dic=[NSMutableDictionary dictionary];
        dic[@"num"]=@(f);
        if (superRect<=164) {
            [self routerEventWithName:@"向下滑动" userInfo:dic];
            superRect=superRect+f;
        }
    } else if (scrollView.contentOffset.y>oldContentOffsetY) {
        NSLog(@"up");
        CGFloat f=scrollView.contentOffset.y-oldContentOffsetY;
        NSMutableDictionary *dic=[NSMutableDictionary dictionary];
        dic[@"num"]=@(f);
        if (scrollView.contentOffset.y<50&&superRect>=114) {
            [self routerEventWithName:@"向上滑动" userInfo:dic];
            superRect=superRect-f;
        }
    }
    //这个地方判 断有点问题
    NSLog(@"%f",superRect);
    oldContentOffsetY=scrollView.contentOffset.y;
    
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
