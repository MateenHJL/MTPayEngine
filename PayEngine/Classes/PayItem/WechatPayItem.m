//
//  WechatPayItem.m
//  austrailia_IOS
//
//  Created by mateen on 2020/7/7.
//  Copyright © 2020 Mateen. All rights reserved.
//

#import "WechatPayItem.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "PayDataModel.h"

@interface WechatPayItem () <WXApiDelegate>

@end

@implementation WechatPayItem

- (instancetype)init
{
    if (self = [super init])
    {
        
    }
    return self;
}

- (void)startPay
{
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = self.partnerId;
    request.prepayId = self.prepayId;
    request.package  = self.package;
    request.nonceStr = self.nonceStr;
    request.timeStamp= self.timeStamp;
    request.sign = self.sign;
    [WXApi sendReq:request completion:^(BOOL success) {
        
    }];
}

- (void)onReq:(BaseReq*)req;
{
    
}

- (void)onResp:(BaseResp*)resp;
{
    PayDataModel *model = [[PayDataModel alloc] init];
    switch (resp.errCode)
    {
        case WXSuccess:
        {
            model.isSuccessed = YES;
            model.msg = @"成功";
        }
            break;
        case WXErrCodeUserCancel:
        {
            model.isSuccessed = NO;
            model.msg = @"用户点击取消";
        }
            break;
        case WXErrCodeSentFail:
        {
            model.isSuccessed = NO;
            model.msg = @"发送失败";
        }
            break;
        default:
            break;
    }
    model.originData = resp;
    if (self.completedBlock)
    {
        self.completedBlock(model);
    }
}

@end
