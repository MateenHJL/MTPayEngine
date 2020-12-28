//
//  BasePch.h
//  Pods
//
//  Created by mateen on 2020/12/18.
//

#ifndef BasePch_h
#define BasePch_h

#define MTWeakBlock(type)  __weak typeof(type) weak##type = type;

#import <BaseUIManager/CommonFile.h>
#import <HttpEngine/httpCommonFile.h>
#import "BaseViewController.h"
#import "BaseWebviewController.h"
#import "BaseNavigationController.h"
#import "BaseTabbarItem.h"
#import "BaseTabbarController.h"
#import "BaseViewControllerConfigManager.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

#endif /* BasePch_h */
