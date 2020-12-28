//
//  HttpLogicHandleManager.h
//  MTTemplate
//
//  Created by Mateen on 2017/1/16.
//  Copyright © 2017年 Teen ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseHttpItem;

@interface HttpLogicHandleManager : NSObject

//check your network can reachability.
+ (BOOL)networkCanBeReached;

//check your HttpUrl
+ (BOOL)isHttpUrlCorrectWithItem:(BaseHttpItem *)item;

//current response is mocking status
+ (BOOL)isMockResponseStatusWithItem:(BaseHttpItem *)item;
 
@end
