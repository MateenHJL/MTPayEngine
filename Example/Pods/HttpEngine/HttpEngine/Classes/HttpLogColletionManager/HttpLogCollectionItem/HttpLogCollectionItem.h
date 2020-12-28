//
//  HttpLogCollectionItem.h
//  YouSuHuoPinPoint
//
//  Created by Teen Ma on 2017/12/25.
//  Copyright © 2017年 Teen Ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseSqliteItem;
@class HttpLogInformationDataModel;
@class BaseHttpItem;

@interface HttpLogCollectionItem : NSObject

+ (BaseSqliteItem *)createTableItem;

+ (BaseSqliteItem *)configInsertStatementWithDataModel:(HttpLogInformationDataModel *)dataModel;

+ (BaseSqliteItem *)convertHttpItemWithSqliteItemWithHttpItem:(BaseHttpItem *)item;

+ (BaseSqliteItem *)convertPushDataWithSqliteItemWithPushDataDic:(NSDictionary *)pushDic;

+ (BaseSqliteItem *)selectAllHttpLogWithMark:(NSString *)mark;

//return the array<HttpLogInformationDataModel *>depends on day and your key;
+ (BaseSqliteItem *)selectOneDayLogInformationWithDay:(NSString *)day searchKey:(NSString *)key andMark:(NSString *)mark;

+ (BaseSqliteItem *)selectDebugLogWithLogid:(NSString *)logId;

+ (BaseSqliteItem *)deleteAllLog;

@end
