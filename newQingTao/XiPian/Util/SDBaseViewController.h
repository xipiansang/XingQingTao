//
//  SDBaseViewController.h
//  QingTao
//
//  Created by yu on 16/4/9.
//  Copyright © 2016年 com.sunday-mobi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^callBackBlock)(id object);

@interface SDBaseViewController : UIViewController

@property (nonatomic, assign) NSInteger pageIndex;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) callBackBlock block;

- (void)callBackHandler:(callBackBlock)block;


@end
