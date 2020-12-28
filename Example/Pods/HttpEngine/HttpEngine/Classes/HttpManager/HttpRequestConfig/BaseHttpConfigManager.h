//
//  BaseHttpConfigManager.h
//  DateTools
//
//  Created by mateen on 2020/12/21.
//

#import <Foundation/Foundation.h>
#import "HttpSessionRequestConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseHttpConfigManager : NSObject

@property (nonatomic, readonly  ) id<HttpConfigDataSource> config;

//share config
+ (instancetype)shareHttpConfigManager;

//initConfig file
- (void)setupHttpEngineWithConfig:(id<HttpConfigDataSource>)config;


@end

NS_ASSUME_NONNULL_END
