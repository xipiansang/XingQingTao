//
//  SettingsTableViewCell.m
//  XingQingTao
//
//  Created by 刘中天 on 2016/12/5.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import "SettingsTableViewCell.h"

@implementation SettingsTableViewCell{
    UIImageView *imageV;
    UILabel *lable;
    UILabel *text;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
    __weak typeof (self)weakSelf=self;
    lable=[[UILabel alloc] init];
    lable.textColor=HEX_COLOR(@"333333");
    lable.font=[UIFont systemFontOfSize:15];
    lable.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:lable];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.contentView).offset(SP_Floatt(18));
        make.height.equalTo(weakSelf.contentView);
        make.width.equalTo(weakSelf.contentView).offset(weakSelf.contentView.width/3);
    }];
    
    UIImageView *image=[[UIImageView alloc] init];
    image.image=[UIImage imageNamed:@"sz_next_icon"];
    [weakSelf.contentView addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.contentView).offset(SP_Floatt(-18));
        make.size.mas_equalTo(CGSizeMake(SP_Floatt(9), SP_Floatt(18)));
    }];
    
    text=[[UILabel alloc] init];
    text.textColor=HEX_COLOR(@"888888");
    text.font=[UIFont systemFontOfSize:14];
    text.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:text];
    [text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.right.equalTo(image.mas_left).offset(SP_Floatt(-22));
        make.height.equalTo(weakSelf.contentView);
        make.width.equalTo(weakSelf.contentView).offset(weakSelf.contentView.width/3);
    }];
}

-(void)setTitle:(NSString *)title{
    lable.text=title;
    text.text=title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
