//
//  AliPayItem.h
//  austrailia_IOS
//
//  Created by mateen on 2020/7/7.
//  Copyright © 2020 Mateen. All rights reserved.
//

#import "BasePayItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface AliPayItem : BasePayItem

- (void)handleResponse:(NSDictionary *)result;

@property (nonatomic, copy  ) NSString *payOrder;

@end

NS_ASSUME_NONNULL_END
