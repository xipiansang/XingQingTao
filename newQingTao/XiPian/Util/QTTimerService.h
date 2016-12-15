//
//  QTTimerService.h
//  QingTao
//
//  Created by yu on 16/5/7.
//  Copyright © 2016年 com.sunday-mobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+Sunday.h"

@class QTTimerService;

typedef void(^CountdownHandler)(QTTimerService *timer, NSTimeInterval timeInterval);

@interface QTTimerService : NSObject

@property (nonatomic, strong) NSString  *endTime;

@property (nonatomic, assign) NSTimeInterval    remainingTime;

@property (nonatomic, copy)   CountdownHandler  block;

- (instancetype)initWithEndTime:(NSString *)endTime countdown:(CountdownHandler)block;

- (void)createTimer;
- (void)invalidateTimer;

@end
