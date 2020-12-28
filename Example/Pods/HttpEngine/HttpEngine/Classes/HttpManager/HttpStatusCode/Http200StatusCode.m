//
//  Http200StatusCode.m
//  MTTemplate
//
//  Created by Mateen on 2016/12/10.
//  Copyright © 2016年 Teen ma. All rights reserved.
//

#import "Http200StatusCode.h"

@implementation Http200StatusCode

- (instancetype)init
{
    if (self = [super init])
    {
        self.httpRequestStatusCode = HTTPStatusCodeNoneError;
    }
    return self;
}

- (void)updatedItemWithHttpItem:(BaseHttpItem *)item
{
    self.httpRequestStatusCode = HTTPStatusCodeDetaultCode;
    self.httpRequestStatusCode = kHTTPStatusCodeNoneError;
    
    self.httpRequestStatusCodeDebugErrorMessage = @"通信成功";
    self.httpRequestStatusCodeErrorMessage      = @"";
    [super updatedItemWithHttpItem:item];
}

@end
