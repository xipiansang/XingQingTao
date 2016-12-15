//
//  QTAccount.h
//  QingTao_Manage
//
//  Created by 管振东 on 16/4/22.
//  Copyright © 2016年 guanzd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, QTAccountType) {
    QTAccountTypeSupplier = 3,
    QTAccountTypeAgent,
    QTAccountTypeDistributor,
};

@interface QTAccount : NSObject

+ (instancetype)sharedAccount;

+ (void)saveAccount:(NSDictionary *)responseObject;

+ (void)deleteAccount;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *roleIds;

@property (nonatomic, copy) NSString *postId;

@property (nonatomic, copy) NSString *orgId;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *updateTime;

@property (nonatomic, copy) NSString *sign;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *mobi;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *loginIp;

@property (nonatomic, copy) NSString *loginTime;

@property (nonatomic, assign) NSInteger sex;

@property (nonatomic, copy) NSString *birthday;

@property (nonatomic, copy) NSString *logo;

@property (nonatomic, copy) NSString *identityCard;

@property (nonatomic, copy) NSString *identityCardOne;

@property (nonatomic, copy) NSString *identityCardTwo;

@property (nonatomic, assign) BOOL isPay;
/** 1：超级管理员，2平台管理员  3：供货商  4：代理商 5：经销商   100：普通用户*/
@property (nonatomic, assign) QTAccountType type;

@property (nonatomic, copy) NSString *supplierId;

@property (nonatomic, copy) NSString *agentId;

@property (nonatomic, copy) NSString *recommendId;

@property (nonatomic, copy) NSString *fullPath;

@property (nonatomic, copy) NSString *districtId;

@property (nonatomic, assign) NSInteger maximumRecommend;

@property (nonatomic, copy) NSString *subShoNum;

@property (nonatomic, assign) NSInteger degree;

@property (nonatomic, copy) NSString *dueTime;

@end
