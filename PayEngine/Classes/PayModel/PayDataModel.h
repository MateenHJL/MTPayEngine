//
//  PayDataModel.h
//  austrailia_IOS
//
//  Created by mateen on 2020/7/7.
//  Copyright © 2020 Mateen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PayDataModel : NSObject

@property (nonatomic, assign  ) BOOL isSuccessed;
@property (nonatomic, copy    ) NSString *msg;
@property (nonatomic, strong  ) id originData;

@end

NS_ASSUME_NONNULL_END
