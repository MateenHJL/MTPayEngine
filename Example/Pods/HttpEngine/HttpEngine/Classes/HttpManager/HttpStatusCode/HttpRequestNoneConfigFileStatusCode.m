//
//  HttpRequestNoneConfigFileStatusCode.m
//  Pods
//
//  Created by mateen on 2020/12/17.
//

#import "HttpRequestNoneConfigFileStatusCode.h"

@implementation HttpRequestNoneConfigFileStatusCode

- (instancetype)init
{
    if (self = [super init])
    {
        self.httpRequestStatusCode = HTTPStatusCodeNoConfigFile;
    }
    return self;
}

- (void)updatedItemWithHttpItem:(BaseHttpItem *)item
{
    self.httpRequestStatusCodeDebugErrorMessage = @"在app启动的时候，没有添加config文件";
    self.httpRequestStatusCodeErrorMessage      = @"系统出错，请联系管理员";
    [super updatedItemWithHttpItem:item];
}

@end
