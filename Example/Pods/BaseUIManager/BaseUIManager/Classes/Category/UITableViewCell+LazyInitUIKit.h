//
//  UITableViewCell+LazyInitUIKit.h
//  YouShuLa
//
//  Created by Teen Ma on 2018/12/17.
//  Copyright © 2018 YouShuLa_IOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonFile.h"

@interface UITableViewCell (LazyInitUIKit)

- (void)lazyInitAllSubViewUIWithAutolayoutEnable:(BOOL)autolayoutEnable;

@end

