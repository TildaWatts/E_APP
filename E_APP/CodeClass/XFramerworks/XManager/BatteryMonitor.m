//
//  BatteryMonitor.m
//  Faith in life
//
//  Created by alexanxiong on 16/5/13.
//  Copyright © 2016年 alexanxiong . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIDevice.h>
#import "BatteryMonitor.h"
#import "EventCenter.h"
#import "XDLog.h"

@implementation BatteryMonitor

static volatile float currentBattery;

+(void) startBatteryMonitor
{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    
    CZ_AddObj2DeftNotiCenter(self  , @selector(onBatteryChange:),UIDeviceBatteryLevelDidChangeNotification,nil);
}

+(void) stopBatteryMonitor
{
    CZ_RemoveObjFromDeftNotiCenter(self,UIDeviceBatteryLevelDidChangeNotification,nil);
}

+(void) onBatteryChange : (NSNotification*)note
{
    currentBattery = [UIDevice currentDevice].batteryLevel;
    
    XLog(@">>>>onBatteryChange:%.2f",currentBattery)
}
+(float) getBatteryState
{
    return currentBattery;
}

@end

