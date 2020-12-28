//
//  Http401StatusCode.m
//  MTTemplate
//
//  Created by Mateen on 2016/12/10.
//  Copyright © 2016年 Teen ma. All rights reserved.
//

#import "Http401StatusCode.h"

@implementation Http401StatusCode

- (instancetype)init
{
    if (self = [super init])
    {
        self.httpRequestStatusCode = 401;
    }
    return self;
}

- (void)updatedItemWithHttpItem:(BaseHttpItem *)item
{
    self.httpRequestStatusCodeDebugErrorMessage = @"请求要求身份验证。 对于需要登录的网页，服务器可能返回此响应。";
    self.httpRequestStatusCodeErrorMessage      = @"通信错误";
    [super updatedItemWithHttpItem:item];
}

@end
