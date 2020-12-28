//
//  PollingEventEngine.m
//  YouSuHuoPinPoint
//
//  Created by Teen Ma on 2018/1/14.
//  Copyright © 2018年 Teen Ma. All rights reserved.
//

#import "PollingEventEngine.h"
#import "PollingEventConfigItem.h"

@interface PollingEventEngine ()
{
    NSTimer *timer;
}

@property (nonatomic, strong) PollingEventConfigItem *httpPollingConfigItem;
@property (nonatomic, assign) NSInteger             maxCount;
@property (nonatomic, assign) NSInteger             timerTimeCount;

@end

@implementation PollingEventEngine

- (instancetype)init
{
    if (self = [super init])
    {
        [self setupConfig];
    }
    return self;
}

- (void)setupConfig
{
    self.timerTimeCount = 0;
}

+ (instancetype)sharePollingEventEngine
{
    static dispatch_once_t onceToken;
    static PollingEventEngine *engine = nil;
    dispatch_once(&onceToken, ^{
        engine = [[PollingEventEngine alloc]init];
    });
    return engine;
}

- (void)pollingEventAction:(NSTimer *)timer
{
    if (self.timerTimeCount >= self.maxCount)
    {
        [self stopPollingHttpRequest];
        return;
    }
    self.timerTimeCount++;
    if (self.timerTimeCount % self.httpPollingConfigItem.pollingTimeCount == 0)
    {
        [NSThread detachNewThreadSelector:self.httpPollingConfigItem.actionEvent toTarget:self.httpPollingConfigItem.target withObject:nil];
    }
}

- (void)startPollingEventActionWithPollingConfigItem:(PollingEventConfigItem *)item
{
    self.httpPollingConfigItem = item;
    
    if (!timer)
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(pollingEventAction:) userInfo:nil repeats:YES];
    }
    [timer fire];
}

- (void)stopPollingHttpRequest
{
    self.timerTimeCount = 0;
    [timer invalidate];
    timer = nil;
}

- (NSInteger)maxCount
{
    _maxCount = NSIntegerMax;
    if (self.httpPollingConfigItem.repeatCount != 0)
    {
        _maxCount = self.httpPollingConfigItem.repeatCount * self.httpPollingConfigItem.pollingTimeCount;
    }
    return _maxCount;
}

- (BOOL)isExecute
{
    return [timer isValid];
}

- (void)dealloc
{
    
}

@end
