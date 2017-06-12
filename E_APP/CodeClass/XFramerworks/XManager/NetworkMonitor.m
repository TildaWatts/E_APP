//
//  NetworkMonitor.m
//  Faith in life
//
//  Created by alexanxiong on 16/5/11.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#import "NetworkMonitor.h"
#import "EventCenter.h"
#import "MsgConst.h"

#define kDetectServer  @"www.baidu.com"

@implementation NetworkMonitor

static  NetworkStatus status =  -1;

//开启网络状况的监听
+ (void)ReachabilityDetective
{
    CZ_AddObj2DeftNotiCenter(self  , @selector(reachabilityChanged:),kReachabilityChangedNotification,nil);

    Reachability *hostReach = [Reachability reachabilityWithHostName:kDetectServer];
    
    //开始监听,会启动一个run loop
    [hostReach startNotifier];
    
    [self updateInterfaceWithReachability: hostReach];
}

+ (void) CloseReachabilityDetective
{
    CZ_RemoveObjFromDeftNotiCenter(self,kReachabilityChangedNotification,nil);
}

// 连接改变
+ (void)reachabilityChanged: (NSNotification*)note
{
    Reachability*curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}


//处理连接改变后的情况
+ (void)updateInterfaceWithReachability: (Reachability*)curReach
{
    //对连接改变做出响应的处理动作。
    NetworkStatus new_status=[curReach currentReachabilityStatus];
    
    if (new_status == NotReachable && status != NotReachable)
    {
//        [USProgressHud showHint:NewworkConnectFailure yOffset:200];
    }
    status = new_status;
    
    [EventCenter Event_Post:MSG_NET_CHANGE ];

}


+ (NetworkStatus) getNetworkState
{
    return status;
}


@end
