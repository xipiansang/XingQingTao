//
//  FlashPurchaseTableViewCell.m
//  newQingTao
//
//  Created by 刘中天 on 2016/12/6.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import "FlashPurchaseTableViewCell.h"
#import "FPDetailsViewController.h"


@implementation FlashPurchaseTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
    //创建一个layout布局类
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    //设置布局方向
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize=CGSizeMake((kScreenWidth-SP_Floatt(35))/3, SP_Floatt(176));
    
    _collect=[[UICollectionView alloc]initWithFrame:CGRectMake(SP_Floatt(10), 0, kScreenWidth-SP_Floatt(10), SP_Floatt(542)) collectionViewLayout:flowLayout];
    _collect.backgroundColor=[UIColor clearColor];
    _collect.scrollEnabled=NO;
    //设置代理
    _collect.delegate=self;
    _collect.dataSource=self;
    //注册cell
    [_collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    
    [self.contentView addSubview:_collect];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
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


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
