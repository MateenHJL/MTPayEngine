//
//  HttpNoNetworkStatusCode.m
//  MTTemplate
//
//  Created by Mateen on 2016/12/10.
//  Copyright © 2016年 Teen ma. All rights reserved.
//

#import "HttpNoNetworkStatusCode.h"

@implementation HttpNoNetworkStatusCode

- (instancetype)init
{
    if (self = [super init])
    {
        self.httpRequestStatusCode = HTTPStatusCodeNoNetwork;
    }
    return self;
}

- (void)updatedItemWithHttpItem:(BaseHttpItem *)item
{
    self.httpRequestStatusCodeDebugErrorMessage = @"当前没网络";
    self.httpRequestStatusCodeErrorMessage      = @"网络异常";
    [super updatedItemWithHttpItem:item];
}

@end
