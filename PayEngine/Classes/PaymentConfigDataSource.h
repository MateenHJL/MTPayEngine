//
//  PaymentConfigDataSource.h
//  Pods
//
//  Created by mateen on 2020/12/28.
//

#ifndef PaymentConfigDataSource_h
#define PaymentConfigDataSource_h

@protocol PaymentConfigDataSource <NSObject>

@property (nonatomic, copy  ) NSString *weChatAppId;
@property (nonatomic, copy  ) NSString *weChatRedirectUrl;

@end

#endif /* PaymentConfigDataSource_h */
