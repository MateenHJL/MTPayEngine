//
//  HttpUnknownStatusCode.m
//  MTTemplate
//
//  Created by Mateen on 2017/1/20.
//  Copyright © 2017年 Teen ma. All rights reserved.
//

#import "HttpUnknownStatusCode.h"

@implementation HttpUnknownStatusCode

- (instancetype)init
{
    if (self = [super init])
    {
        self.httpRequestStatusCode = 0;
    }
    return self;
}

- (void)updatedItemWithHttpItem:(BaseHttpItem *)item
{
    self.httpRequestStatusCodeDebugErrorMessage = @"本地错误拦截，服务端返回的statusCode是0";
    self.httpRequestStatusCodeErrorMessage      = @"未知通信错误。";
    [super updatedItemWithHttpItem:item];
}

@end
