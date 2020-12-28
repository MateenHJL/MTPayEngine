//
//  HttpSessionRequestConfig.h
//  MTTemplate
//
//  Created by Mateen on 2017/1/16.
//  Copyright © 2017年 Teen ma. All rights reserved.
//
#import "HttpMacro.h" 
#import <Foundation/Foundation.h>
//#import <CoreGraphics/CGBase.h>

@class BaseHttpItem;

//http request protocol
@protocol HttpSessionDataTaskDataSource <NSObject>

@property (nonatomic,strong  ) NSMutableDictionary      *httpRequestHeaderParams;
@property (nonatomic,strong  ) NSMutableDictionary      *httpRequestPostParams; 
@property (nonatomic,assign  ) HTTPCacheType            httpRequestCacheType;
@property (nonatomic,readonly) NSString                 *httpRequestCacheMark;
@property (nonatomic,strong  ) NSMutableArray           *httpRequestAcceptableContentTypes;
@property (nonatomic,assign  ) BOOL                     httpResponseIsMockStatus;
@property (nonatomic,assign  ) BOOL                     httpReuqestShouldAddSelfToLog;

@optional
- (void)httpRequestDownloadProgressValueWithItem:(BaseHttpItem *)item;

- (NSString *)mocksJsonData;

@end

//upload files protocol
@protocol HttpSessionUploadFileDataSource <NSObject>

@property (nonatomic,strong  ) NSMutableDictionary      *httpUploadFileAttactParams;
@property (nonatomic,copy    ) NSString                 *httpRequestPostFileName;
@property (nonatomic,readonly) NSString                 *httpRequestUploadPercent;
@property (nonatomic,copy    ) NSString                   *httpRequestPostFiles;
@property (nonatomic,assign  ) CGFloat                  httpRequestUploadTotalDataCount;
@property (nonatomic,assign  ) CGFloat                  httpRequestUploadAlreadySendDataCount;

@optional
- (void)httpRequestUploadProgressValueWithItem:(BaseHttpItem *)item;

@end

//download files protocol
@protocol HttpSessionDownloadFilesDataSource <NSObject>

@property (nonatomic,readonly) NSString                 *httpRequestDownloadPercent;
@property (nonatomic,strong  ) NSData                   *httpRequestDownloadFiles;
@property (nonatomic,assign  ) CGFloat                  httpRequestDownloadTotalDataCount;
@property (nonatomic,assign  ) CGFloat                  httpRequestDownloadAlreadyReceivedDataCount;

@end


//config of HttpItem.it's related with BaseHttpItem
@protocol HttpConfigDataSource <NSObject>

@required

//Show BaseUrl depends on what's item's httprequestUrl is.
- (NSString *)configBaseHttpUrlWithHttpItem:(BaseHttpItem *)item;

//All Header about httpRequest
- (NSMutableDictionary *)headerRequestDictionary;

//http connect time-out count
- (NSInteger)httpRequestTimeoutCount;

//http content-type
- (NSMutableArray *)httpRequestAcceptableContentTypes;

//http postParams data
- (NSString *)httpRequestPostParamsWithHttpItem:(BaseHttpItem *)item;

//http mark code
- (NSString *)httpMarkCodeWithHttpItem:(BaseHttpItem *)item;

//http mark code result
- (NSInteger)httpMarkCodeResultWithHttpItem:(BaseHttpItem *)item;

//http collection mark
- (NSString *)httpLogCollectionMark;

//parse responseData from server ,return YES if the code or result is whatever you want , or No
- (HTTPRequestResultType)httpRequestResultWithItem:(BaseHttpItem *)item;

@optional
//Show photoPrefixUrl depends on what's item's httprequestUrl is if it's exist.
- (NSString *)httpPhotoDomainUrlWithUrl:(NSString *)photoUrl;

//save the httpResponseData to local file depends on what it's
- (NSString *)httpRequestCacheMarkWithHttpItem:(BaseHttpItem *)item;

//display the infor of your item.such as header、postData、responseData ..
- (NSString *)displayItemInformationWithItem:(BaseHttpItem *)item;

@end


