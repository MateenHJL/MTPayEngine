//
//  BaseViewControllerConfigManager.h
//  Pods
//
//  Created by mateen on 2020/12/21.
//
 
#import <Foundation/Foundation.h>
#import "BaseViewControllerProtocol.h"

@interface BaseViewControllerConfigManager : NSObject

@property (nonatomic, readonly  ) id<BaseViewControllerConfigDataSource> config;

//share config
+ (instancetype)shareHttpConfigManager;

//initConfig file
- (void)setupHttpEngineWithConfig:(id<BaseViewControllerConfigDataSource>)config;
 
@end
