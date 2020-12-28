//
//  BaseTableViewCell.h
//  Express_ios
//
//  Created by Mateen on 16/3/28.
//  Copyright © 2016年 MaTeen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonFile.h"
#import <MGSwipeTableCell/MGSwipeTableCell.h>

@class BaseViewModel;

@interface BaseTableViewCell : MGSwipeTableCell

@property (nonatomic,weak) id delegate;

//controller should send message on it that reloadTableViewCell when data is Reload
- (void)resetCellWithViewModel:(BaseViewModel *)model;

//calculated the height from model.
+ (CGFloat)currentCellHeightWithViewModel:(BaseViewModel *)model;


@end
