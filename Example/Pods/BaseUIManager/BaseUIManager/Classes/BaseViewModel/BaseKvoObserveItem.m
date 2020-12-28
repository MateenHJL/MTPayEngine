//
//  BaseKvoObserveItem.m
//  SumanSoul_Coach
//
//  Created by mateen on 2020/4/9.
//  Copyright © 2020 Mateen. All rights reserved.
//

#import "BaseKvoObserveItem.h"

@implementation BaseKvoObserveItem

- (instancetype)initWithKvoObserverKeyPath:(NSString *)keyPath viewKeyPath:(NSArray<NSString *> *)uiKeyPath valueHasBeenModifiedCompletedUsing:(valueHasBeenModifiedBlock)block
{
    if (self = [super init])
    {
        _keyPath = keyPath;
        _uiKeyPaths = uiKeyPath;
        _block = [block copy];
    }
    return self;
}

@end
