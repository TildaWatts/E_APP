//
//  STThreadHelper.h
//  Faith in life
//
//  Created by 王聪 on 16/4/21.
//  Copyright © 2016年 allan. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef THREAD_HELPER_H

#define THREAD_HELPER_H
typedef enum : NSUInteger {
    ThreadTypeAsyncCal,     // 异步并行
    ThreadTypeAsyncSession,     // 异步串行
    ThreadTypeSyncSession,      // 同步串行
} ThreadType;

@interface ThreadHelper : NSObject

// 默认创建一个异步并发线程
+ (void)createNewThreadRun:(void (^)())threadBlock;

/**
 *  根据线程类型创建多线程
 *
 *  @param threadType  线程类型
 *  @param threadBlock 执行代码
 */
+ (void)createNewThreadRun:(ThreadType)threadType threadBlock:(void (^)())threadBlock;

@end
#endif
