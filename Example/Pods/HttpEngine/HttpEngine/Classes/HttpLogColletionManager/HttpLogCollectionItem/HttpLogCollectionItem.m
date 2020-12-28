//
//  HttpLogCollectionItem.m
//  YouSuHuoPinPoint
//
//  Created by Teen Ma on 2017/12/25.
//  Copyright © 2017年 Teen Ma. All rights reserved.
//

#import "HttpLogCollectionItem.h"
#import "HttpLogInformationDataModel.h"
#import "BaseSqliteItem.h"
#import "BaseHttpItem.h"
#import "BaseHttpConfigManager.h"

//http cache mark
#define Kmark(markString) [NSString stringWithFormat:@"mark_%@_mark",markString]


#define kMark                        @"mark"
#define kDisplayDescription          @"displayDescription"
#define kHttpCollectedLogCenterTable @"HttpCollectedLogCenterTable"
#define kId                          @"id"
#define kCreateTimeStamp             @"createTimeStamp"
#define kLogType                     @"logType"
#define kCreateTime                  @"createTime"
#define kBusinessDescription         @"businessDescription"
#define kHttpMethod                  @"httpMethod"
#define kPostParams                  @"postParams"
#define kHeader                      @"header"
#define kResponseData                @"responseData"
#define kStatusCode                  @"statusCode"
#define kResponseDataType            @"responseDataType"
#define kHttpDebugMessage            @"httpDebugMessage"
#define kCreateDay                   @"createDay"
#define kHttpRequestUrl              @"httpRequestUrl"

@interface HttpLogCollectionItem ()

@end

@implementation HttpLogCollectionItem

+ (BaseSqliteItem *)createTableItem
{
    BaseSqliteItem *item = [[BaseSqliteItem alloc] init];
    item.configTableStatement = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT,'%@' TEXT,'%@' INTEGER, '%@' INTEGER, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT)",kHttpCollectedLogCenterTable,kId, kDisplayDescription,kLogType,kCreateTimeStamp,kCreateTime,kMark,kBusinessDescription,kHttpMethod,kPostParams,kHeader,kResponseData,kStatusCode,kResponseDataType,kHttpDebugMessage,kCreateDay,kHttpRequestUrl];
    return item;
}

+ (BaseSqliteItem *)configInsertStatementWithDataModel:(HttpLogInformationDataModel *)dataModel
{
    BaseSqliteItem *item = [[BaseSqliteItem alloc] init];
    item.operateStatement = [NSString stringWithFormat:@"INSERT INTO '%@' ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@') VALUES ('%@', '%@', '%ld', '%ld', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')", kHttpCollectedLogCenterTable, kMark, kDisplayDescription , kCreateTimeStamp,kLogType, kCreateTime, kBusinessDescription, kHttpMethod, kPostParams, kHeader, kResponseData, kStatusCode, kResponseDataType, kHttpDebugMessage,kCreateDay,kHttpRequestUrl, dataModel.mark,dataModel.displayDescription,dataModel.createTimeStamp,dataModel.logType,dataModel.createTime,dataModel.businessDescription,dataModel.httpMethod,dataModel.postParams,dataModel.header,dataModel.responseData,dataModel.statusCode,dataModel.responseDataType,dataModel.httpDebugMessage,dataModel.createDay,dataModel.httpRequestUrl];
    return item;
}

+ (BaseSqliteItem *)convertHttpItemWithSqliteItemWithHttpItem:(BaseHttpItem *)item
{
    NSString *responseType = @"";
    switch (item.httpResponseDataType)
    {
        case HTTPResponseDataTypeLoadedFromServer:
            responseType = @"服务器";
            break;
        case HTTPResponseDataTypeLoadedFromLocalCache:
            responseType = @"本地缓存";
            break;
        case HTTPResponseDataTypeUnknownType:
            responseType = @"本地出错信息";
            break;
        case HTTPResponseDataTypeLoadedFromMockingResponse:
            responseType = @"本地模拟数据";
            break;
        default:
            break;
    }
    
    HttpLogInformationDataModel *logDataModel = [[HttpLogInformationDataModel alloc] init];
    logDataModel.businessDescription = item.descriptionItem;
    logDataModel.httpMethod = item.httpRequestMethodString;
    logDataModel.postParams = [item.httpRequestPostParams descriptionWithLocale:nil];
    logDataModel.header = [item.httpRequestHeaderParams descriptionWithLocale:nil];
    logDataModel.responseData = [item.httpRequestResponseData descriptionWithLocale:nil];
    logDataModel.statusCode = [NSString stringWithFormat:@"%ld",item.httpRequestStatusCode];
    logDataModel.responseDataType = [NSString stringWithFormat:@"%@",responseType];
    logDataModel.httpDebugMessage = item.httpRequestDebugErrorMessage;
    logDataModel.httpRequestUrl = item.httpRequestAbsoluteUrlString;
    logDataModel.logType = HTTPLOGINFORMATIONDATAMODELTYPE_HTTPREQUEST;
    logDataModel.mark = Kmark([[BaseHttpConfigManager shareHttpConfigManager].config httpLogCollectionMark]);
    return [self configInsertStatementWithDataModel:logDataModel];
}

+ (BaseSqliteItem *)convertPushDataWithSqliteItemWithPushDataDic:(NSDictionary *)pushDic
{
    HttpLogInformationDataModel *logDataModel = [[HttpLogInformationDataModel alloc] init];
    logDataModel.displayDescription = [pushDic descriptionWithLocale:nil];
    logDataModel.logType = HTTPLOGINFORMATIONDATAMODELTYPE_NOTIFICATION;
    return [self configInsertStatementWithDataModel:logDataModel];
}

+ (BaseSqliteItem *)selectAllHttpLogWithMark:(NSString *)mark
{
    BaseSqliteItem *item = [[BaseSqliteItem alloc] init];
    item.operateStatement = [NSString stringWithFormat:@"select * from %@ where %@ like '%@' order by %@ desc",kHttpCollectedLogCenterTable , kMark , mark, kCreateTimeStamp];
    item.selectedDataModelClass = [HttpLogInformationDataModel class];
    return item;
}

+ (BaseSqliteItem *)selectOneDayLogInformationWithDay:(NSString *)day searchKey:(NSString *)key andMark:(NSString *)mark
{
    BaseSqliteItem *item = [[BaseSqliteItem alloc] init];
    item.operateStatement = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ like '%@' AND %@ like '%@' AND %@ like '%%%@%%' order by %@ desc",kHttpCollectedLogCenterTable,kMark,mark,kCreateDay,day,kDisplayDescription,key,kCreateTimeStamp];
    item.selectedDataModelClass = [HttpLogInformationDataModel class];
    return item;
}

+ (BaseSqliteItem *)selectDebugLogWithLogid:(NSString *)logId
{
    BaseSqliteItem *item = [[BaseSqliteItem alloc] init];
    item.operateStatement = [NSString stringWithFormat:@"select * from %@ where %@ like '%@'",kHttpCollectedLogCenterTable , kId , logId];
    item.selectedDataModelClass = [HttpLogInformationDataModel class];
    return item;
}

+ (BaseSqliteItem *)deleteAllLog
{
    BaseSqliteItem *item = [[BaseSqliteItem alloc] init];
    item.operateStatement = [NSString stringWithFormat:@"delete from '%@'",kHttpCollectedLogCenterTable];
    return item;
}

@end
