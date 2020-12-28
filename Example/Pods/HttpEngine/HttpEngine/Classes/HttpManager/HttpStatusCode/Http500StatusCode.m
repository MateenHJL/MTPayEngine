//
//  Http500StatusCode.m
//  MTTemplate
//
//  Created by Mateen on 2017/1/12.
//  Copyright © 2017年 Teen ma. All rights reserved.
//

#import "Http500StatusCode.h"

@implementation Http500StatusCode

- (instancetype)init
{
    if (self = [super init])
    {
        self.httpRequestStatusCode = 500;
    }
    return self;
}

- (void)updatedItemWithHttpItem:(BaseHttpItem *)item
{
    self.httpRequestStatusCodeDebugErrorMessage = @"服务端的问题，去找后台。";
    self.httpRequestStatusCodeErrorMessage      = @"服务器内部错误";
    [super updatedItemWithHttpItem:item];
}


@end
