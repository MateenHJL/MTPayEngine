//
//  BaseController.h
//  ToolsApplication
//
//  Created by Mateen on 14/10/30.
//  Copyright (c) 2014年 Mateen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewControllerConfigManager.h"

@class ButtonViewModel;

@interface BaseViewController : UIViewController

@property (nonatomic, copy  ) NSString         *remarkTitle;

//modify statusbar's backgroundColor
@property (nonatomic, strong) UIColor          *statusBarBackgroundColor;

//modify Status bar Style
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

//wether navigationBar is hidden
@property (nonatomic, assign) BOOL             shouldHiddenNavigationBar;

//wether has backButton
@property (nonatomic, assign) BOOL             shouldShowBackButton;
 
//create more button with buttonArray for leftNavigationItem
- (void)createLeftNavigationItemWithButtonViewModels:(NSArray <ButtonViewModel *> *)buttonViewModelArray target:(id)target;

//create more button with buttonArray for rightNavigationItem
- (void)createRightNavigationItemWithButtonViewModels:(NSArray <ButtonViewModel *> *)buttonViewModelArray target:(id)target;

//selector of LeftButton
- (void)baseControllerClickLeftButton:(UIButton *)button;

//selector of RightButton
- (void)baseControllerClickRightButton:(UIButton *)button;

@end
