//
//  HttpUploadFileOperation.m
//  MTTemplate
//
//  Created by Mateen on 2017/1/20.
//  Copyright © 2017年 Teen ma. All rights reserved.
//

#import "HttpUploadFileOperation.h"
#import "BaseHttpStatusCode.h"

#define kNetworkTimeOutCount 15
#define kLockedKey 1
#define kBoundaryString @"HTTPUPLOADFILEBOUNDRAY"
#define kDivisionSymbol [@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]

typedef void(^httpUploadFileOperationCompletedBlock) (NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error);

@interface HttpUploadFileOperation () <NSURLSessionDelegate>
{
    httpUploadFileOpeartionFinishedBlock _httpUploadFileOpeartionFinishedBlock;
    NSConditionLock *requestLockerManager;
}

@property (nonatomic,strong) NSMutableArray       *statusCodesArray;
@property (nonatomic,strong) NSMutableURLRequest  *httpUrlRequest;
@property (nonatomic,strong) BaseHttpItem         *item;

@end

@implementation HttpUploadFileOperation

- (instancetype)initWithItem:(BaseHttpItem *)item requestFinishedWithBlock:(httpUploadFileOpeartionFinishedBlock)block
{
    if (self = [super init])
    {
        if ([item isKindOfClass:[BaseHttpItem class]])
        {
            self.item = item;
            _operationIndentity = [NSString stringWithFormat:@"itemIndentity_%@",[self.item class]];
            _httpUploadFileOpeartionFinishedBlock = [block copy];
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

    NSString *header = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",kBoundaryString];
    [self.httpUrlRequest setValue:header forHTTPHeaderField:@"Content-Type"];

    [self addHttpRequestHeaderValue];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];

    NSURLSessionUploadTask *uploadDataTask = [session uploadTaskWithRequest:self.httpUrlRequest fromData:self.uploadFileAttachFormData completionHandler:self.httpUploadFileOperationCompletedBlock];
    [uploadDataTask resume];
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
        if (_httpUploadFileOpeartionFinishedBlock)
        {
            _httpUploadFileOpeartionFinishedBlock (self.item);
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

#pragma mark NSURLSessionUploadTaskDelegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
                                           didSendBodyData:(int64_t)bytesSent
                                           totalBytesSent:(int64_t)totalBytesSent
                                           totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend;
{
    self.item.httpRequestUploadAlreadySendDataCount = totalBytesSent;
    self.item.httpRequestUploadTotalDataCount = totalBytesExpectedToSend;

    if (self.item.httpRequestStatus == HTTPRequestIsConnecting)
    {
        self.item.httpRepeartActionType = HTTPRepeatActionTypeUploading;
        if ([self.item respondsToSelector:self.item.httpItemCallBackSelector])
        {
            [self.item performSelectorOnMainThread:self.item.httpItemCallBackSelector withObject:self.item waitUntilDone:YES];
        }
    }
}

#pragma mark lazyInit
- (httpUploadFileOperationCompletedBlock)httpUploadFileOperationCompletedBlock
{
    httpUploadFileOperationCompletedBlock completedBlock = ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)   {

        dispatch_async(dispatch_get_main_queue(), ^{
            if (_httpUploadFileOpeartionFinishedBlock)
            {
                [requestLockerManager unlockWithCondition:kLockedKey];
            }
        });

        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        [self updateErrorMessageWithStatusCode:httpResponse.statusCode];

        self.item.httpRequestResponseData = nil;

        if (!data || error)
        {
            [self operationFinishedThenSendingBlockToSuper];
        }
        else
        {
            if (response)
            {
                //parse data to dictionary
                NSError *parseErro;
                id requestResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&parseErro];
                if (parseErro)
                {
                    [self updateErrorMessageWithStatusCode:HTTPStatusCodeParseError];
                    [self operationFinishedThenSendingBlockToSuper];
                    return ;
                }

                NSDictionary *responseDic = [NSDictionary dictionary];
                if ([requestResponse isKindOfClass:[NSString class]])
                {
                    NSData *jsonData = [requestResponse dataUsingEncoding:NSUTF8StringEncoding];
                    NSError *err;
                    responseDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
                    if (err)
                    {
                        [self updateErrorMessageWithStatusCode:HTTPStatusCodeParseError];
                        [self operationFinishedThenSendingBlockToSuper];
                        return ;
                    }
                }
                else if ([requestResponse isKindOfClass:[NSDictionary class]])
                {
                    responseDic = requestResponse;
                }

                self.item.httpRequestResponseData = responseDic;
                [self operationFinishedThenSendingBlockToSuper];
            }
            else
            {
                [self updateErrorMessageWithStatusCode:HTTPStatusCodeResponseDataIsNil];
                [self operationFinishedThenSendingBlockToSuper];
            }
        }
    };
    return completedBlock;
}

#pragma mark Appends data which server need.
- (NSData *)uploadFileAttachFormData
{
    NSMutableData *uploadFileAttachFormData = [NSMutableData data];

    //let your server know what's the name of picture you wanna to save.
    if (self.item.httpRequestPostFileName.length > 0 && self.item.httpRequestPostFiles)
    {
        [uploadFileAttachFormData appendData:[[NSString stringWithFormat:@"--%@",kBoundaryString] dataUsingEncoding:NSUTF8StringEncoding]];
        [uploadFileAttachFormData appendData:kDivisionSymbol];

        [uploadFileAttachFormData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"picture.png\"",self.item.httpRequestPostFileName] dataUsingEncoding:NSUTF8StringEncoding]];
        [uploadFileAttachFormData appendData:kDivisionSymbol];

        //tell your server the type of files which you wanna to upload
        [uploadFileAttachFormData appendData: [@"Content-Type: image/png" dataUsingEncoding:NSUTF8StringEncoding]];
        [uploadFileAttachFormData appendData:kDivisionSymbol];
        [uploadFileAttachFormData appendData:kDivisionSymbol];

        //the content of your file which you wanna to upload.
        [uploadFileAttachFormData appendData:self.item.httpRequestPostFiles];
        [uploadFileAttachFormData appendData:kDivisionSymbol];
    }

    //upload some attach attribute data.it depends on the document which defined between app-developer and server-developer;
    if (self.item.httpUploadFileAttactParams && self.item.httpUploadFileAttactParams.count > 0)
    {
        NSArray *allKeys = [self.item.httpUploadFileAttactParams allKeys];
        for (int i = 0 ; i < allKeys.count; i++)
        {
            NSString *keys = [allKeys objectAtIndex:i];
            NSString *value = [self.item.httpUploadFileAttactParams objectForKey:keys];

            [uploadFileAttachFormData appendData:[[NSString stringWithFormat:@"--%@",kBoundaryString] dataUsingEncoding:NSUTF8StringEncoding]];
            [uploadFileAttachFormData appendData:kDivisionSymbol];

            [uploadFileAttachFormData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"",keys] dataUsingEncoding:NSUTF8StringEncoding]];
            [uploadFileAttachFormData appendData:kDivisionSymbol];
            [uploadFileAttachFormData appendData:kDivisionSymbol];
            [uploadFileAttachFormData appendData:[value.length > 0 ? value:@"" dataUsingEncoding:NSUTF8StringEncoding]];
            [uploadFileAttachFormData appendData:kDivisionSymbol];

            if (i == allKeys.count - 1)//the end
            {
                [uploadFileAttachFormData appendData:[[NSString stringWithFormat:@"--%@--",kBoundaryString] dataUsingEncoding:NSUTF8StringEncoding]];
            }
        }
    }
    return uploadFileAttachFormData;
}

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
    _httpUploadFileOpeartionFinishedBlock = nil;
}

@end
