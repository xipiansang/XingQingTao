//
//  FPWebViewController.h
//  newQingTao
//
//  Created by 刘中天 on 2016/12/15.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ReturnTextBlock)();
@interface FPWebViewController : UIViewController
@property (nonatomic, copy) ReturnTextBlock returnTextBlock;
@end
