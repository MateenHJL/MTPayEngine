//
//  HttpUploadFileOperation.h
//  MTTemplate
//
//  Created by Mateen on 2017/1/20.
//  Copyright © 2017年 Teen ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseHttpItem;

typedef void(^httpUploadFileOpeartionFinishedBlock)(BaseHttpItem *item);

@interface HttpUploadFileOperation : NSOperation

- (instancetype)initWithItem:(BaseHttpItem *)item requestFinishedWithBlock:(httpUploadFileOpeartionFinishedBlock)block;

@property (nonatomic,readonly) NSString *operationIndentity;
@property (nonatomic,readonly) BaseHttpItem *item;

@end
