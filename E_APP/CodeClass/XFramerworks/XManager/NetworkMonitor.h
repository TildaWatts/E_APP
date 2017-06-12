//
//  NetworkMonitor.h
//  Faith in life
//
//  Created by alexanxiong on 16/5/11.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#import "Reachability.h"

#ifndef NetworkMonitor_h
#define NetworkMonitor_h

@interface NetworkMonitor: NSObject

+ (void)ReachabilityDetective;

+ (void)CloseReachabilityDetective;

+ (void)reachabilityChanged: (NSNotification*)note;

+ (void)updateInterfaceWithReachability: (Reachability*)curReach;

+ (NetworkStatus) getNetworkState;


@end

#endif
