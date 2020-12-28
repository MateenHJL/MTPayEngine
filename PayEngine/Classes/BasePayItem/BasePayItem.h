//
//  BasePayItem.h
//  austrailia_IOS
//
//  Created by mateen on 2020/7/7.
//  Copyright © 2020 Mateen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class PayDataModel;

typedef void(^payItemCompletedBlock)(PayDataModel *dataModel);

@interface BasePayItem : NSObject 

@property (nonatomic, copy  ) payItemCompletedBlock completedBlock;

- (void)startPay;

@end

NS_ASSUME_NONNULL_END
