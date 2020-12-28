//
//  MTAppDelegate.m
//  PayEngine
//
//  Created by 455528514@qq.com on 12/22/2020.
//  Copyright (c) 2020 455528514@qq.com. All rights reserved.
//

#import "MTAppDelegate.h"

#import <PayEngine/PaymentCommentFile.h>
#import <WXApi.h>
#import <AlipaySDK/AlipaySDK.h>
#import "TestPaymentConfig.h"

#define kWechatAppId @"wx06ce8c1cdbd8d671"
#define kWechatAppSecret @"2723649fe04637a7edd738ae2b2e34b9"
#define kWechatLoginKey @"kWechatLoginKey"
#define kWechatRedirectURL @"https://app.sumansoul.com/go_html/suman_web/"

@implementation MTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //微信
    [[PaymentConfigManager sharePaymentConfigManager] setupPaymentEngineWithConfig:[[TestPaymentConfig alloc] init]];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    if (url.absoluteString.length == 0)
    {
        return NO;
    }
    return [[PayEngine sharePayEngine] checkCallBackWithUrl:url];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if (url.absoluteString.length == 0)
    {
        return NO;
    }
    return [[PayEngine sharePayEngine] checkCallBackWithUrl:url];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if (url.absoluteString.length == 0)
    {
        return NO;
    }
    return [[PayEngine sharePayEngine] checkCallBackWithUrl:url];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
