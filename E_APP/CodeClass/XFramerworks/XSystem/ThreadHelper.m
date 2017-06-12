//
//  STThreadHelper.m
//  Faith in life
//
//  Created by 王聪 on 16/4/21.
//  Copyright © 2016年 allan. All rights reserved.
//

#import "ThreadHelper.h"

@implementation ThreadHelper

+ (void)createNewThreadRun:(void (^)())threadBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        threadBlock();
    });
    
}

+ (void)createNewThreadRun:(ThreadType)threadType threadBlock:(void (^)())threadBlock
{
    if (threadType == ThreadTypeAsyncCal) { // 异步并行线程
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

            threadBlock();
        });
    } else if (threadType == ThreadTypeAsyncSession) {  // 异步串行
        
        dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);
        dispatch_async(queue, ^{
            threadBlock();
        });
    } else if (threadType == ThreadTypeSyncSession){   // 同步串行
        dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);
        dispatch_sync(queue, ^{
            threadBlock();
        });
    } else {    // 不创建线程
        threadBlock();
    }
}

@end
