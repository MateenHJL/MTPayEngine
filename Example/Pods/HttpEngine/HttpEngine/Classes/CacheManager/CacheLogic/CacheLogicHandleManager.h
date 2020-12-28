//
//  CacheLogicHandleManager.h
//  MTTemplate
//
//  Created by Mateen on 2017/1/16.
//  Copyright © 2017年 Teen ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseHttpItem;

@interface CacheLogicHandleManager : NSObject

//check need loaded localCache from CacheEngine
+ (BOOL)needLoadCacheFromCacheEngineWithItem:(BaseHttpItem *)item;

//check wether your data is exist in your sandbox.
+ (BOOL)localCacheIsExistsWithItem:(BaseHttpItem *)item;

//check it should be loaded data from sandbox first.
+ (BOOL)shouldSaveLocalCacheWithItem:(BaseHttpItem *)item;

//check your request need be continued,it's depends on what httpRequestCacheType is.
+ (BOOL)needBeContinueRequestWithHttpItem:(BaseHttpItem *)item;

//check your response data is nil and correctable format
+ (BOOL)canBeSavedToLocalFiledWithHttpItem:(BaseHttpItem *)item;

//should show in log
+ (BOOL)shouldSaveHttpNetworkLogWithItem:(BaseHttpItem *)item;

@end
