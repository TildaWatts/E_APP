//
//  FileManagerUtils.m
//  Faith in life
//
//  Created by kingcong on 16/5/14.
//  Copyright © 2016年 allan. All rights reserved.
//

#import "FileManagerUtils.h"

@implementation FileManagerUtils

/**
*  创建一个文件目录
*
*  @param dicretoryName 文件目录名
*
*  @return 文件路径名
*/
+ (NSString *)createFileDirectory:(NSString *)dicretoryName
{
    // 1.打开数据库
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingFormat:@"/%@",dicretoryName];
    
    NSLog(@"文件缓存路径%@",path);
    
    // 创建文件路径
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        NSString *directoryPath = [documentPath stringByAppendingFormat:@"/%@",dicretoryName];
        [fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}


+ (void)removeFileDirectoryOfFile:(NSString *)dicretoryName
{
    NSFileManager * fileManager = [[NSFileManager alloc]init];
    
    [fileManager removeItemAtPath:dicretoryName error:nil];
}


/**
 *  根据目录创建文件路径
 *
 *  @param directoryPath 目录路径
 *
 *  @return 文件路径
 */
+ (NSString *)createFilePath:(NSString *)directoryPath fileName:(NSString *)fileName
{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",directoryPath,fileName];
    return filePath;
}

@end
