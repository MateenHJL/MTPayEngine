//
//  BaseHttpItem.m
//  DrinkLink
//
//  Created by MaTeen on 14/12/13.
//  Copyright (c) 2014年 MaTeen. All rights reserved.
//

#import "BaseHttpItem.h"
#import "HttpEngine.h" 
#import "BaseHttpConfigManager.h"

@interface BaseHttpItem () 

@property (nonatomic,copy    ) NSString *httpRequestAbsoluteUrlString;
@property (nonatomic,assign  ) SEL      httpItemCallBackSelector;
@property (nonatomic,copy    ) NSString *httpRequestCalledClassName;
@property (nonatomic,copy    ) NSString *httpRequestMethodString; 
@property (nonatomic,assign  ) HTTPConnectionCompletedStatus httpRequestConnectedStatus;
@property (nonatomic,copy    ) NSString *httpRequestUploadPercent;
@property (nonatomic,copy    ) NSString *httpRequestDownloadPercent;
@property (nonatomic,copy    ) NSString *httpRequestCacheMark;

@end

@implementation BaseHttpItem
 
@synthesize httpRequestHeaderParams                     = _httpRequestHeaderParams;
@synthesize httpRequestPostParams                       = _httpRequestPostParams;
@synthesize httpRequestAcceptableContentTypes           = _httpRequestAcceptableContentTypes;
@synthesize httpRequestCacheType                        = _httpRequestCacheType;
@synthesize httpRequestCacheMark                        = _httpRequestCacheMark;
@synthesize httpRequestPostFiles                        = _httpRequestPostFiles;
@synthesize httpRequestUploadPercent                    = _httpRequestUploadPercent;
@synthesize httpRequestPostFileName                     = _httpRequestPostFileName;
@synthesize httpUploadFileAttactParams                  = _httpUploadFileAttactParams;
@synthesize httpRequestUploadTotalDataCount             = _httpRequestUploadTotalDataCount;
@synthesize httpRequestUploadAlreadySendDataCount       = _httpRequestUploadAlreadySendDataCount;
@synthesize httpRequestDownloadPercent                  = _httpRequestDownloadPercent;
@synthesize httpRequestDownloadFiles                    = _httpRequestDownloadFiles;
@synthesize httpRequestDownloadTotalDataCount           = _httpRequestDownloadTotalDataCount;
@synthesize httpRequestDownloadAlreadyReceivedDataCount = _httpRequestDownloadAlreadyReceivedDataCount;
@synthesize httpResponseIsMockStatus                    = _httpResponseIsMockStatus;
@synthesize httpReuqestShouldAddSelfToLog               = _httpReuqestShouldAddSelfToLog; 
@synthesize httpRequestResponseDataJson                 = _httpRequestResponseDataJson;
@synthesize httpRequestPostParasString                  = _httpRequestPostParasString;
- (instancetype)init
{
    if (self = [super init])
    {
        //defaut config setting.
        self.httpRequestConnectedStatus        = HTTPConnectionCompletedStatusUnknowStatus;
        self.httpRequestMethod                 = HTTPMethodPOST;
        self.httpRequestUrl                    = @"";
        self.httpRequestAbsoluteUrlString      = @"";
        self.httpRequestPostParams             = [NSMutableDictionary dictionary];
        self.httpRequestCacheType              = HTTPCacheTypeServerOnly;
        self.httpRequestResponseData           = nil;
        self.httpRequestStatusCode             = HTTPStatusCodeDetaultCode;
        self.httpRequestErrorMessage           = @"";
        self.httpRequestStatus                 = HTTPRequestStatusPrepared;
        self.httpRequestType                   = HTTPRequestTypeRequestJsonDataType;
        self.httpResponseDataType              = HTTPResponseDataTypeUnknownType;
        self.httpRequestDebugErrorMessage      = @"";
        self.httpRequestPostFiles              = @"";
        self.httpRequestUploadPercent          = @"0.0";
        self.httpRequestDownloadPercent        = @"0.0";
        self.httpRequestPostFileName           = @"";
        self.httpUploadFileAttactParams        = [NSMutableDictionary dictionary];
        self.httpRequestUploadAlreadySendDataCount = 0.0;
        self.httpRequestUploadTotalDataCount   = 0.0;
        self.httpRepeartActionType             = HTTPRepeatActionTypeNone;
        self.httpRequestDownloadFiles          = [NSData data];
        self.httpRequestDownloadAlreadyReceivedDataCount = 0.0;
        self.httpRequestDownloadTotalDataCount = 0.0;
        self.httpResponseIsMockStatus          = NO;
        self.httpReuqestShouldAddSelfToLog     = NO;
        self.httpRequestPostParasString        = @"";
    }
    return self;
}

