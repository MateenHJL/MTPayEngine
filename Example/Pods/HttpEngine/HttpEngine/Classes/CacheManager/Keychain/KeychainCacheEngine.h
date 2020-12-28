//
//  KeychainCacheEngine.h
//  HotelGGIOS
//
//  Created by MaTeen on 15/12/25.
//  Copyright © 2015年 MaTeen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeychainCacheEngine : NSObject

+ (void)saveToKeyChainWithData:(id)data andKey:(NSString *)key;

@end
