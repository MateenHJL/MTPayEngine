//
//  CacheLogicHandleManager.m
//  MTTemplate
//
//  Created by Mateen on 2017/1/16.
//  Copyright © 2017年 Teen ma. All rights reserved.
//

#import "CacheLogicHandleManager.h"
#import "CacheEngine.h"
#import "BaseHttpItem.h"

@implementation CacheLogicHandleManager

+ (BOOL)needLoadCacheFromCacheEngineWithItem:(BaseHttpItem *)item
{
    BOOL result = NO;
    if (item.httpRequestCacheType == HTTPCacheTypeCacheOnly || item.httpRequestCacheType == HTTPCacheTypeCacheDataThenServerData)
    {
        result = YES;
    }
    return result;
}

+ (BOOL)localCacheIsExistsWithItem:(BaseHttpItem *)item
{
    BOOL result = NO;
    if ([CacheEngine localCacheIsExistsWithMarkKeyFileName:item.httpRequestCacheMark])
    {
        result = YES;
    }
    return result;
}

+ (BOOL)shouldSaveLocalCacheWithItem:(BaseHttpItem *)item
{
    BOOL result = NO;
    if (item.httpRequestCacheType == HTTPCacheTypeCacheOnly || item.httpRequestCacheType == HTTPCacheTypeCacheDataThenServerData)
    {
        result = YES;
    }
    return result;
}

+ (BOOL)needBeContinueRequestWithHttpItem:(BaseHttpItem *)item
{
    BOOL result = NO;
    if (item.httpRequestCacheType == HTTPCacheTypeServerOnly || (item.httpRequestCacheType == HTTPCacheTypeCacheOnly && ![CacheEngine localCacheIsExistsWithMarkKeyFileName:item.httpRequestCacheMark]) || item.httpRequestCacheType == HTTPCacheTypeCacheDataThenServerData)
    {
        result = YES;
    }
    return result;
}

+ (BOOL)canBeSavedToLocalFiledWithHttpItem:(BaseHttpItem *)item
{
    BOOL result = NO;
    if (item.httpRequestResponseData && [item.httpRequestResponseData isKindOfClass:[NSDictionary class]] && item.httpRequestConnectedStatus == HTTPConnectionCompletedStatusConnectedSuccessed)
    {
        result = YES;
    }
    return result;
}

+ (BOOL)shouldSaveHttpNetworkLogWithItem:(BaseHttpItem *)item
{
    BOOL result = NO;
    if (item.httpReuqestShouldAddSelfToLog)
    {
        result = YES;
    }
    return result;
}

@end
