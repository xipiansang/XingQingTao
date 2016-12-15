//
//  SettingsViewController.m
//  XingQingTao
//
//  Created by 刘中天 on 2016/12/5.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsTableViewCell.h"
#import "FunctionTableViewCell.h"
#import "ChangeNameViewController.h"
@interface SettingsViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *tableV;
    NSArray *array;
}

@end

@implementation SettingsViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"设置";
    array=@[@"昵称",@"更换手机",@"我的邮箱",@"收货地址"];
    self.view.backgroundColor=[UIColor whiteColor];
    tableV=[[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    tableV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tableV];
}

//返回组头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return SP_Floatt(73);
    }else{
        return 0.1;
    }
}

//返回组头
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] init];
    if (section==0) {
        view.frame=CGRectMake(0, 0, kScreenWidth, SP_Floatt(73));
        view.backgroundColor=[UIColor whiteColor];
        
        UILabel *lable=[[UILabel alloc] init];
        lable.text=@"头像";
        lable.textColor=HEX_COLOR(@"333333");
        lable.font=[UIFont systemFontOfSize:15];
        lable.textAlignment=NSTextAlignmentLeft;
        [view addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.left.equalTo(view).offset(SP_Floatt(18));
            make.height.equalTo(view);
            make.width.equalTo(view).offset(view.width/3);
        }];
        
        UIImageView *image=[[UIImageView alloc] init];
        image.image=[UIImage imageNamed:@"sz_next_icon"];
        [view addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.right.equalTo(view).offset(SP_Floatt(-18));
            make.size.mas_equalTo(CGSizeMake(SP_Floatt(9), SP_Floatt(18)));
        }];
        
        UIButton *imageV=[UIButton buttonWithType:UIButtonTypeCustom];
        imageV.layer.masksToBounds=YES;
        imageV.layer.cornerRadius=SP_Floatt(25);
        [imageV setImage:[UIImage imageNamed:@"sz_tx_icon"] forState:UIControlStateNormal];
        [imageV addTarget:self action:@selector(choosePhone) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.right.equalTo(image.mas_left).offset(SP_Floatt(-22));
            make.size.mas_equalTo(CGSizeMake(SP_Floatt(60), SP_Floatt(60)));
        }];
    }else{
        view=nil;
    }
    
    return view;
}

-(void)choosePhone{
    [SDImagePicekerManager chooseImageWithShowPickerVC:self maxImagesCount:1 allowEditing:YES complateBlock:^(NSArray *imageArray) {
        NSLog(@"%@",[imageArray firstObject]);
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return SP_Floatt(60);
    }else{
        return SP_Floatt(240);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 4;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellID=@"cellID";
        SettingsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[SettingsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.title=array[indexPath.row];
        return cell;
    }else{
        static NSString *cellID=@"cellID";
        FunctionTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[FunctionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==0) {
        ChangeNameViewController *changeN=[[ChangeNameViewController alloc] init];
        changeN.text=array[indexPath.row];
        [self.navigationController pushViewController:changeN animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
