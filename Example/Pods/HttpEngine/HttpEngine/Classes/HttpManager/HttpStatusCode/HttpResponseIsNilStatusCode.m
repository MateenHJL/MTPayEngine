//
//  HttpResponseIsNilStatusCode.m
//  MTTemplate
//
//  Created by Mateen on 2016/12/10.
//  Copyright © 2016年 Teen ma. All rights reserved.
//

#import "HttpResponseIsNilStatusCode.h"

@implementation HttpResponseIsNilStatusCode

- (instancetype)init
{
    if (self = [super init])
    {
        self.httpRequestStatusCode = HTTPStatusCodeResponseDataIsNil;
    }
    return self;
}

- (void)updatedItemWithHttpItem:(BaseHttpItem *)item
{
    self.httpRequestStatusCodeDebugErrorMessage = @"服务端返回的数据是nil";
    self.httpRequestStatusCodeErrorMessage      = @"服务器出错，请联系客服";
    [super updatedItemWithHttpItem:item];
}

@end
