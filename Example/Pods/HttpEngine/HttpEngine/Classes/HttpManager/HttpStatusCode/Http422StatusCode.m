//
//  Http422StatusCode.m
//  MTTemplate
//
//  Created by Mateen on 2017/1/10.
//  Copyright © 2017年 Teen ma. All rights reserved.
//

#import "Http422StatusCode.h"

@implementation Http422StatusCode

- (instancetype)init
{
    if (self = [super init])
    {
        self.httpRequestStatusCode = 422;
    }
    return self;
}

- (void)updatedItemWithHttpItem:(BaseHttpItem *)item
{
    self.httpRequestStatusCodeDebugErrorMessage = @"客户端请求数据组织错误";
    self.httpRequestStatusCodeErrorMessage      = @"通信错误";
    [super updatedItemWithHttpItem:item];
}

@end
