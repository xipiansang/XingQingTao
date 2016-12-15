//
//  MyWordTableViewCell.m
//  XingQingTao
//
//  Created by 刘中天 on 2016/12/5.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import "MyWordTableViewCell.h"

@implementation MyWordTableViewCell

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
    NSArray *array=@[@"收藏关注",@"购物车",@"我的钱包",@"我要升级",@"轻淘店",@"星管家"];
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SP_Floatt(219))];
    view.backgroundColor=[UIColor whiteColor];
    view.layer.shadowColor=[UIColor blackColor].CGColor;
    view.layer.shadowOffset=CGSizeMake(0, 2);
    view.layer.shadowOpacity=0.5;
    for (int i=0; i<6; i++) {
        UILabel *lable=[[UILabel alloc] init];
        if(i<3){
            lable.frame=CGRectMake(0+i*kScreenWidth/3, SP_Floatt(63), kScreenWidth/3, SP_Floatt(27));
        }else{
            lable.frame=CGRectMake(0+(i-3)*kScreenWidth/3, SP_Floatt(173), kScreenWidth/3, SP_Floatt(27));
        }
        lable.text=array[i];
        lable.font=[UIFont systemFontOfSize:13];
        lable.textColor=HEX_COLOR(@"333333");
        lable.textAlignment=NSTextAlignmentCenter;
        [view addSubview:lable];
        UIImageView *imageV=[[UIImageView alloc] init];
        imageV.image=[UIImage imageNamed:[NSString stringWithFormat: @"wd_a%i_icon",i+1 ]];
        [view addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lable.mas_top).offset(SP_Floatt(-10));
            make.centerX.equalTo(lable);
            make.size.mas_equalTo(CGSizeMake(SP_Floatt(35), SP_Floatt(28)));
        }];
    }
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/3, 0, 1, SP_Floatt(220))];
    line.backgroundColor=HEX_COLOR(@"ececec");
    [view addSubview:line];
    UIView *line2=[[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/3*2, 0, 1, SP_Floatt(220))];
    line2.backgroundColor=HEX_COLOR(@"ececec");
    [view addSubview:line2];
    UIView *line3=[[UIView alloc] initWithFrame:CGRectMake(0,SP_Floatt(110),  kScreenWidth, 1)];
    line3.backgroundColor=HEX_COLOR(@"ececec");
    [view addSubview:line3];
    
    [self.contentView addSubview:view];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
