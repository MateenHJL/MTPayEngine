//
//  HttpLogicHandleManager.m
//  MTTemplate
//
//  Created by Mateen on 2017/1/16.
//  Copyright © 2017年 Teen ma. All rights reserved.
//

#import "HttpLogicHandleManager.h"
#import "Reachability.h"
#import "BaseHttpItem.h"

@implementation HttpLogicHandleManager

+ (BOOL)networkCanBeReached
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;

    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;

    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);

    if (!didRetrieveFlags) {
        printf("Error. Count not recover network reachability flags\n");
        return NO;
    }

    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

+ (BOOL)isHttpUrlCorrectWithItem:(BaseHttpItem *)item
{
    BOOL result = YES;
    if (!item.httpRequestAbsoluteUrlString || item.httpRequestAbsoluteUrlString.length == 0)
    {
        result = NO;
    }
    return result;
}

+ (BOOL)isMockResponseStatusWithItem:(BaseHttpItem *)item
{
    BOOL result = YES;
    if (!item.httpResponseIsMockStatus)
    {
        result = NO;
    }
    return result;
}

@end
