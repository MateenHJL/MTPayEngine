//
//  HttpRequestQueue.m
//  MTTemplate
//
//  Created by Teen Ma on 16/8/24.
//  Copyright © 2016年 Teen Ma. All rights reserved.
//

#import "HttpRequestOperation.h"
#import "HttpSessionRequestConfig.h"
#import "BaseHttpItem.h"
#import "BaseHttpStatusCode.h"

#define kNetworkTimeOutCount 10
#define kLockedKey 1

typedef void(^httpRequestOperationCompletedBlock) (NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error);

@interface HttpRequestOperation () <NSURLConnectionDelegate>
{
    httpRequestOperationFinishedBlock _httpRequestOperationFinishedBlock;
    NSConditionLock *requestLockerManager;
}

@property (nonatomic,strong) NSMutableArray       *statusCodesArray;
@property (nonatomic,strong) NSMutableURLRequest  *httpUrlRequest;
@property (nonatomic,strong) BaseHttpItem         *item;

@end

@implementation HttpRequestOperation

- (instancetype)initWithItem:(BaseHttpItem *)item requestFinishedWithBlock:(httpRequestOperationFinishedBlock)block
{
    if (self = [super init])
    {
        if ([item isKindOfClass:[BaseHttpItem class]])
        {
            self.item = item;
            _operationIndentity = [NSString stringWithFormat:@"itemIndentity_%@",[self.item class]];
            _httpRequestOperationFinishedBlock = [block copy];
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
    
    [self addHttpRequestHeaderValue];

    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }); 
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:self.httpUrlRequest completionHandler:self.httpRequestOperationCompletedBlock]; 
    [dataTask resume];
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
        if (_httpRequestOperationFinishedBlock)
        {
            _httpRequestOperationFinishedBlock (self.item);
        }
    });
}

#pragma mark addHttpHearderInfomation
- (void)addHttpRequestHeaderValue
{
    NSDictionary *header = self.requestHeaderParams;
    for (NSString *key in header.allKeys)
    {
        [self.httpUrlRequest addValue:[header objectForKey:key] forHTTPHeaderField:key];
    }
    [self.httpUrlRequest addValue:self.acceptTypeAppendsString forHTTPHeaderField:@"Accept"];
}

#pragma mark lazyInit
- (httpRequestOperationCompletedBlock)httpRequestOperationCompletedBlock
{
    httpRequestOperationCompletedBlock completedBlock = ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)   {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [requestLockerManager unlockWithCondition:kLockedKey];
        });
        
        if (response)
        {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            [self updateErrorMessageWithStatusCode:httpResponse.statusCode];
            
            self.item.httpRequestResponseData = nil;
            
            if (!data && error)
            {
                [self operationFinishedThenSendingBlockToSuper];
            }
            else
            {
                if (data)
                {
                    //parse data to dictionary
                    self.item.httpRequestResponseDataJson = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    NSError *parseErro;
                    id requestResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&parseErro];
                    if (parseErro)
                    {
                        [self operationFinishedThenSendingBlockToSuper];
                        return ;
                    }
                    if ([requestResponse isKindOfClass:[NSString class]])
                    {
                        NSData *jsonData = [requestResponse dataUsingEncoding:NSUTF8StringEncoding];
                        NSError *err;
                        self.item.httpRequestResponseData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
                        if (err)
                        {
                            [self updateErrorMessageWithStatusCode:HTTPStatusCodeParseError];
                            [self operationFinishedThenSendingBlockToSuper];
                            return ;
                        }
                    }
                    else if ([requestResponse isKindOfClass:[NSDictionary class]] || [requestResponse isKindOfClass:[NSArray class]])
                    {
                        self.item.httpRequestResponseData = requestResponse;
                    }
                    
                    [self operationFinishedThenSendingBlockToSuper];
                }
                else
                {
                    [self updateErrorMessageWithStatusCode:HTTPStatusCodeResponseDataIsNil];
                    [self operationFinishedThenSendingBlockToSuper];
                }
            }
        }
        else
        {
            [self updateErrorMessageWithStatusCode:HTTPStatusCodeNoNetwork];
            [self operationFinishedThenSendingBlockToSuper];
        }
    };
    return completedBlock;
}

#pragma mark Appends data which server need.
- (NSDictionary *)requestHeaderParams
{
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
    NSMutableString *url = [NSMutableString string];
    [url appendFormat:@"%@", self.item.httpRequestAbsoluteUrlString];
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
        NSString *httpPostDataString = self.item.httpRequestPostParasString;
        NSMutableData *postBodyData = [[NSMutableData alloc] initWithData:[httpPostDataString dataUsingEncoding:NSUTF8StringEncoding]];
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
    _httpRequestOperationFinishedBlock = nil;
}

@end
