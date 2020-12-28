//
//  BaseKvoObserveItem.h
//  SumanSoul_Coach
//
//  Created by mateen on 2020/4/9.
//  Copyright © 2020 Mateen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonFile.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseKvoObserveItem : NSObject

@property (nonatomic, readonly) NSString *keyPath;
@property (nonatomic, copy    ) valueHasBeenModifiedBlock block;
@property (nonatomic, readonly) NSArray <NSString *> *uiKeyPaths;

- (instancetype)initWithKvoObserverKeyPath:(NSString *)keyPath viewKeyPath:(NSArray <NSString *> *)uiKeyPath valueHasBeenModifiedCompletedUsing:(valueHasBeenModifiedBlock)block;

@end

NS_ASSUME_NONNULL_END
