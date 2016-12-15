//
//  FootstepsTableViewCell.m
//  XingQingTao
//
//  Created by 刘中天 on 2016/12/5.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import "FootstepsTableViewCell.h"

@implementation FootstepsTableViewCell

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
    UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SP_Floatt(143))];
    scrollView.contentSize=CGSizeMake(SP_Floatt(1130), SP_Floatt(143));
    scrollView.showsHorizontalScrollIndicator=NO;
    for (int i=0; i<12; i++) {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(SP_Floatt(7)+i*(SP_Floatt(91)), 0, SP_Floatt(84), SP_Floatt(143))];
        view.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [scrollView addSubview:view];
    }
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(SP_Floatt(7)+12*(SP_Floatt(91)), 0, SP_Floatt(25), SP_Floatt(143))];
    lable.text=@"木\n有\n了\n,\n加\n载\n完\n了";
    lable.numberOfLines=0;
    lable.textColor=HEX_COLOR(@"595d75");
    lable.font=[UIFont systemFontOfSize:12];
    lable.backgroundColor=[UIColor redColor];
    [scrollView addSubview:lable];
    [self.contentView addSubview:scrollView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
