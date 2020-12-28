//
//  HttpEngine.h
//  DrinkLink
//
//  Created by MaTeen on 14/12/13.
//  Copyright (c) 2014年 MaTeen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseHttpItem;

@interface HttpEngine : NSObject

//init with SingleTon
+ (instancetype)shareHttpEngine;

//execute http request with asynchronous
- (void)startConnectionWithRequestItem:(BaseHttpItem *)item;

//cancel http request
- (void)cancelHttpRequestWithItem:(BaseHttpItem *)item;

//cancel entire http request
- (void)cancelEntireHttpRequest;

//cancel the part of http request
- (void)cancelPartHttpRequestWithCalledName:(NSString *)calledName;

@end
