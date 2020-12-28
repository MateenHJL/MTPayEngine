//
//  UIView+LazyInitUIKit.h
//  EducationSPKIOS
//
//  Created by Teen Ma on 2019/3/4.
//  Copyright © 2019 Teen Ma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonFile.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LazyInitUIKit)

- (void)lazyInitAllSubViewUIWithAutolayoutEnable:(BOOL)autolayoutEnable;

@end

NS_ASSUME_NONNULL_END
