//
//  CacheEngine.m
//  MTTemplate
//
//  Created by Mateen on 2017/1/16.
//  Copyright © 2017年 Teen ma. All rights reserved.
//

#import "CacheEngine.h"

#define kCacheManagerMacro [NSString stringWithFormat:@"FileName_%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleIdentifierKey]]

@implementation CacheEngine

+ (BOOL)localCacheIsExistsWithMarkKeyFileName:(NSString *)fileName
{
    if (fileName && fileName.length == 0) return NO;

    BOOL result = YES;
    if (![self.class loadDataWithMarkKeyFileName:fileName])
    {
        result = NO;
    }
    return result;
}

+ (NSString *)applicationDocumentsDirectory:(NSString *)fileName
{
    if (fileName && fileName.length == 0) return nil;

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *appendPath = fileName;
    return [basePath stringByAppendingPathComponent:appendPath];
}

+ (id)loadDataWithMarkKeyFileName:(NSString *)fileName
{
    if (fileName && fileName.length == 0) return nil;

    NSString *filePath = [[self class] applicationDocumentsDirectory:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSData *data = [[NSMutableData alloc]
                        initWithContentsOfFile:filePath];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]
                                         initForReadingWithData:data];
        id result = [unarchiver decodeObjectForKey:kCacheManagerMacro];
        [unarchiver finishDecoding];
        return result;
    }
    return nil;
}

+ (void)saveData:(id)dataToSave toMarkKeyFileName:(NSString *)fileName
{
    if (fileName && fileName.length == 0) return;

    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]
                                 initForWritingWithMutableData:data];
    [archiver encodeObject:dataToSave forKey:kCacheManagerMacro];
    [archiver finishEncoding];
    NSString *filePath = [[self class] applicationDocumentsDirectory:fileName];
    NSError *erro = nil;
    [data writeToFile:filePath atomically:YES];
}

+ (void)deleteDataWithMarkKeyFileName:(NSString *)fileName
{
    if (fileName && fileName.length == 0) return;

    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]
                                 initForWritingWithMutableData:data];
    [archiver encodeObject:nil forKey:kCacheManagerMacro];
    [archiver finishEncoding];
    
    NSString *filePath = [[self class] applicationDocumentsDirectory:fileName];
    [data writeToFile:filePath atomically:YES];
}

+ (void)removeAllLocalCache
{
    NSArray *systemFileName = [NSArray arrayWithObjects:@"cfg",@"LeanCloud",@"baiduplist",nil];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : @"";
    NSArray *contentOfFolder = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:basePath error:NULL];
    for (NSString *aPath in contentOfFolder)
    {
        if (![systemFileName containsObject:aPath])
        {
            [[NSFileManager defaultManager]removeItemAtPath:[basePath stringByAppendingPathComponent:aPath] error:nil];
        }
    }
}

@end
