//
//  AdjustCommonFile.h
//  Pods
//
//  Created by mateen on 2020/12/16.
//

#ifndef AdjustCommonFile_h
#define AdjustCommonFile_h

//adjustTheFont depends on whatever your device is.
#define kAdjustFont(x) [UIFont adjustFontFromFontSize:x]

//define Something for devices
#define  yScreenWidth   [UIScreen mainScreen].bounds.size.width
#define  yScreenHeight  [UIScreen mainScreen].bounds.size.height

//navigationBar height
#define kNavigationBarHeight ((kIPhoneX || kIPhoneXR || kIPhoneXS || kIPhoneXSMax) ? 68 : 44)

//statusBar height
#define kStatusBarHeight 20

//navigationSafetySpaceHeight
#define kNavigationTopSpace ((kIPhoneX || kIPhoneXR || kIPhoneXS || kIPhoneXSMax) ? 24 : 0)

//bottomSafetySpaceHeight
#define kIphoneXBottomSpace ((kIPhoneX || kIPhoneXR || kIPhoneXS || kIPhoneXSMax) ? 34 : 0)

//StatusBarHeight + navigationBarHeight
#define kNavigationHeight ((kIPhoneX || kIPhoneXR || kIPhoneXS || kIPhoneXSMax) ? 88 : 64)

//tabbar高度
#define kTabbarHeight ((kIPhoneX || kIPhoneXR || kIPhoneXS || kIPhoneXSMax) ? 83 : 49)

//是否是iphone
#define kIsIPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//是否是ipad
#define kIsIpad (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)

//adjustPercentSize depends on whatever your device is ,（your device physical height / iphone 6's physical height）
#define kPercentageHeight(height) (yScreenHeight *(height)/667)
#define kPercentageWidth(width) (yScreenWidth / 375 * width)

//the current device is Retina or not device;
#define kIsRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

//the current device is iphone or not
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//if it was Ipad
#define kisPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

//if it was iphone 4
#define kIphone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !kisPad : NO)

//if it was iphone 5
#define kIphone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !kisPad : NO)

//if it was iphone 6
#define kIphone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !kisPad : NO)

//if it was iphone 6p
#define kIphone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !kisPad : NO)

//if it was iphone x
#define kIPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !kisPad : NO)

//if it was iphone xr
#define kIPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !kisPad : NO)

//if it was iphone xs
#define kIPhoneXS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !kisPad : NO)

//if it was iphone xs max
#define kIPhoneXSMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !kisPad : NO)
 
//the current systemVersion is iOS 10.0 or not
#define IOS10_OR_LATER ([[[[[UIDevice currentDevice] systemVersion] substringToIndex:1] stringByAppendingString:@"0"] intValue] == 10)

//the current systemVersion is iOS 11.0 or not
#define IOS11_OR_LATER ([[UIDevice currentDevice].systemVersion intValue] >= 11)

#endif /* AdjustCommonFile_h */
