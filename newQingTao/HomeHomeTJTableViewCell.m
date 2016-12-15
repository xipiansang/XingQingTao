//
//  HomeHomeTJTableViewCell.m
//  newQingTao
//
//  Created by 刘中天 on 2016/12/7.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import "HomeHomeTJTableViewCell.h"

@implementation HomeHomeTJTableViewCell

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
    UIImageView *imageV=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SP_Floatt(205))];
    imageV.image=[UIImage imageNamed:@"tuijian2"];
    [self.contentView addSubview:imageV];
    for (int i=0; i<3; i++) {
        UIImageView *productImage=[[UIImageView alloc] initWithFrame:CGRectMake(SP_Floatt(8)+i*SP_Floatt(119), 0, SP_Floatt(110), SP_Floatt(110))];
//        productImage.image=[UIImage imageNamed:<#(nonnull NSString *)#>]
        productImage.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:productImage];
    }
    UILabel *commodityName=[[UILabel alloc] init];
    commodityName.text=@"这个是产品的名字巴拉巴拉巴拉巴拉巴拉巴拉";
    commodityName.textColor=HEX_COLOR(@"333333");
    commodityName.textAlignment=NSTextAlignmentLeft;
    commodityName.font=[UIFont systemFontOfSize:12];
    [self.contentView addSubview:commodityName];
    [commodityName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(SP_Floatt(-55));
        make.left.equalTo(self.contentView).offset(SP_Floatt(32));
        make.right.equalTo(self.contentView);
        make.height.offset(SP_Floatt(30));
    }];
    
    UILabel *price=[[UILabel alloc] init];
    price.text=[NSString stringWithFormat:@"¥10000"];
    price.textColor=HEX_COLOR(@"e31430");
    price.textAlignment=NSTextAlignmentLeft;
    price.font=[UIFont systemFontOfSize:16];
    [self.contentView addSubview:price];
    [price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(SP_Floatt(-30));
        make.left.equalTo(commodityName);
        make.height.offset(SP_Floatt(30));
        make.width.offset(SP_Floatt(100));
    }];
    
    UILabel *number=[[UILabel alloc] init];
    number.text=[NSString stringWithFormat:@"已售9999笔"];
    number.textColor=HEX_COLOR(@"c9c9c9");
    number.textAlignment=NSTextAlignmentLeft;
    number.font=[UIFont systemFontOfSize:11];
    [self.contentView addSubview:number];
    [number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-SP_Floatt(30));
        make.left.equalTo(price.mas_right);
        make.height.offset(SP_Floatt(25));
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
    [self.contentView addSubview:buy];
    [buy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(SP_Floatt(-15));
        make.bottom.equalTo(self.contentView).offset(SP_Floatt(-30));
        make.size.mas_equalTo(CGSizeMake(SP_Floatt(76), SP_Floatt(28)));
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
