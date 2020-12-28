//
//  HttpRequestPostFileINameNilStatusCode.m
//  MTTemplate
//
//  Created by Mateen on 2017/1/10.
//  Copyright © 2017年 Teen ma. All rights reserved.
//

#import "HttpRequestPostFileINameNilStatusCode.h"

@implementation HttpRequestPostFileINameNilStatusCode

- (instancetype)init
{
    if (self = [super init])
    {
        self.httpRequestStatusCode = HTTPStatusCodePostFileKeyIsNull;
    }
    return self;
}

- (void)updatedItemWithHttpItem:(BaseHttpItem *)item
{
    self.httpRequestStatusCodeDebugErrorMessage = @"上传的文件数据对应的key是空,请检查httpRequestPostFileName";
    self.httpRequestStatusCodeErrorMessage      = @"数据错误";
    [super updatedItemWithHttpItem:item];
}

@end
