//
//  BaseHttpStatusCode.h
//  MTTemplate
//
//  Created by Mateen on 2016/12/10.
//  Copyright © 2016年 Teen ma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "httpCommonFile.h"

@interface BaseHttpStatusCode : NSObject

@property (nonatomic,copy    ) NSString                 *httpRequestStatusCodeErrorMessage;
@property (nonatomic,copy    ) NSString                 *httpRequestStatusCodeDebugErrorMessage;
@property (nonatomic,assign  ) NSInteger                httpRequestStatusCode;

- (void)matchingWithStatusCode:(NSInteger)statusCode httpItem:(BaseHttpItem *)item;

- (void)updatedItemWithHttpItem:(BaseHttpItem *)item;

@end
