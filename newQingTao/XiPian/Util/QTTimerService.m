
//
//  QTTimerService.m
//  QingTao
//
//  Created by yu on 16/5/7.
//  Copyright © 2016年 com.sunday-mobi. All rights reserved.
//

#import "QTTimerService.h"

@interface QTTimerService ()

@property (nonatomic, strong) NSTimer   *timer;

@end

@implementation QTTimerService

- (void)dealloc
{
    [self invalidateTimer];
}

- (instancetype)initWithEndTime:(NSString *)endTime countdown:(CountdownHandler)block
{
    self = [super init];
    if (self) {
        _endTime = endTime;
        self.block = block;
        [self createTimer];
    }
    return self;
}

- (void)createTimer
{
    if (_timer) {
        [self invalidateTimer];
    }
    
    if (_endTime.length <= 0) {
        return;
    }
    
    
    NSDate *endDate = [NSDate dateWithString:_endTime format:@"yyyy-MM-dd HH:mm:ss"];
    _remainingTime = [endDate timeIntervalSinceDate:[NSDate date]];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshTimer) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)setEndTime:(NSString *)endTime
{
    _endTime = endTime;
    [self createTimer];
}

- (void)refreshTimer
{
    _remainingTime -= 1;
    if (_block) {
        _block(self,_remainingTime);
    }
}

- (void)invalidateTimer
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - notification

- (void)didEnterBackground
{
    [self invalidateTimer];
}

- (void)didBecomeActive
{
    [self createTimer];
}

@end
