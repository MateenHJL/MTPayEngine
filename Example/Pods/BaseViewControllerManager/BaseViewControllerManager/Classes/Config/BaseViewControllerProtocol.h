//
//  BaseViewControllerProtocol.h
//  Pods
//
//  Created by mateen on 2020/12/21.
//

#import <Foundation/Foundation.h>

@protocol BaseViewControllerConfigDataSource <NSObject>

@property (nonatomic, strong) UIFont   *defaultNavigationTitleFont;
@property (nonatomic, strong) UIColor  *defaultNavigationTextColor;
@property (nonatomic, strong) UIColor  *defaultStatusBarBackgroundColor;
@property (nonatomic, strong) UIColor  *defaultViewBackground;
@property (nonatomic, strong) UIImage  *defaultBackIcon;

@end
