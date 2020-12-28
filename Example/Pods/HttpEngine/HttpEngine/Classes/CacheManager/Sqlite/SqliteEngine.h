//
//  MTSqlite.h
//  TestMTModel
//
//  Created by Mateen on 14-1-3.
//  Copyright (c) 2014年 Mateen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseModel;
@class BaseSqliteItem;

typedef void(^sqliteEngineExecuteCompletedBlock)(BOOL isSuccessed, NSString *operatedError);
typedef void(^sqliteEngineSelectedCompletedBlock)(BOOL isSuccessed,NSArray *result);

@interface SqliteEngine : NSObject

//init SqliteEngine;
+ (instancetype)shareEngine;

//open collectied log Info
- (void)configTableInformationWithSqliteItem:(BaseSqliteItem *)item completedWithBlock:(sqliteEngineExecuteCompletedBlock)completedBlock;

//excuted Statement from item <for sqliteItem>
- (void)excutedWithSqiteItem:(BaseSqliteItem *)item completedWithBlock:(sqliteEngineExecuteCompletedBlock)completedBlock;

//select data from Sqlite <for Controller>
- (void)selectDataWithStatement:(BaseSqliteItem *)item completedWithBlock:(sqliteEngineSelectedCompletedBlock)completedBlock;

@end
