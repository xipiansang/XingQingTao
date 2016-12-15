//
//  LikeTableViewCell.m
//  XingQingTao
//
//  Created by 刘中天 on 2016/12/5.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import "LikeTableViewCell.h"

@implementation LikeTableViewCell

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
    NSArray *array=@[@"限量闪购",@"爆款拼团",@"品牌直购",@"轻淘返现"];
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SP_Floatt(98))];
    view.backgroundColor=[UIColor whiteColor];
    view.layer.shadowColor=[UIColor blackColor].CGColor;
    view.layer.shadowOffset=CGSizeMake(0, 2);
    view.layer.shadowOpacity=0.5;
    for (int i=0; i<4; i++) {
        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0+i*kScreenWidth/4, SP_Floatt(65), kScreenWidth/4, SP_Floatt(23))];
        lable.text=array[i];
        lable.font=[UIFont systemFontOfSize:11];
        lable.textColor=HEX_COLOR(@"333333");
        lable.textAlignment=NSTextAlignmentCenter;
        [view addSubview:lable];
        UIImageView *imageV=[[UIImageView alloc] init];
        imageV.image=[UIImage imageNamed:[NSString stringWithFormat: @"wd_b%i_icon",i+1 ]];
        [view addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lable.mas_top).offset(SP_Floatt(-10));
            make.centerX.equalTo(lable);
            make.size.mas_equalTo(CGSizeMake(SP_Floatt(28), SP_Floatt(28)));
        }];
    }
    
    [self.contentView addSubview:view];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
