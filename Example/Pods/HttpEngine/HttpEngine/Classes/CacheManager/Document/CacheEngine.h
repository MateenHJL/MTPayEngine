//
//  CacheEngine.h
//  MTTemplate
//
//  Created by Mateen on 2017/1/16.
//  Copyright © 2017年 Teen ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheEngine : NSObject

//check wether your data is exist in your sandbox.
+ (BOOL)localCacheIsExistsWithMarkKeyFileName:(NSString *)fileName;

//read data from local sandbox ,filename means your document name;
+ (id)loadDataWithMarkKeyFileName:(NSString *)filename;

//save data to local sandbox,filename means your document name;
+ (void)saveData:(id)dataToSave toMarkKeyFileName:(NSString *)filename;

//delete data from your sandbox depends on what's your filename is.
+ (void)deleteDataWithMarkKeyFileName:(NSString *)fileName;

//remove data to sandbox;
+ (void)removeAllLocalCache;

@end
