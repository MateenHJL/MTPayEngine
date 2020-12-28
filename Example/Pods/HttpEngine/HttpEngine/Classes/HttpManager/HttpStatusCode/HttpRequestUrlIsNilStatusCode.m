//
//  HttpRequestUrlIsNilStatusCode.m
//  MTTemplate
//
//  Created by Mateen on 2016/12/10.
//  Copyright © 2016年 Teen ma. All rights reserved.
//

#import "HttpRequestUrlIsNilStatusCode.h"

@implementation HttpRequestUrlIsNilStatusCode

- (instancetype)init
{
    if (self = [super init])
    {
        self.httpRequestStatusCode = HTTPStatusCodeRequestUrlIsNilOrNotCorrect;
    }
    return self;
}

- (void)updatedItemWithHttpItem:(BaseHttpItem *)item
{
    self.httpRequestStatusCodeDebugErrorMessage = @"请求的url为空或者格式不正确";
    self.httpRequestStatusCodeErrorMessage      = @"请求数据错误";
    [super updatedItemWithHttpItem:item];
}

@end