- (void)httpRequestUploadProgressValueWithItem:(BaseHttpItem *)item;
{
    return;
}

- (void)httpRequestDownloadProgressValueWithItem:(BaseHttpItem *)item
{
    return;
}

- (void)httpRequestCompletedExceptionWithItem:(BaseHttpItem *)item
{ 
    return;
}

- (void)httpRequestFailedWitItem:(BaseHttpItem *)item
{
    return;
}

- (void)httpRequestCompletedWithItem:(BaseHttpItem *)item
{
    return;
}

- (void)setHttpRequestMethod:(HTTPMethod)httpRequestMethod
{
    NSString *method = HTTPWAYGET;
    switch (httpRequestMethod)
    {
        case HTTPMethodPOST:
        {
            method = HTTPWAYPOST;
        }
            break;
        case HTTPMethodPUT:
        {
            method = HTTPWAYPUT;
        }
            break;
        case HTTPMethodDELETE:
        {
            method = HTTPWAYDELETE;
        }
            break;
        case HTTPMethodGET:
        {
            method = HTTPWAYGET;
        }
            break;
    }
    self.httpRequestMethodString = method;
    _httpRequestMethod = httpRequestMethod;
}

- (void)cancelHttpRequest
{
    [[HttpEngine shareHttpEngine] cancelHttpRequestWithItem:self];
}

- (NSString *)httpRequestPostParasString
{
    _httpRequestPostParasString = [[BaseHttpConfigManager shareHttpConfigManager].config httpRequestPostParamsWithHttpItem:self];
    return _httpRequestPostParasString;
}

- (NSString *)httpRequestCacheMark
{
    _httpRequestCacheMark = [[BaseHttpConfigManager shareHttpConfigManager].config httpRequestCacheMarkWithHttpItem:self];
    return _httpRequestCacheMark;
}

- (NSString *)displayItemInformation
{
    return [[BaseHttpConfigManager shareHttpConfigManager].config displayItemInformationWithItem:self];
}

- (NSMutableDictionary *)httpRequestHeaderParams
{
    return [[BaseHttpConfigManager shareHttpConfigManager].config headerRequestDictionary];
}

- (NSString *)httpRequestAbsoluteUrlString
{
    if (self.httpReqeustDomainUrl.length == 0 && self.httpRequestUrl.length == 0)
    {
        _httpRequestAbsoluteUrlString = @"";
    }
    else
    {
        _httpRequestAbsoluteUrlString = [NSString stringWithFormat:@"%@%@",self.httpReqeustDomainUrl,self.httpRequestUrl];
    }

    return _httpRequestAbsoluteUrlString;
}

- (NSString *)httpReqeustDomainUrl
{
    _httpReqeustDomainUrl = [[BaseHttpConfigManager shareHttpConfigManager].config configBaseHttpUrlWithHttpItem:self];
    return _httpReqeustDomainUrl;
}

- (SEL)httpItemCallBackSelector
{
    NSString *methodName = @"";

    if (self.httpRequestStatus == HTTPRequestIsConnecting)
    {
        switch (self.httpRepeartActionType)
        {
            case HTTPRepeatActionTypeUploading:
            {
                methodName = @"httpRequestUploadProgressValueWithItem:";
            }
                break;
            case HTTPRepeatActionTypeDownloading:
            {
                methodName = @"httpRequestDownloadProgressValueWithItem:";
            }
                break;
            default:
                break;
        }
    }
    else if (self.httpRequestStatus == HTTPRequestStatusHasFinished)
    {
        switch (self.httpRequestConnectedStatus)
        {
            case HTTPConnectionCompletedStatusConnectedException:
            {
                methodName = @"httpRequestCompletedExceptionWithItem:";
            }
                break;
            case HTTPConnectionCompletedStatusConnectedSuccessed:
            {
                methodName = @"httpRequestCompletedWithItem:";
            }
                break;
            case HTTPConnectionCompletedStatusConnectedFailed:
            {
                methodName = @"httpRequestFailedWitItem:";
            }
                break;
            default:
                break;
        }
    }

    SEL selector = NSSelectorFromString(methodName);
    if ([self respondsToSelector:selector])
    {
        _httpItemCallBackSelector = NSSelectorFromString(methodName);
    }
    return _httpItemCallBackSelector;
}

