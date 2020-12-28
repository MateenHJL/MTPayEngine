//
//  HttpEngine.m
//  DrinkLink
//
//  Created by MaTeen on 14/12/13.
//  Copyright (c) 2014年 MaTeen. All rights reserved.
//

#import "HttpEngine.h"
#import "CacheEngine.h"

#import "BaseHttpItem.h"

#import "HttpRequestOperation.h"
#import "HttpUploadFileOperation.h"
#import "HttpDownloadFileOperation.h"

#import "Reachability.h"

#import "HttpLogicHandleManager.h"
#import "CacheLogicHandleManager.h"

#import "HTTPStatusCode.h"

#import "HttpLogCollectionItem.h"

#import "SqliteEngine.h"
#import "ISRemoveNull.h"

#import "BaseHttpConfigManager.h"

#define kOperationQueueMaxCount 10

@interface HttpEngine ()

@property (nonatomic,strong) NSOperationQueue *operationQueue;

@end

@implementation HttpEngine

+ (instancetype)shareHttpEngine
{
    static dispatch_once_t onceToken;
    static HttpEngine *engine = nil;
    dispatch_once(&onceToken, ^{
        engine = [[HttpEngine alloc]init];
    });
    return engine;
}

- (void)startConnectionWithRequestItem:(BaseHttpItem *)item
{
    NSAssert([BaseHttpConfigManager shareHttpConfigManager].config, @"there's no httpConfig in BaseHttpConfigManager,please called [[BaseHttpConfigManager shareHttpConfigManager] setupHttpEngineWithConfig:] when your application launched first");
    NSOperation *queue;
    switch (item.httpRequestType)
    {
        case HTTPRequestTypeRequestJsonDataType:
        {
            //need be loaded localCache from CacheEngine?
            if ([CacheLogicHandleManager needLoadCacheFromCacheEngineWithItem:item])
            {
                //check your localData is existed from your sandbox
                if ([CacheLogicHandleManager localCacheIsExistsWithItem:item])
                {
                    item.httpRequestResponseData = [CacheEngine loadDataWithMarkKeyFileName:item.httpRequestCacheMark];
                    item.httpResponseDataType = HTTPResponseDataTypeLoadedFromLocalCache;
                    item.httpRequestStatus = HTTPRequestStatusHasFinished;
                    item.httpRequestStatusCode = HTTPStatusCodeNoneError;
                    [item httpRequestCompletedWithItem:item];
                }
            }

            //there's no network.
            if (![HttpLogicHandleManager networkCanBeReached])
            {
                item.httpRequestStatus = HTTPRequestStatusHasFinished;
                item.httpRequestStatusCode = HTTPStatusCodeNoNetwork;
                item.httpRequestResponseData = nil;
                item.httpResponseDataType = HTTPResponseDataTypeUnknownType;
                BaseHttpStatusCode *statusCodeBase = [[HttpNoNetworkStatusCode alloc] init];
                [statusCodeBase matchingWithStatusCode:HTTPStatusCodeNoNetwork httpItem:item];
                [item httpRequestFailedWitItem:item];
                NSLog(@"%@",[item displayItemInformation]);
                return;
            }
            
            //wether you should request responseData from your server.
            if ([CacheLogicHandleManager needBeContinueRequestWithHttpItem:item])
            {
                //check your httpUrlString
                if (![HttpLogicHandleManager isHttpUrlCorrectWithItem:item])
                {
                    item.httpRequestStatus = HTTPRequestStatusHasFinished;
                    item.httpRequestStatusCode = HTTPStatusCodeRequestUrlIsNilOrNotCorrect;
                    item.httpRequestResponseData = nil;
                    item.httpResponseDataType = HTTPResponseDataTypeLoadedFromLocalCache;
                    BaseHttpStatusCode *statusCodeBase = [[HttpRequestUrlIsNilStatusCode alloc] init];
                    [statusCodeBase matchingWithStatusCode:HTTPStatusCodeRequestUrlIsNilOrNotCorrect httpItem:item];
                    [item httpRequestFailedWitItem:item];
                    NSLog(@"%@",[item displayItemInformation]);
                    return;
                }

                //current response status is loaded from local data which is mocked.?
                if ([HttpLogicHandleManager isMockResponseStatusWithItem:item])
                {
                    item.httpRequestStatusCode = HTTPStatusCodeNoneError;
                    item.httpRequestStatus = HTTPRequestStatusHasFinished;
                    BaseHttpStatusCode *statusCodeBase = [[Http200StatusCode alloc] init];
                    [statusCodeBase matchingWithStatusCode:200 httpItem:item];
                    NSData *jsonData = [item.mocksJsonData dataUsingEncoding:NSUTF8StringEncoding];
                    item.httpRequestResponseData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                    item.httpResponseDataType = HTTPResponseDataTypeLoadedFromMockingResponse;
                    if ([item respondsToSelector:item.httpItemCallBackSelector])
                    {
                        [item performSelectorOnMainThread:item.httpItemCallBackSelector withObject:item waitUntilDone:[NSThread isMainThread]];
                    }
                    NSLog(@"%@",[item displayItemInformation]);
                    return;
                }

                //start HttpRequest
                queue = [[HttpRequestOperation alloc] initWithItem:item requestFinishedWithBlock:^(BaseHttpItem *responsedItem) {
                    responsedItem.httpRequestStatus = HTTPRequestStatusHasFinished;
                    responsedItem.httpResponseDataType = HTTPResponseDataTypeLoadedFromServer;

                    //wether your data from server should be saved to sandbox
                    if ([CacheLogicHandleManager shouldSaveLocalCacheWithItem:responsedItem])
                    {
                        if ([CacheLogicHandleManager canBeSavedToLocalFiledWithHttpItem:responsedItem])
                        {
                            NSDictionary *filterResponseData = [responsedItem.httpRequestResponseData dictionaryByRemovingNull];
                            [CacheEngine saveData:filterResponseData toMarkKeyFileName:responsedItem.httpRequestCacheMark];
                        }
                    }
                    
                    //save your httpItem to network log if you wanna
                    if ([CacheLogicHandleManager shouldSaveHttpNetworkLogWithItem:responsedItem])
                    {
                        BaseSqliteItem *sqliteItem = [HttpLogCollectionItem convertHttpItemWithSqliteItemWithHttpItem:responsedItem];
                        [[SqliteEngine shareEngine] excutedWithSqiteItem:sqliteItem completedWithBlock:^(BOOL isSuccessed, NSString *operatedError) {
                            if (isSuccessed)
                            {
                                NSLog(@"HttpLog信息保存成功");
                            }
                            else
                            {
                                NSLog(@"HttpLog信息保存失败,失败信息：%@",operatedError);
                            }
                        }];
                    }

                    NSLog(@"%@",responsedItem.displayItemInformation);
                    if ([responsedItem respondsToSelector:responsedItem.httpItemCallBackSelector])
                    {
                        [responsedItem performSelectorOnMainThread:responsedItem.httpItemCallBackSelector withObject:responsedItem waitUntilDone:[NSThread isMainThread]];
                    }
                }];
            }
        }
            break;
        case HTTPRequestTypeUploadFilesType:
        {
            //there's no network to do.
            if (![HttpLogicHandleManager networkCanBeReached])
            {
                item.httpRequestStatus = HTTPRequestStatusHasFinished;
                item.httpRequestStatusCode = HTTPStatusCodeNoNetwork;
                item.httpRequestResponseData = nil;
                item.httpResponseDataType = HTTPResponseDataTypeUnknownType;
                BaseHttpStatusCode *statusCodeBase = [[HttpNoNetworkStatusCode alloc] init];
                [statusCodeBase matchingWithStatusCode:HTTPStatusCodeNoNetwork httpItem:item];
                [item httpRequestFailedWitItem:item];
                NSLog(@"%@",[item displayItemInformation]);
                return;
            }
            
            queue = [[HttpUploadFileOperation alloc] initWithItem:item requestFinishedWithBlock:^(BaseHttpItem *responsedItem) {
                responsedItem.httpRequestStatus = HTTPRequestStatusHasFinished;
                responsedItem.httpResponseDataType = HTTPResponseDataTypeLoadedFromServer;
                if (responsedItem.httpRequestStatus == HTTPRequestStatusHasFinished)
                {
                    if ([responsedItem respondsToSelector:responsedItem.httpItemCallBackSelector])
                    {
                        [responsedItem performSelectorOnMainThread:responsedItem.httpItemCallBackSelector withObject:responsedItem waitUntilDone:[NSThread isMainThread]];
                    }
                    NSLog(@"%@",[responsedItem displayItemInformation]);
                }
            }];
        }
            break;
        case HTTPRequestTypeDownloadFilesType:
        {
            //there's no network to do.
            if (![HttpLogicHandleManager networkCanBeReached])
            {
                item.httpRequestStatus = HTTPRequestStatusHasFinished;
                item.httpRequestStatusCode = HTTPStatusCodeNoNetwork;
                item.httpRequestResponseData = nil;
                item.httpResponseDataType = HTTPResponseDataTypeUnknownType;
                BaseHttpStatusCode *statusCodeBase = [[HttpNoNetworkStatusCode alloc] init];
                [statusCodeBase matchingWithStatusCode:HTTPStatusCodeNoNetwork httpItem:item];
                [item httpRequestFailedWitItem:item];
                NSLog(@"%@",[item displayItemInformation]);
                return;
            }

            queue = [[HttpDownloadFileOperation alloc] initWithItem:item requestFinishedWithBlock:^(BaseHttpItem *responsedItem) {
                responsedItem.httpRequestStatus = HTTPRequestStatusHasFinished;
                responsedItem.httpResponseDataType = HTTPResponseDataTypeLoadedFromServer;
                if (responsedItem.httpRequestStatus == HTTPRequestStatusHasFinished)
                {
                    if ([responsedItem respondsToSelector:responsedItem.httpItemCallBackSelector])
                    {
                        [responsedItem performSelectorOnMainThread:responsedItem.httpItemCallBackSelector withObject:responsedItem waitUntilDone:[NSThread isMainThread]];
                    }
                }
                NSLog(@"%@",[responsedItem displayItemInformation]);
            }];
        }
            break;
        default:
            break;
    }

    [self.operationQueue addOperation:queue];
}

- (void)cancelHttpRequestWithItem:(BaseHttpItem *)item
{
    if (!self.operationQueue || !self.operationQueue.operations || self.operationQueue.operations.count == 0)
    {
        return;
    }
    
    for (HttpRequestOperation *operation in self.operationQueue.operations)
    {
        if (!operation.isFinished && [operation.item isEqual:item] && operation.item.httpRequestStatus == HTTPRequestStatusPrepared)
        {
            [operation cancel];
        }
    }
}

- (void)cancelEntireHttpRequest
{
    [self.operationQueue cancelAllOperations];
}

- (void)cancelPartHttpRequestWithCalledName:(NSString *)calledName
{
    if (calledName && calledName.length > 0)
    {
        for (HttpRequestOperation *operation in self.operationQueue.operations)
        {
            if (operation.isReady)
            {
                if ([operation.item.httpRequestCalledClassName isEqualToString:calledName])
                {
                    [operation cancel];
                }
            }
        }
    }
}

#pragma mark lazyInit
- (NSOperationQueue *)operationQueue
{
    if (!_operationQueue)
    {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = kOperationQueueMaxCount;
    }
    return _operationQueue;
}

@end
