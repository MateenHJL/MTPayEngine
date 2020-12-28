//
//  HttpRequestConnectedFailedStatusCode.m
//  MTTemplate
//
//  Created by Mateen on 2016/12/10.
//  Copyright © 2016年 Teen ma. All rights reserved.
//

#import "HttpRequestConnectedFailedStatusCode.h"

@implementation HttpRequestConnectedFailedStatusCode

- (instancetype)init
{
    if (self = [super init])
    {
        self.httpRequestStatusCode = HTTPStatusCodeConnectedFailed;
    }
    return self;
}

- (void)updatedItemWithHttpItem:(BaseHttpItem *)item
{
    self.httpRequestStatusCodeDebugErrorMessage = @"与服务器通信错误";
    self.httpRequestStatusCodeErrorMessage      = @"当前网络不给力，请检查网络";
    [super updatedItemWithHttpItem:item];
}

@end
