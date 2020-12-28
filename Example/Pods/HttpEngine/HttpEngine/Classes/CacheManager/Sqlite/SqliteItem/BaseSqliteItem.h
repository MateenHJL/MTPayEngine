//
//  BaseSqliteItem.h
//  CustomerTemplate
//
//  Created by caimiao on 15/5/5.
//  Copyright (c) 2015年 caimiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseSqliteItem : NSObject

//the statement of create table.
@property (nonatomic,copy  ) NSString *operateStatement;

//the state of Execute.
@property (nonatomic,copy  ) NSString *configTableStatement;

//the dataModel class if your type of configTableStatement is Select
@property (nonatomic,strong) Class selectedDataModelClass;

@end
