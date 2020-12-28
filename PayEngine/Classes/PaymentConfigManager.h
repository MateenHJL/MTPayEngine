//
//  PaymentConfigManager.h
//  BaseUIManager
//
//  Created by mateen on 2020/12/28.
//

#import <Foundation/Foundation.h>
#import "PaymentConfigDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface PaymentConfigManager : NSObject

@property (nonatomic, readonly  ) id<PaymentConfigDataSource> config;

//share config
+ (instancetype)sharePaymentConfigManager;

//initConfig file
- (void)setupPaymentEngineWithConfig:(id<PaymentConfigDataSource>)config;

@end

NS_ASSUME_NONNULL_END
