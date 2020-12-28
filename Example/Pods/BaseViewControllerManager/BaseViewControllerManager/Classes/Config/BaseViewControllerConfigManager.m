//
//  BaseViewControllerConfigManager.m
//  BaseUIManager
//
//  Created by mateen on 2020/12/21.
//

#import "BaseViewControllerConfigManager.h"

@interface BaseViewControllerConfigManager ()

@property (nonatomic, strong    ) id<BaseViewControllerConfigDataSource> config;

@end

@implementation BaseViewControllerConfigManager
 
- (instancetype)init
{
    if (self = [super init])
    {
        
    }
    return self;
}

+ (instancetype)shareHttpConfigManager
{
    static BaseViewControllerConfigManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[BaseViewControllerConfigManager alloc]init];
    });
    return manager;
}

- (void)setupHttpEngineWithConfig:(id<BaseViewControllerConfigDataSource>)config
{
    self.config = config;
}
 

@end
