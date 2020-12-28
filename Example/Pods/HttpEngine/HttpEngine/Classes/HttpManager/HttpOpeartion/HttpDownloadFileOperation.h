//
//  HttpDownloadFileOperation.h
//  MTTemplate
//
//  Created by Mateen on 2017/2/17.
//  Copyright © 2017年 Teen ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseHttpItem;

typedef void(^httpDownloadFileOpeartionFinishedBlock)(BaseHttpItem *item);

@interface HttpDownloadFileOperation : NSOperation

- (instancetype)initWithItem:(BaseHttpItem *)item requestFinishedWithBlock:(httpDownloadFileOpeartionFinishedBlock)block;

@property (nonatomic,readonly) NSString *operationIndentity;
@property (nonatomic,readonly) BaseHttpItem *item;

@end
