//
//  WechatPayItem.h
//  austrailia_IOS
//
//  Created by mateen on 2020/7/7.
//  Copyright © 2020 Mateen. All rights reserved.
//

#import "BasePayItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface WechatPayItem : BasePayItem

@property (nonatomic, copy  ) NSString *partnerId;
@property (nonatomic, copy  ) NSString *package;
@property (nonatomic, copy  ) NSString *prepayId;
@property (nonatomic, copy  ) NSString *nonceStr;
@property (nonatomic, assign) UInt32   timeStamp;
@property (nonatomic, copy  ) NSString *sign;

@end

NS_ASSUME_NONNULL_END
