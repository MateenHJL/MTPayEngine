//
//  Http400StatusCode.m
//  MTTemplate
//
//  Created by Mateen on 2016/12/10.
//  Copyright © 2016年 Teen ma. All rights reserved.
//

#import "Http400StatusCode.h"

@implementation Http400StatusCode

- (instancetype)init
{
    if (self = [super init])
    {
        self.httpRequestStatusCode = 400;
    }
    return self;
}

- (void)updatedItemWithHttpItem:(BaseHttpItem *)item
{
    self.httpRequestStatusCodeDebugErrorMessage = @"服务器不理解请求的语法。";
    self.httpRequestStatusCodeErrorMessage      = @"通信错误";
    [super updatedItemWithHttpItem:item];
}

@end
