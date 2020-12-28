//
//  BaseUploadFileItem.h
//  YouShuLa
//
//  Created by Teen Ma on 28/03/2018.
//  Copyright © 2018 YouShuLa_IOS. All rights reserved.
//

#import <Foundation/Foundation.h>

//上传平台类型
typedef NS_ENUM(NSInteger , BASEUPLOADFILEITEMPLATFORMTYPE) {
    BASEUPLOADFILEITEMPLATFORMTYPE_QINIU//七牛
};

@interface BaseUploadFileItem : NSObject

@property (nonatomic, copy  ) NSString *token;
@property (nonatomic, strong) NSData   *fileData; 
@property (nonatomic, assign) BASEUPLOADFILEITEMPLATFORMTYPE platformType;
@property (nonatomic, copy  ) NSString *key;
@property (nonatomic, copy  ) NSString *filePath;//本地存储路径
@property (nonatomic, copy  ) NSString *fileName;//文件名称

@end
