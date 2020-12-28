//
//  Http404StatusCode.m
//  MTTemplate
//
//  Created by Mateen on 2017/2/16.
//  Copyright © 2017年 Teen ma. All rights reserved.
//

#import "Http404StatusCode.h"

@implementation Http404StatusCode

- (instancetype)init
{
    if (self = [super init])
    {
        self.httpRequestStatusCode = 404;
    }
    return self;
}

- (void)updatedItemWithHttpItem:(BaseHttpItem *)item
{
    self.httpRequestStatusCodeDebugErrorMessage = @"API接口没找到，请找对应文档";
    self.httpRequestStatusCodeErrorMessage      = @"通信错误";
    [super updatedItemWithHttpItem:item];
}

@end
