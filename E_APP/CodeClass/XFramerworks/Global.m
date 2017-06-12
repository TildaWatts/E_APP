//
//  Global.m
//  Faith in life
//
//  Created by alexanxiong on 16/5/13.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"
#import "XDSetting.h"
#import "DataCenter.h"
#import "BatteryMonitor.h"
#import "NetworkMonitor.h"
#import "SettingEngine.h"
//#import "TabEngine.h"
//#import "STUpload.h"

static BOOL bInit = NO;

@implementation Global

+(BOOL) isDev
{
    return APP_CUR == APP_DEV;
}

+(BOOL) isFirstLauch
{
    return [DataCenter shareInstance].isFirstLauch;
}

+(void) initApp
{
    @synchronized (self)
    {
        if( bInit )
            return ;
        bInit = YES;
        [DataCenter shareInstance] ;
        if( ENABLE_BATTERY_MONITOR )
        {
            [BatteryMonitor startBatteryMonitor];
        }
        
        //第一次启动拉取逻辑
        if( [self isFirstLauch])
        {
            
        }
        
        //数据缓存准备
        {
            [[SettingEngine shareInstance ] getData:NO];
//            [[TabEngine shareInstance] getAD:NO];
//            [STUpload initialize];
        }
    }

}

+(void) exitApp
{
    [BatteryMonitor stopBatteryMonitor];
    [NetworkMonitor CloseReachabilityDetective];
}


@end

