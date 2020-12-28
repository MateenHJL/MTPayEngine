//
//  BaseTabbarController.h
//  CustomerTemplate
//
//  Created by Mateen on 15/5/22.
//  Copyright (c) 2015年 caimiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseNavigationController;

@class BaseTabbarItem;

@protocol BaseTabbarControllerSelectedDelegate;

@interface BaseTabbarController : UITabBarController

@property (nonatomic,weak) id<BaseTabbarControllerSelectedDelegate> selectedDelegate;

- (void)resetTabbarForDataModelArray:(NSMutableArray *)modelArray;

- (void)refreshTabbarItemWithTabbarItem:(BaseTabbarItem *)tabbarItem;

@end

@protocol BaseTabbarControllerSelectedDelegate <NSObject>

- (void)baseTabbarControllerDidSelectedIndex:(NSInteger)selectedIndex currentIndex:(NSInteger)currentIndex choosedViewController:(BaseNavigationController *)controller;

@end
