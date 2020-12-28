//
//  PollingEventEngine.h
//  YouSuHuoPinPoint
//
//  Created by Teen Ma on 2018/1/14.
//  Copyright © 2018年 Teen Ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PollingEventConfigItem;

@interface PollingEventEngine : NSObject

//the pollEngine is executing or not.
@property (nonatomic, assign, getter=isExecute) BOOL execute;

//init with SingleTon
+ (instancetype)sharePollingEventEngine;

//start polling http request depend on the config item as you give.
- (void)startPollingEventActionWithPollingConfigItem:(PollingEventConfigItem *)item;

//stop the polling http request
- (void)stopPollingHttpRequest;

@end
