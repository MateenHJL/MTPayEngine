//
//  BaseTabbarItem.h
//  CustomerTemplate
//
//  Created by Moyun on 15/5/22.
//  Copyright (c) 2015年 caimiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseTabbarItem : NSObject

@property (nonatomic,copy  ) NSString *rootControllerName;
@property (nonatomic,strong) UIImage  *normalImage;
@property (nonatomic,strong) UIImage  *selectedImage;
@property (nonatomic,copy  ) NSString *normalTitle;
@property (nonatomic,assign) NSInteger tabbarItemType;
@property (nonatomic,copy  ) NSString *badgeValue;


@end
