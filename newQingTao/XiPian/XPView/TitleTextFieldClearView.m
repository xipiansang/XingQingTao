//
//  TitleTextFieldClearView.m
//  newQingTao
//
//  Created by 刘中天 on 2016/12/8.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import "TitleTextFieldClearView.h"

@implementation TitleTextFieldClearView{
    NSString *ttitle;
    NSString *sstring;
    BOOL yyesOrNo;
    NSString *pll;
}

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title string:(NSString *)string pl:(NSString *)pl yesOrNo:(BOOL)yesOrNo{
    self=[super initWithFrame:frame];
    if (self) {
        ttitle=title;
        sstring=string;
        yyesOrNo=yesOrNo;
        pll=pl;
        [self addView];
    }
    return self;
}

-(void)addView{
    __weak typeof (self)weakSelf=self;
    _lable=[[UILabel alloc] init];
    _lable.text=ttitle;
    _lable.font=[UIFont systemFontOfSize:14];
    _lable.textColor=HEX_COLOR(@"888888");
    [weakSelf addSubview:_lable];
    [_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(SP_Floatt(18));
        make.centerY.height.equalTo(weakSelf);
        make.width.offset(SP_Floatt(67));
    }];
    
    if(yyesOrNo){
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"nc_delete_icon_nor"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"nc_delete_icon_sel"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor=[UIColor redColor];
        [weakSelf addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf).offset(SP_Floatt(-14));
            make.centerY.equalTo(weakSelf);
            make.size.mas_equalTo(CGSizeMake(SP_Floatt(24), SP_Floatt(24)));
        }];
    }
    
    
    _text=[[UITextField alloc] init];
    _text.text=sstring;
    _text.font=[UIFont systemFontOfSize:14];
    _text.placeholder=pll;
    _text.textColor=HEX_COLOR(@"cccccc");
    [weakSelf addSubview:_text];
    [_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lable.mas_right);
        make.centerY.height.equalTo(weakSelf);
        make.right.equalTo(weakSelf).offset(SP_Floatt(40));
    }];
    
}

-(void)clear{
    _text.text=nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
