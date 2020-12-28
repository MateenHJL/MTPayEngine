//
//  BaseHttpStatusCode.m
//  MTTemplate
//
//  Created by Mateen on 2016/12/10.
//  Copyright © 2016年 Teen ma. All rights reserved.
//

#import "BaseHttpStatusCode.h"

@implementation BaseHttpStatusCode

- (instancetype)init
{
    if (self = [super init])
    {
        self.httpRequestStatusCode = HTTPStatusCodeNoneError;
        self.httpRequestStatusCodeErrorMessage = @"";
        self.httpRequestStatusCodeDebugErrorMessage = @"";
    }
    return self;
}

- (void)matchingWithStatusCode:(NSInteger)statusCode httpItem:(BaseHttpItem *)item
{
    if (statusCode != self.httpRequestStatusCode)
    {
        item.httpRequestStatusCode = statusCode;
        return;
    }

    [self updatedItemWithHttpItem:item];
}

- (void)updatedItemWithHttpItem:(BaseHttpItem *)item
{    
    item.httpRequestStatusCode = self.httpRequestStatusCode;
    item.httpRequestDebugErrorMessage = self.httpRequestStatusCodeDebugErrorMessage;
    item.httpRequestErrorMessage = self.httpRequestStatusCodeErrorMessage;
}

@end
