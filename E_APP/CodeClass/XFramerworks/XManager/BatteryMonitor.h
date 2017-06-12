//
//  BatteryMonitor.h
//  Faith in life
//
//  Created by alexanxiong on 16/5/13.
//  Copyright © 2016年 alexanxiong . All rights reserved.
//

#ifndef BatteryMonitor_h
#define BatteryMonitor_h
#import <Foundation/Foundation.h>

@interface BatteryMonitor : NSObject

+(void) startBatteryMonitor;
+(void) stopBatteryMonitor ;
+(void) onBatteryChange : (NSNotification*)note;
+(float) getBatteryState;

@end

#endif /* BatteryMonitor_h */
