//
//  XLog.h
//  Faith in life
//
//  Created by alexanxiong on 16/5/13.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#import "Global.h"
#import "AppDev.h"
#import <Foundation/Foundation.h>

#ifndef XLog_h
#define XLog_h

#ifdef ENBALE_LOG

#define XLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else

#define XLog(...)

#endif

#endif /* XLog_h */
