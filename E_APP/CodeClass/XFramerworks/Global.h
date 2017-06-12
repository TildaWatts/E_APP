//
//  Glbal.h
//  Faith in life
//
//  Created by alexanxiong on 16/5/12.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#ifndef Glbal_h
#define Glbal_h

#import "XDLog.h"

typedef enum APP_STATUS
{
    APP_DEV,
    APP_GRAY,
    APP_OFFICAL
} STURCT_APP_STATUS;

#define PLATFORM           @"IOS"
#define APP_CUR            APP_OFFICAL

#ifdef DEBUG
//do sth.
#define CHANNEL @"0000"

#else
//do sth.
#define CHANNEL @"AppStore"

#endif

#define ENABLE_BATTERY_MONITOR YES


@interface Global : NSObject

+(BOOL) isDev;
+(BOOL) isFirstLauch;

+(void) initApp;
+(void) exitApp;


@end


#endif /* Glbal_h */
