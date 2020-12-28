//
//  HttpLogInformationDataModel.h
//  YouSuHuoPinPoint
//
//  Created by Teen Ma on 2017/12/25.
//  Copyright © 2017年 Teen Ma. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger , HTTPLOGINFORMATIONDATAMODELTYPE) {
    HTTPLOGINFORMATIONDATAMODELTYPE_HTTPREQUEST,//the type is HttpReuqest
    HTTPLOGINFORMATIONDATAMODELTYPE_CRASH,//the type is Crash
    HTTPLOGINFORMATIONDATAMODELTYPE_NOTIFICATION//the type is Notification
};

@interface HttpLogInformationDataModel : NSObject

@property (nonatomic, copy  ) NSString *logId;
@property (nonatomic, copy  ) NSString *httpRequestUrl;
@property (nonatomic, copy  ) NSString *businessDescription;
@property (nonatomic, copy  ) NSString *httpMethod;
@property (nonatomic, copy  ) NSString *postParams;
@property (nonatomic, copy  ) NSString *header;
@property (nonatomic, copy  ) NSString *responseData;
@property (nonatomic, copy  ) NSString *statusCode;
@property (nonatomic, copy  ) NSString *responseDataType;
@property (nonatomic, copy  ) NSString *httpDebugMessage;
@property (nonatomic, copy  ) NSString *mark;
@property (nonatomic, copy  ) NSString *displayDescription;
@property (nonatomic, assign) HTTPLOGINFORMATIONDATAMODELTYPE logType;
@property (nonatomic, copy  ) NSString *createDay;
@property (nonatomic, assign) NSInteger createTimeStamp;
@property (nonatomic, copy  ) NSString  *createTime;

@end
