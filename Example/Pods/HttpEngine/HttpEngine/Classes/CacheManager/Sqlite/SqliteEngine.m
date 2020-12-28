//
//  MTSqlite.m
//  TestMTModel
//
//  Created by Mateen on 14-1-3.
//  Copyright (c) 2014年 Mateen. All rights reserved.
//

#import "SqliteEngine.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "BaseSqliteItem.h"
#import <YYKit/YYKit.h>

#define kSqlietePathName @"httpCollectionSqlite.sqlite"

@interface SqliteEngine ()
{
    FMDatabase *database;
    FMDatabaseQueue *sqliteQueue;
}

@end

static SqliteEngine *sqliteSingleTon = nil;

@implementation SqliteEngine

- (instancetype)init
{
    if (self = [super init])
    {
        [self createDataBase];
    }
    return self;
}

#pragma mark 初始化数据
+ (instancetype)shareEngine
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sqliteSingleTon = [[SqliteEngine alloc] init];
    });
    return sqliteSingleTon;
}

#pragma mark 创建数据库db
- (void)createDataBase
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = paths[0];
    NSString *databasePath = [path stringByAppendingPathComponent:kSqlietePathName];
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isExist = [manager fileExistsAtPath:databasePath isDirectory:NULL];
    database = [FMDatabase databaseWithPath:databasePath];
    sqliteQueue = [FMDatabaseQueue databaseQueueWithPath:databasePath];
    if (!isExist)
    {
        NSError *error = nil;
        [manager createDirectoryAtPath:databasePath withIntermediateDirectories:YES attributes:nil error:&error];
    }
}

- (void)configTableInformationWithSqliteItem:(BaseSqliteItem *)item completedWithBlock:(sqliteEngineExecuteCompletedBlock)completedBlock
{
    if ([database open])
    {
        [sqliteQueue inDatabase:^(FMDatabase *db) {
            BOOL flag = [db executeUpdate:item.configTableStatement];
            NSString *sqliteError = @"";
            if (!flag)
            {
                sqliteError = @"创建表失败";
            }
            if (completedBlock)
            {
                completedBlock (flag , sqliteError);
            }
        }];
    }
}

- (void)excutedWithSqiteItem:(BaseSqliteItem *)item completedWithBlock:(sqliteEngineExecuteCompletedBlock)completedBlock
{
    if (![database open])
    {
        if (completedBlock)
        {
            completedBlock (NO , @"数据库打开失败");
        }
        return;
    }
    
    [database open];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = paths[0];
    NSString *databasePath = [path stringByAppendingPathComponent:kSqlietePathName];
    FMDatabaseQueue *tmpSqliteQueue = [FMDatabaseQueue databaseQueueWithPath:databasePath];
    [tmpSqliteQueue inDatabase:^(FMDatabase *db) {
        BOOL flag = [db executeUpdate:item.operateStatement];
        NSString *sqliteError = @"";
        if (!flag)
        {
            sqliteError = @"数据库操作失败";
        }
        if (completedBlock)
        {
            completedBlock (flag , sqliteError);
        }
    }];
}

- (void)selectDataWithStatement:(BaseSqliteItem *)item completedWithBlock:(sqliteEngineSelectedCompletedBlock)completedBlock
{
    if (![database open])
    {
        if (completedBlock)
        {
            completedBlock (NO , [NSArray array]);
        }
        return;
    }

    [database open];
    [sqliteQueue inDatabase:^(FMDatabase *db) {
        NSMutableArray *resultArray = [NSMutableArray array];
        FMResultSet *result = [db executeQuery:item.operateStatement];
        while ([result next])
        {
            NSDictionary *resultDic = [result resultDictionary];
            id classModel = [item.selectedDataModelClass modelWithDictionary:resultDic];
            [resultArray addObject:classModel];
        }
        if (completedBlock)
        {
            completedBlock (YES , resultArray);
        }
    }];
}

- (void)closeSqliteEngine
{
    [database close];
}
@end