- (HTTPConnectionCompletedStatus)httpRequestConnectedStatus
{
    if (self.httpRequestStatusCode >= 200 && self.httpRequestStatusCode <= 299)
    {
        if (self.httpRequestType == HTTPRequestTypeRequestJsonDataType)
        {
            switch ([[BaseHttpConfigManager shareHttpConfigManager].config httpRequestResultWithItem:self])
            {
                case HTTPRequestResultTypeSuccessed:
                {
                    _httpRequestConnectedStatus = HTTPConnectionCompletedStatusConnectedSuccessed;
                }
                    break;
                case HTTPRequestResultTypeFailed:
                {
                    _httpRequestConnectedStatus = HTTPConnectionCompletedStatusConnectedException;
                }
                    break;
                case HTTPRequestResultTypeAnotherType:
                {
                    
                }
                    break;
                default:
                    break;
            }
        }
        else
        {
            _httpRequestConnectedStatus = HTTPConnectionCompletedStatusConnectedSuccessed;
        }
    }
    else if (self.httpRequestStatusCode >= 400 && self.httpRequestStatusCode <= 599)
    {
        _httpRequestConnectedStatus = HTTPConnectionCompletedStatusConnectedFailed;
    }
    else if (self.httpRequestStatusCode > 60000)
    {
        _httpRequestConnectedStatus = HTTPConnectionCompletedStatusConnectedFailed;
    }
    else
    {
        _httpRequestConnectedStatus = HTTPConnectionCompletedStatusUnknowStatus;
    }
    return _httpRequestConnectedStatus;
}

- (NSString *)httpRequestUploadPercent
{
    CGFloat uploadPercent = self.httpRequestUploadAlreadySendDataCount / self.httpRequestUploadTotalDataCount * 100;
    _httpRequestUploadPercent = [NSString stringWithFormat:@"%.1lf",uploadPercent];
    return _httpRequestUploadPercent;
}

- (NSString *)httpRequestDownloadPercent
{
    CGFloat downloadPercent = self.httpRequestDownloadAlreadyReceivedDataCount / self.httpRequestDownloadTotalDataCount * 100;
    _httpRequestDownloadPercent = [NSString stringWithFormat:@"%.1lf",downloadPercent];
    return _httpRequestDownloadPercent;
}

- (NSMutableArray *)httpRequestAcceptableContentTypes
{
    _httpRequestAcceptableContentTypes = [[BaseHttpConfigManager shareHttpConfigManager].config httpRequestAcceptableContentTypes];
    return _httpRequestAcceptableContentTypes;
}

- (NSInteger)httpRequestTimeoutCount
{
    return [[BaseHttpConfigManager shareHttpConfigManager].config httpRequestTimeoutCount];
}

- (NSString *)descriptionItem
{
    return @"";
}

- (NSString *)httpRequestCalledClassName
{
    __block NSString *mainCallStackSymbolMsg = @"";
    NSString *regularExpStr = @"[-\\+]\\[.+\\]";
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray *callStackSymbols = [NSThread callStackSymbols];
    for (int index = 4; index < callStackSymbols.count; index++)
    {
        NSString *callStackSymbol = callStackSymbols[index];
        
        [regularExp enumerateMatchesInString:callStackSymbol options:NSMatchingReportProgress range:NSMakeRange(0, callStackSymbol.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            if (result)
            {
                NSString* tempCallStackSymbolMsg = [callStackSymbol substringWithRange:result.range];
                
                NSString *className = [tempCallStackSymbolMsg componentsSeparatedByString:@" "].firstObject;
                mainCallStackSymbolMsg = [className componentsSeparatedByString:@"["].lastObject;
                *stop = YES;
            }
        }];
        
        if (mainCallStackSymbolMsg.length)
        {
            return mainCallStackSymbolMsg;
        }
    }
    return mainCallStackSymbolMsg;
}

- (NSString *)mocksJsonData
{
    return @"";
}

- (void)dealloc
{
    NSLog(@"%@ has been release",NSStringFromClass(self.class));
}

@end
