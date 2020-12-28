//
//  HttpLogInformationDataModel.m
//  YouSuHuoPinPoint
//
//  Created by Teen Ma on 2017/12/25.
//  Copyright © 2017年 Teen Ma. All rights reserved.
//

#import "HttpLogInformationDataModel.h"
#import "NSDate+DateTools.h"

@implementation HttpLogInformationDataModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"logId" : @"id"};
}

- (instancetype)init
{
    if (self = [super init])
    {
        NSDate *date = [NSDate date];
        self.createTimeStamp = [date timeIntervalSince1970];
        self.createDay = [NSString stringWithFormat:@"%ld年%ld月%ld日",date.year,date.month,date.day];
        self.createTime = [NSString stringWithFormat:@"%ld时%ld分%ld秒",date.hour,date.minute,date.second];
    }
    return self;
}

- (NSString *)displayDescription
{
    if (!_displayDescription)
    {
        _displayDescription = @"";
    }
    return _displayDescription;
}

@end
