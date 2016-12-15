//
//  QTAccount.m
//  QingTao_Manage
//
//  Created by 管振东 on 16/4/22.
//  Copyright © 2016年 guanzd. All rights reserved.
//

#import "QTAccount.h"

#define accountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

static QTAccount *_account = nil;

@implementation QTAccount

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID" : @"id", @"email" : @"enamil"};
}

+ (instancetype)sharedAccount {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:accountPath];
    });
    return _account;
}

+ (void)saveAccount:(NSDictionary *)responseObject {
    
    QTAccount *account = [QTAccount mj_objectWithKeyValues:responseObject[@"result"]];
    _account = account;
    [NSKeyedArchiver archiveRootObject:account toFile:accountPath];
}

+ (void)deleteAccount {
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if ([fileMgr fileExistsAtPath:accountPath]) {
        NSError *error;
        [fileMgr removeItemAtPath:accountPath error:&error];
        if (!error) {
            _account = nil;
        }
    }
}

MJExtensionCodingImplementation

@end
