//
//  KeychainCacheEngine.m
//  HotelGGIOS
//
//  Created by MaTeen on 15/12/25.
//  Copyright © 2015年 MaTeen. All rights reserved.
//

#import "KeychainCacheEngine.h"

@implementation KeychainCacheEngine

+ (NSMutableDictionary *)currentKeyChainQuery:(NSString *)service
{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge_transfer id)kSecClassGenericPassword,(__bridge_transfer id)kSecClass,
            service, (__bridge_transfer id)kSecAttrService,
            service, (__bridge_transfer id)kSecAttrAccount,
            (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,(__bridge_transfer id)kSecAttrAccessible,
            nil];
}

@end
