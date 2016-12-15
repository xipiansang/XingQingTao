//
//  SettingsTableViewCell.h
//  XingQingTao
//
//  Created by 刘中天 on 2016/12/5.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsTableViewCell : UITableViewCell
@property (nonatomic,strong)NSString *title;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
