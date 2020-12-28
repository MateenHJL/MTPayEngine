#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "BaseNavigationController.h"
#import "BaseTabbarController.h"
#import "BaseTabbarItem.h"
#import "BaseViewController.h"
#import "BaseWebviewController.h"
#import "XLJSHandler.h"
#import "ButtonViewModel.h"
#import "UIView+Frame.h"
#import "BaseViewControllerConfigManager.h"
#import "BaseViewControllerProtocol.h"
#import "BasePch.h"

FOUNDATION_EXPORT double BaseViewControllerManagerVersionNumber;
FOUNDATION_EXPORT const unsigned char BaseViewControllerManagerVersionString[];

