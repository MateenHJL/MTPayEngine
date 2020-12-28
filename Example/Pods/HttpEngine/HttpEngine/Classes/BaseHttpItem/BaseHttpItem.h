//
//  BaseHttpItem.h
//  DrinkLink
//
//  Created by MaTeen on 14/12/13.
//  Copyright (c) 2014年 MaTeen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpMacro.h"
#import "HttpSessionRequestConfig.h"

@class CommonLogicDataModel;

typedef void(^httpSuccessfulBlock)(id dataModel);
typedef void(^httpFailedBlock)(CommonLogicDataModel *dataModel);

@interface BaseHttpItem : NSObject
<HttpSessionUploadFileDataSource,
HttpSessionDataTaskDataSource,
HttpSessionDownloadFilesDataSource
>

@property (nonatomic,copy    ) NSString                                 *httpReqeustDomainUrl;
@property (nonatomic,readonly) NSString                                 *httpRequestAbsoluteUrlString;
@property (nonatomic,copy    ) NSString                                 *httpRequestUrl;
@property (nonatomic,strong  ) id                                       httpRequestResponseData;
@property (nonatomic,copy    ) NSString                                 *httpRequestErrorMessage;
@property (nonatomic,copy    ) NSString                                 *httpRequestDebugErrorMessage;
@property (nonatomic,readonly) NSString                                 *httpRequestCalledClassName;
@property (nonatomic,assign  ) HTTPStatusCode                           httpRequestStatusCode;
@property (nonatomic,assign  ) HTTPRequestStatus                        httpRequestStatus;
@property (nonatomic,copy    ) NSString                                 *httpRequestResponseDataJson;
@property (nonatomic,assign  ) HTTPRequestType                          httpRequestType;
@property (nonatomic,assign  ) HTTPResponseDataType                     httpResponseDataType;
@property (nonatomic,readonly) NSString                                 *httpRequestMethodString;
@property (nonatomic,assign  ) HTTPMethod                               httpRequestMethod;
@property (nonatomic,assign  ) NSInteger                                httpRequestTimeoutCount;
@property (nonatomic,assign,readonly) HTTPConnectionCompletedStatus     httpRequestConnectedStatus;
@property (nonatomic,assign,readonly) SEL                               httpItemCallBackSelector;
@property (nonatomic,assign  ) HTTPRepeatActionType                     httpRepeartActionType; 
@property (nonatomic,copy    ) NSString                                 *httpRequestPostParasString;

- (void)httpRequestCompletedExceptionWithItem:(BaseHttpItem *)item;

- (void)httpRequestCompletedWithItem:(BaseHttpItem *)item;

- (void)httpRequestFailedWitItem:(BaseHttpItem *)item;

- (void)cancelHttpRequest;

- (NSString *)descriptionItem;

- (NSString *)displayItemInformation;

@end
