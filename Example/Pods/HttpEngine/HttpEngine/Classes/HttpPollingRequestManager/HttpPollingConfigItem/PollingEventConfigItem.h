//
//  PollingEventConfigItem.h
//  YouSuHuoPinPoint
//
//  Created by Teen Ma on 2018/1/14.
//  Copyright © 2018年 Teen Ma. All rights reserved.
//

#import <Foundation/Foundation.h>
 
@class BaseHttpItem;

@interface PollingEventConfigItem : NSObject

//the count you polled depends on pollingTimeCount,you'd better set it less than the httpRequestTimeOutCount
@property (nonatomic, assign) NSInteger pollingTimeCount;

//it will be polling depends on the repeatCount,if you set it to zero.there will not stop unless you did stop it.
@property (nonatomic, assign) NSInteger repeatCount;

//the httpItem you wanna to polled.
@property (nonatomic, assign) SEL actionEvent;

//the action sender
@property (nonatomic, assign) id target;

@end
