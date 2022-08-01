//
//  MTViewController.m
//  PayEngine
//
//  Created by 455528514@qq.com on 12/22/2020.
//  Copyright (c) 2020 455528514@qq.com. All rights reserved.
//

#import "MTViewController.h"
#import <HttpEngine/httpCommonFile.h>
#import <AlipaySDK/AlipaySDK.h>
#import "AliPayItem.h"
#import "PayEngine.h"

#define kAA @"app_id=2021001178694244&method=alipay.trade.app.pay&charset=utf-8&sign_type=RSA2&timestamp=2020-12-28%2013%3A44%3A02&version=1.0&biz_content=%7B%22out_trade_no%22%3A%22QBCZ20201128134424888ALI10216%22%2C%22subject%22%3A%22App%E5%85%85%E5%80%BC%22%2C%22total_amount%22%3A%220.01%22%2C%22body%22%3A%22%E9%92%B1%E5%8C%85%E5%85%85%E5%80%BC%22%2C%22goods_detail%22%3A%5B%7B%22goods_id%22%3A%22%E9%92%B1%E5%8C%85%E5%85%85%E5%80%BC%22%2C%22goods_name%22%3A%22pay%22%2C%22quantity%22%3A1%2C%22price%22%3A2000%7D%5D%7D&notify_url=http%3A%2F%2F8.210.144.226%3A9999%2FaliPayCallback%2FaliPayPayCallback&sign=tuB60KUFZcVnGoE8wQMPWtplpRQ1UVOLbeS1IgPbKScPgb%2F7AgEKYB41S3hyJnk17SgqcpI6FV5LQG7%2FRwFl0dj2SFXtOgPFK2td8U2X05lmXRYg1vUm9q3%2FvH%2FBzrRZUITelSZtb4w%2F5a3OQUlmoQM9qYMBInjfDHndbHnnRxKoVP4omBdK7TYvEVtMlVC7JKU3AXqzJW8FOVSD3L1xAtZxM9o5sQLjIurIs65uYnS%2FIfD7vTNzj1er63V0eeTczzUOqeBmYKqxYUd2Q6ZBioMDSSyUkhfjJD5r4fC5j3XKCA7GUy0KjJEWO8NuYN6ge1YmIXBi5uR4zjmVLK69Mw%3D%3D"
#define kBB @"app_id=2019090366832810&biz_content=%7B%22subject%22%3A%22%E5%B0%8F%E6%B1%97%E5%95%86%E5%93%81%E6%B5%8B%E8%AF%95%E4%B8%93%E7%94%A8%22%2C%22out_trade_no%22%3A%22Pro20201228161505000724%22%2C%22total_amount%22%3A%220.01%22%2C%22product_code%22%3A%22%22%2C%22time_expire%22%3A%222020-12-28+16%3A45%22%7D&charset=utf-8&format=JSON&method=alipay.trade.app.pay&notify_url=https%3A%2F%2Ftestgo.sumansoul.com%2Fm%2Fapp%2Fali%2Fpay%2Fcallback%2F1&sign=PEBdtQdkMv23ULpYeV4S5cQ1QQaUEnEmTdWHK2kheaHeMwjTDSus6zr8KVkA4UuFreh%2Fi039c9p6GWlmouleGfyxIxKg3%2Bfah5peO2cETijdf9%2BhaoymScBTNy6uAphrVjwOqFZcOnTKP0V%2BXbynU4HFzJzU7RJg5Y65uMMHXOKJm7KTmt%2BWgvnEoP5APK1biKUOdZlBVxeBGPQfEi4UrJ8X8QDI5PSHHL7aThEIG5TZyP0prDa%2Bk5rm%2FVyY6FWv1%2FUv82Nm2HjGXpDCxKz%2BVUf7hs2Af3vCcL5ZKhE7sBen6lhdaROzATO2Vbt2c0tzphiH5FHjmyapf5vJRP2AtQ%3D%3D&sign_type=RSA2&timestamp=2020-12-28+16%3A15%3A05&version=1.0"

@interface MTViewController ()

@end

@implementation MTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    WechatPayItem *item = [[WechatPayItem alloc] init];
//    item.partnerId = @"1501454621";
//    item.nonceStr = @"BrxklFup20UpqCg8";
//    item.package = @"Sign=WXPay";
//    item.prepayId = @"wx28171829732044788747628033f3b90000";
//    item.timeStamp = 1609147109;
//    item.sign = @"QBCZ202011281718295768WX37196";
//    [[PayEngine sharePayEngine] startPayWithItem:item completedUsing:^(PayDataModel * _Nonnull dataModel) {
//
//    }];
    
    
    AliPayItem *item = [[AliPayItem alloc] init];
    item.payOrder = kBB;
    [[PayEngine sharePayEngine] startPayWithItem:item completedUsing:^(PayDataModel * _Nonnull dataModel) {

    }];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
