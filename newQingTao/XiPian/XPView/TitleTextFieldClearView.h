//
//  TitleTextFieldClearView.h
//  newQingTao
//
//  Created by 刘中天 on 2016/12/8.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleTextFieldClearView : UIView
@property(nonatomic,strong)UILabel *lable;
@property(nonatomic,strong)UITextField *text;
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title string:(NSString *)string pl:(NSString *)pl yesOrNo:(BOOL)yesOrNo;

@end
