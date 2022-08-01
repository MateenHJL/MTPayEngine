//
//  PayEngine.m
//  austrailia_IOS
//
//  Created by mateen on 2020/7/7.
//  Copyright © 2020 Mateen. All rights reserved.
//

#import "PayEngine.h"
#import "BasePayItem.h"
#import "PaymentConfigManager.h"
#import "WXApi.h" 
#import "AliPayItem.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation PayEngine

+ (instancetype)sharePayEngine
{
    static dispatch_once_t onceToken;
    static PayEngine *engine = nil;
    dispatch_once(&onceToken, ^{
        engine = [[self alloc] init];
    });
    return engine;
}

- (instancetype)init
{
    if (self = [super init])
    {
        NSAssert([PaymentConfigManager sharePaymentConfigManager].config, @"there's no paymentConfig in PaymentConfigManager,please called [[PaymentConfigManager sharePaymentConfigManager] setupPaymentEngineWithConfig:] when your application launched first");
        
        if ([PaymentConfigManager sharePaymentConfigManager].config.weChatAppId.length > 0 && [PaymentConfigManager sharePaymentConfigManager].config.weChatRedirectUrl.length > 0)
        {
            [WXApi registerApp:[PaymentConfigManager sharePaymentConfigManager].config.weChatAppId universalLink:[PaymentConfigManager sharePaymentConfigManager].config.weChatRedirectUrl];
        }
    }
    return self;
}

- (void)startPayWithItem:(BasePayItem *)item completedUsing:(nonnull payEngineSuccessfulBlock)completedBlock
{
    _currentPayItem = item;
    [item startPay];
    [item setCompletedBlock:^(PayDataModel * _Nonnull dataModel) {
        if (completedBlock)
        {
            completedBlock (dataModel);
        }
    }];
}

- (BOOL)checkCallBackWithUrl:(NSURL *)url
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            AliPayItem *item = (AliPayItem *)[[PayEngine sharePayEngine] currentPayItem];
            if (item)
            {
                [item handleResponse:resultDic];
            }
        }];
        return YES;
    }
    else if ([url.scheme isEqualToString:[PaymentConfigManager sharePaymentConfigManager].config.weChatAppId])
    {
        BOOL result = [WXApi handleOpenURL:url delegate:[[PayEngine sharePayEngine] currentPayItem]];
        return result;
    }
    return NO;
}

@end
