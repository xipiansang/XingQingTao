//
//  XPTabBarViewController.h
//  newQingTao
//
//  Created by 刘中天 on 2016/12/7.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XPTabBarViewController : UITabBarController
-(instancetype)initWithArray:(NSArray *)array :(NSArray *)selectArray;
-(void)hidCBTabbar:(BOOL)ishid;
@end
