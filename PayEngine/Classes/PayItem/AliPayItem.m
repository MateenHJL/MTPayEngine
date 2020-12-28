//
//  AliPayItem.m
//  austrailia_IOS
//
//  Created by mateen on 2020/7/7.
//  Copyright © 2020 Mateen. All rights reserved.
//

#import "AliPayItem.h"
#import <AlipaySDK/AlipaySDK.h>
#import "PayDataModel.h"

@implementation AliPayItem

- (void)startPay
{
    [[AlipaySDK defaultService] payOrder:self.payOrder fromScheme:@"AustriliaPlayAlipay" callback:^(NSDictionary *resultDic) {
        
    }];
}

- (void)handleResponse:(NSDictionary *)result;
{
    PayDataModel *model = [[PayDataModel alloc] init];
    model.originData = result;
    NSInteger resultStatus = [result[@"resultStatus"] integerValue];
    switch (resultStatus)
    {
        case 9000:
        {
            model.isSuccessed = YES;
            model.msg = @"订单支付成功";
        }
            break;
        case 4000:
        {
            model.isSuccessed = NO;
            model.msg = @"订单支付失败";
        }
            break;
        case 5000:
        {
            model.isSuccessed = NO;
            model.msg = @"重复请求";
        }
            break;
        case 6001:
        {
            model.isSuccessed = NO;
            model.msg = @"用户中途取消";
        }
            break;
        default:
            break;
    }
    if (self.completedBlock)
    {
        self.completedBlock(model);
    }
}

@end
