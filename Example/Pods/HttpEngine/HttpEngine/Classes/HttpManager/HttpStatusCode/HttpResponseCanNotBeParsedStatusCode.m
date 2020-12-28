//
//  HttpResponseCanNotBeParsedStatusCode.m
//  MTTemplate
//
//  Created by Mateen on 2016/12/10.
//  Copyright © 2016年 Teen ma. All rights reserved.
//

#import "HttpResponseCanNotBeParsedStatusCode.h"

@implementation HttpResponseCanNotBeParsedStatusCode

- (instancetype)init
{
    if (self = [super init])
    {
        self.httpRequestStatusCode = HTTPStatusCodeParseError;
    }
    return self;
}

- (void)updatedItemWithHttpItem:(BaseHttpItem *)item
{
    self.httpRequestStatusCodeDebugErrorMessage = @"服务端返回的数据非json数据，无法解析";
    self.httpRequestStatusCodeErrorMessage      = @"服务器出错，请联系客服";
    [super updatedItemWithHttpItem:item];
}

@end
