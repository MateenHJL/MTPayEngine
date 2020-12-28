//
//  BaseHttpConfigManager.m
//  DateTools
//
//  Created by mateen on 2020/12/21.
//

#import "BaseHttpConfigManager.h"

#import "BaseHttpItem.h" 
#import <HttpEngine/CacheEngine.h>
#import <HttpEngine/BaseHttpItem.h>

#define kCurrentUrlTypeMarkKey @"kCurrentUrlTypeMarkKey"
#define kHttpRequestTimeOut 15
 
#define kMarkCode @"code"
 
@interface BaseHttpConfigManager ()
 
@property (nonatomic, strong    ) id<HttpConfigDataSource> config;

@end

@implementation BaseHttpConfigManager
 
- (instancetype)init
{
    if (self = [super init])
    {
        
    }
    return self;
}

+ (instancetype)shareHttpConfigManager
{
    static BaseHttpConfigManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[BaseHttpConfigManager alloc]init];
    });
    return manager;
}

- (void)setupHttpEngineWithConfig:(id<HttpConfigDataSource>)config
{
    self.config = config;
}

@end
