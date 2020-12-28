//
//  BaseNavigationController.h
//  ToolsApplication
//
//  Created by Mateen on 14/11/20.
//  Copyright (c) 2014年 Mateen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController
 
/*!
 *  返回到指定的类视图
 *
 *  @param ClassName 类名
 *  @param animated  是否动画
 */
-(BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated;

@end
