//
//  PaymentConfigManager.m
//  BaseUIManager
//
//  Created by mateen on 2020/12/28.
//

#import "PaymentConfigManager.h"
 
@interface PaymentConfigManager ()
 
@end

@implementation PaymentConfigManager

- (instancetype)init
{
    if (self = [super init])
    {
         
    }
    return self;
}

+ (instancetype)sharePaymentConfigManager
{
    static PaymentConfigManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PaymentConfigManager alloc]init];
    });
    return manager;
}

- (void)setupPaymentEngineWithConfig:(id<PaymentConfigDataSource>)config
{
    _config = config;
}


@end
