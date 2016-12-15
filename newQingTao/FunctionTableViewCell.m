//
//  FunctionTableViewCell.m
//  newQingTao
//
//  Created by 刘中天 on 2016/12/6.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import "FunctionTableViewCell.h"

@implementation FunctionTableViewCell{
    UILabel *title;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
    NSArray *array=@[@"已绑定账号",@"检查更新",@"清理内存",@"我的爱好",@"账户安全",@"未实名认证"];
    for (int i=0; i<6; i++) {
        if (i<3) {
            UIImageView *imageV=[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/6-SP_Floatt(13)+i*kScreenWidth/3,SP_Floatt(25)  , SP_Floatt(26), SP_Floatt(21))];
            imageV.image=[UIImage imageNamed:[NSString stringWithFormat:@"sz_%i_icon",i+1]];
            [self.contentView addSubview:imageV];
            
            UILabel *string=[[UILabel alloc] initWithFrame:CGRectMake(0+i*kScreenWidth/3, SP_Floatt(55), kScreenWidth/3, SP_Floatt(11))];
            string.text=array[i];
            string.textAlignment=NSTextAlignmentCenter;
            string.font=[UIFont systemFontOfSize:12];
            string.textColor=HEX_COLOR(@"666666");
            [self.contentView addSubview:string];
            
            UILabel *string2=[[UILabel alloc] initWithFrame:CGRectMake(0+i*kScreenWidth/3, SP_Floatt(77), kScreenWidth/3, SP_Floatt(25))];
            string2.text=array[i];
            string2.font=[UIFont systemFontOfSize:14];
            string2.textColor=HEX_COLOR(@"333333");
            string2.textAlignment=NSTextAlignmentCenter;
            [self.contentView addSubview:string2];
        }else{
            UIImageView *imageV=[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/6-SP_Floatt(13)+(i-3)*kScreenWidth/3,SP_Floatt(25)+kScreenWidth/3+10  , SP_Floatt(26), SP_Floatt(21))];
            imageV.image=[UIImage imageNamed:[NSString stringWithFormat:@"sz_%i_icon",i+1]];
            [self.contentView addSubview:imageV];
            
            UILabel *string2=[[UILabel alloc] initWithFrame:CGRectMake(0+(i-3)*kScreenWidth/3, SP_Floatt(77)+kScreenWidth/3-10, kScreenWidth/3, SP_Floatt(25))];
            string2.text=array[i];
            string2.font=[UIFont systemFontOfSize:14];
            string2.textColor=HEX_COLOR(@"333333");
            string2.textAlignment=NSTextAlignmentCenter;
            [self.contentView addSubview:string2];

        }
    }
    
    for(int x=1;x<3;x++){
        UIView *line=[[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/3*x, 0, 2, SP_Floatt(240))];
        line.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:line];
    }
    UIView *line2=[[UIView alloc] initWithFrame:CGRectMake(0, SP_Floatt(120), kScreenWidth, 2)];
    line2.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:line2];
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
