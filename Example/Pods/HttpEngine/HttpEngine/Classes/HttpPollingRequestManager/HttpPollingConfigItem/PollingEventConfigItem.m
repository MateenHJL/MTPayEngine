//
//  PollingEventConfigItem.m
//  YouSuHuoPinPoint
//
//  Created by Teen Ma on 2018/1/14.
//  Copyright © 2018年 Teen Ma. All rights reserved.
//

#import "PollingEventConfigItem.h"

#define kHttpPollingTimeCount 20

@implementation PollingEventConfigItem

- (instancetype)init
{
    if (self = [super init])
    {
        self.pollingTimeCount = kHttpPollingTimeCount;
        self.repeatCount = 0;
    }
    return self;
}

@end
