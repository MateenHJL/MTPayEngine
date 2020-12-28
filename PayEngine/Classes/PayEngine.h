//
//  PayEngine.h
//  austrailia_IOS
//
//  Created by mateen on 2020/7/7.
//  Copyright © 2020 Mateen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BasePayItem;
@class CommonLogicDataModel;
@class PayDataModel;

typedef void(^payEngineSuccessfulBlock)(PayDataModel *dataModel);
typedef void(^payEngineFailedBlock)(CommonLogicDataModel *dataModel);

@interface PayEngine : NSObject

@property (nonatomic, readonly ) BasePayItem *currentPayItem;

+ (instancetype)sharePayEngine;

- (void)startPayWithItem:(BasePayItem *)item completedUsing:(payEngineSuccessfulBlock)completedBlock;

- (BOOL)checkCallBackWithUrl:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
