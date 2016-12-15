//
//  FlashPurchaseTableViewCell.h
//  newQingTao
//
//  Created by 刘中天 on 2016/12/6.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^pushBlock1)(int i);
@interface FlashPurchaseTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,copy)pushBlock1 block;
@property (nonatomic,strong) UICollectionView *collect;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
