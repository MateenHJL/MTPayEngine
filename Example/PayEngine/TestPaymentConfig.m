//
//  TestPaymentConfig.m
//  PayEngine_Example
//
//  Created by mateen on 2020/12/28.
//  Copyright © 2020 455528514@qq.com. All rights reserved.
//

#import "TestPaymentConfig.h"

#define kWechatAppId @"wx06ce8c1cdbd8d671"
#define kWechatAppSecret @"2723649fe04637a7edd738ae2b2e34b9"
#define kWechatLoginKey @"kWechatLoginKey"
#define kWechatRedirectURL @"https://app.sumansoul.com/go_html/suman_web/"

@implementation TestPaymentConfig

@synthesize weChatAppId = _weChatAppId;
@synthesize weChatRedirectUrl = _weChatRedirectUrl;

- (NSString *)weChatAppId
{
    return kWechatAppId;
}

- (NSString *)weChatRedirectUrl
{
    return kWechatRedirectURL;
}

@end
