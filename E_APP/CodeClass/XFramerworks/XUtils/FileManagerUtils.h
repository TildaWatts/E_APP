//
//  FileManagerUtils.h
//  Faith in life
//
//  Created by kingcong on 16/5/14.
//  Copyright © 2016年 allan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManagerUtils : NSObject

/**
 *  创建一个文件目录
 *
 *  @param dicretoryName 文件目录名
 */
+ (NSString *)createFileDirectory:(NSString *)dicretoryName;

+ (void)removeFileDirectoryOfFile:(NSString *)dicretoryName;

@end
