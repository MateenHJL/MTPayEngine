//
//  HttpDownloadFileOperation.m
//  MTTemplate
//
//  Created by Mateen on 2017/2/17.
//  Copyright © 2017年 Teen ma. All rights reserved.
//

#import "HttpDownloadFileOperation.h"
#import "BaseHttpStatusCode.h"

#define kNetworkTimeOutCount 15
#define kLockedKey 1

@interface HttpDownloadFileOperation () <NSURLSessionDownloadDelegate>
{
    httpDownloadFileOpeartionFinishedBlock _httpDownloadFileOpeartionFinishedBlock;
    NSConditionLock *requestLockerManager;
}

@property (nonatomic,strong) NSMutableArray       *statusCodesArray;
@property (nonatomic,strong) NSMutableURLRequest  *httpUrlRequest;
@property (nonatomic,strong) BaseHttpItem         *item;


@end

@implementation HttpDownloadFileOperation

- (instancetype)initWithItem:(BaseHttpItem *)item requestFinishedWithBlock:(httpDownloadFileOpeartionFinishedBlock)block
{
    if (self = [super init])
    {
        if ([item isKindOfClass:[BaseHttpItem class]])
        {
            self.item = item;
            _operationIndentity = [NSString stringWithFormat:@"itemIndentity_%@",[self.item class]];
            _httpDownloadFileOpeartionFinishedBlock = [block copy];
            requestLockerManager = [[NSConditionLock alloc] initWithCondition:kLockedKey];
        }
    }
    return self;
}

- (void)main
{
    //start http request
    [self startHttpRequest];
}

//http request start lunch
- (void)startHttpRequest
{
    self.item.httpRequestStatus = HTTPRequestIsConnecting;
    self.httpUrlRequest.timeoutInterval = kNetworkTimeOutCount;
    self.httpUrlRequest.URL = self.httpRequestAppendsUrl;
    switch (self.item.httpRequestMethod)
    {
        case HTTPMethodPOST:
        {
            [self.httpUrlRequest setHTTPBody:self.httpPostBodyAppendsData];
        }
            break;
        default:
            break;
    }

    self.httpUrlRequest.HTTPMethod = self.item.httpRequestMethodString;

    [self.httpUrlRequest addValue:self.acceptTypeAppendsString forHTTPHeaderField:@"Accept"];

    [self addHttpRequestHeaderValue];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];

    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:self.httpUrlRequest];
    [downloadTask resume];
    dispatch_sync(dispatch_get_main_queue(), ^{
        [requestLockerManager lockWhenCondition:kLockedKey];
    });
}

- (void)updateErrorMessageWithStatusCode:(NSInteger)statusCode
{
    for (Class codeClass in self.statusCodesArray)
    {
        BaseHttpStatusCode *statusCodeBaseClass = [[codeClass alloc] init];
        [statusCodeBaseClass matchingWithStatusCode:statusCode httpItem:self.item];
    }
}

- (void)operationFinishedThenSendingBlockToSuper
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_httpDownloadFileOpeartionFinishedBlock)
        {
            _httpDownloadFileOpeartionFinishedBlock (self.item);
        }
    }); 
}

#pragma mark addHttpHearderInfomation
- (void)addHttpRequestHeaderValue
{
    for (NSString *key in [self.requestHeaderParams allKeys])
    {
        [self.httpUrlRequest addValue:[self.requestHeaderParams objectForKey:key] forHTTPHeaderField:key];
    }
}

#pragma mark NSURLSessionDownloadTaskDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
                                           didWriteData:(int64_t)bytesWritten
                                           totalBytesWritten:(int64_t)totalBytesWritten
                                           totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite;
{
    self.item.httpRequestDownloadAlreadyReceivedDataCount = totalBytesWritten;
    self.item.httpRequestDownloadTotalDataCount = totalBytesExpectedToWrite;

    if (self.item.httpRequestStatus == HTTPRequestIsConnecting)
    {
        self.item.httpRepeartActionType = HTTPRepeatActionTypeDownloading;
        if ([self.item respondsToSelector:self.item.httpItemCallBackSelector])
        {
            [self.item performSelectorOnMainThread:self.item.httpItemCallBackSelector withObject:self.item waitUntilDone:YES];
        }
    }
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)downloadTask.response;
    [self updateErrorMessageWithStatusCode:httpResponse.statusCode];
    self.item.httpRequestDownloadFiles = [NSData dataWithContentsOfURL:location];
    self.item.httpRequestResponseData = nil;
    [self operationFinishedThenSendingBlockToSuper];
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (error)
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        [self updateErrorMessageWithStatusCode:httpResponse.statusCode];
        self.item.httpRequestDownloadTotalDataCount = 0.0;
        self.item.httpRequestDownloadAlreadyReceivedDataCount = 0.0;
        self.item.httpRequestResponseData = nil;
        self.item.httpRequestDownloadFiles = nil;
        [self operationFinishedThenSendingBlockToSuper];
    }
}

