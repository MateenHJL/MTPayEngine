//
//  HttpRequestQueue.h
//  MTTemplate
//
//  Created by Teen Ma on 16/8/24.
//  Copyright © 2016年 Teen Ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseHttpItem;

typedef void(^httpRequestOperationFinishedBlock)(BaseHttpItem *item);

@interface HttpRequestOperation : NSOperation

- (instancetype)initWithItem:(BaseHttpItem *)item requestFinishedWithBlock:(httpRequestOperationFinishedBlock)block;

@property (nonatomic,readonly) BaseHttpItem       *item;
@property (nonatomic,readonly) NSString           *operationIndentity;

@end
