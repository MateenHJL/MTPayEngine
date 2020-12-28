//
//  HttpRequestPostFileIsNilStatusCode.m
//  MTTemplate
//
//  Created by Mateen on 2017/1/10.
//  Copyright © 2017年 Teen ma. All rights reserved.
//

#import "HttpRequestPostFileIsNilStatusCode.h"

@implementation HttpRequestPostFileIsNilStatusCode

- (instancetype)init
{
    if (self = [super init])
    {
        self.httpRequestStatusCode = HTTPStatusCodePostFileIsNil;
    }
    return self;
}

- (void)updatedItemWithHttpItem:(BaseHttpItem *)item
{
    self.httpRequestStatusCodeDebugErrorMessage = @"上传的文件数据是空,请检查httpRequestPostFiles";
    self.httpRequestStatusCodeErrorMessage      = @"数据错误";
    [super updatedItemWithHttpItem:item];
}

@end