#pragma mark lazyInit
#pragma mark Appends data which server need.
- (NSDictionary *)requestHeaderParams
{
    if (![self.item httpRequestHeaderParams] || [[self.item httpRequestHeaderParams] count] == 0)
    {
        return [NSDictionary dictionary];
    }
    return [NSDictionary dictionaryWithDictionary:[self.item httpRequestHeaderParams]];
}

- (NSMutableArray *)requestAcceptableContentTypes
{
    if (![self.item httpRequestAcceptableContentTypes] || [[self.item httpRequestAcceptableContentTypes] count] == 0)
    {
        return [NSMutableArray array];
    }
    return [self.item httpRequestAcceptableContentTypes];
}

- (NSDictionary *)requestPostData
{
    if (!self.item.httpRequestPostParams || self.item.httpRequestPostParams.count == 0)
    {
        return [NSDictionary dictionary];
    }
    return self.item.httpRequestPostParams;
}

- (NSMutableURLRequest *)httpUrlRequest
{
    if (!_httpUrlRequest)
    {
        _httpUrlRequest = [[NSMutableURLRequest alloc] init];
    }
    return _httpUrlRequest;
}

- (NSMutableArray *)statusCodesArray
{
    if (!_statusCodesArray)
    {
        _statusCodesArray = [self currentSubClassMemberArray];
    }
    return _statusCodesArray;
}

- (NSURL *)httpRequestAppendsUrl
{
    NSArray *keys = self.item.httpRequestPostParams.allKeys;
    NSMutableString *url = [NSMutableString string];
    [url appendFormat:@"%@", self.item.httpRequestAbsoluteUrlString];
    if (self.item.httpRequestMethod != HTTPMethodPOST)
    {
        if (self.item.httpRequestPostParams.count > 0)
        {
            [url appendString:@"?"];
        }
        for (int i = 0 ; i < keys.count; i++)
        {
            NSString *key = [keys objectAtIndex:i];
            id obj = [self.item.httpRequestPostParams objectForKey:key];
            if (i == 0)
            {
                [url appendFormat:@"%@=%@",key,[obj description]];
            }
            else
            {
                [url appendFormat:@"&%@=%@",key,[obj description]];
            }
        }
    }
    return [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

- (NSString *)acceptTypeAppendsString
{
    //add response content-type
    NSMutableString *acceptType = [[NSMutableString alloc] initWithString:@"*/*"];
    if (self.item.httpRequestAcceptableContentTypes && self.item.httpRequestAcceptableContentTypes.count > 0)
    {
        acceptType = [NSMutableString string];
        for (int i = 0 ; i < self.item.httpRequestAcceptableContentTypes.count; i++)
        {
            NSString *acceptString = [self.item.httpRequestAcceptableContentTypes objectAtIndex:i];
            if (i == self.item.httpRequestAcceptableContentTypes.count - 1)
            {
                [acceptType appendFormat:@"%@",acceptString];
            }
            else
            {
                [acceptType appendFormat:@"%@,",acceptString];
            }
        }
    }
    return acceptType;
}

- (NSData *)httpPostBodyAppendsData
{
    if (self.item.httpRequestPostParams)
    {
        NSError *error = nil;
        NSData *postBodyData = [NSJSONSerialization dataWithJSONObject:self.item.httpRequestPostParams options:NSJSONWritingPrettyPrinted error:&error];
        if (!error)
        {
            return postBodyData;
        }
    }
    return [NSData data];
}

- (NSMutableArray *)currentSubClassMemberArray
{
    NSMutableArray *classNameArray = [NSMutableArray array];

    int numClasses;
    Class *classes = NULL;
    numClasses = objc_getClassList(NULL,0);

    if (numClasses > 0)
    {
        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        for (int i = 0; i < numClasses; i++)
        {
            if (class_getSuperclass(classes[i]) == [BaseHttpStatusCode class])
            {
                [classNameArray addObject:classes[i]];
            }
        }
        free(classes);
    }
    return classNameArray;
}

- (void)dealloc
{
    self.httpUrlRequest = nil;
    _httpDownloadFileOpeartionFinishedBlock = nil;
}


@end
