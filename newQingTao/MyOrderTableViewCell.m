//
//  MyOrderTableViewCell.m
//  XingQingTao
//
//  Created by 刘中天 on 2016/12/5.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import "MyOrderTableViewCell.h"

@implementation MyOrderTableViewCell{
    UICollectionView *collV;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
    NSArray *array=@[@"代付款",@"未发货",@"待收货",@"去评价",@"退换货"];
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SP_Floatt(64))];
    view.backgroundColor=[UIColor whiteColor];
    view.layer.shadowColor=[UIColor blackColor].CGColor;
    view.layer.shadowOffset=CGSizeMake(0, 2);
    view.layer.shadowOpacity=0.5;
    for (int i=0; i<5; i++) {
        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0+i*kScreenWidth/5, SP_Floatt(41), kScreenWidth/5, SP_Floatt(23))];
        lable.text=array[i];
        lable.font=[UIFont systemFontOfSize:11];
        lable.textColor=HEX_COLOR(@"333333");
        lable.textAlignment=NSTextAlignmentCenter;
        [view addSubview:lable];
        UIImageView *imageV=[[UIImageView alloc] init];
        imageV.image=[UIImage imageNamed:[NSString stringWithFormat: @"wd_%i_icon",i+1 ]];
        [view addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lable.mas_top).offset(SP_Floatt(-5));
            make.centerX.equalTo(lable);
            make.size.mas_equalTo(CGSizeMake(SP_Floatt(33), SP_Floatt(24)));
        }];
    }
    
    [self.contentView addSubview:view];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
