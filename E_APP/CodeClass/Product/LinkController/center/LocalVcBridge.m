//
//  LocalVcBridge.m
//  U_APP
//
//  Created by Ezra on 16/12/3.
//  Copyright © 2016年 Ezra. All rights reserved.
//

#import "LocalVcBridge.h"
#import "CommonUtils.h"
#import "AppDelegate.h"

#pragma mark - 公共headfile


#pragma mark - 首页headfile


#pragma mark - “我的”headfile


@implementation LocalVcBridge

static   NSDictionary * _vcDict = nil;

+(NSDictionary *)vcDict
{
    if (!_vcDict) {
            _vcDict =@{ACTION_HOME          :@"HomeViewController",
                       ACTION_MY            :@"MineViewController",
                       ACTION_ADDCARD       :@"XDAddBankCardController",
                       ACTION_FINANCE       :@"XDCreditLimitViewController",
                       ACTION_MESSAGE       :@"HomeMessageController"
        };
    }
    return _vcDict;
}

+(void)LinkDestinationVc:(XUri*) uri obj:(UIViewController *) ctroller dict:(NSMutableDictionary *)dict
{
    if( dict  && [dict  isKindOfClass:[NSDictionary class]])
    {
        BOOL fromNotification = [CommonUtils getBool:dict key:@"isLaunchedByNotification"];
        if( !fromNotification )
            [self HandlePidAndCidUri:uri];
    }
    [self forward2Page:uri.host obj:ctroller dict:dict uri:uri];
}


+(void) forward2Page:(NSString*) page obj:(UIViewController *)ctroller dict:(NSMutableDictionary *)dict uri:(XUri *)uri
{
    [self vcDict];
    if( page == nil  || ctroller == nil || ![ctroller isKindOfClass:[UIViewController class]] )
        return ;

    UIViewController *vc = nil;
    
    NSString* controller = [CommonUtils getString:_vcDict key:page];
    
   #pragma mark - 首页
    if ([page isEqualToString:ACTION_PAY]) {
    /*
     *eg.
     *        vc = [XDPaymentRecordController new];
     *
     */
    }
#pragma mark - 咨询
    else if( [page isEqualToString:ACTION_ART_SERVICE] || [page isEqualToString:ACTION_ROBOT_SERVICE])
    {
        return ;
    }
#pragma mark - 共用

    else
    {
        if( !CZ_IsEmptyString(controller))
            vc = [NSClassFromString(controller) new];
    }
    
    if( vc != nil )
    {
        [self setID:vc prePage:ctroller];
    }

    
    if ([page isEqualToString:ACTION_HOME] || [page isEqualToString:ACTION_MY]  || [page isEqualToString:ACTION_CUSTOM_SERVICE] || [page isEqualToString:ACTION_CUSTOM_SERVICE] )
    {
        [ctroller.navigationController popToRootViewControllerAnimated:NO];
    }
    else if( [page  isEqualToString:ACTION_FINANCE])
    {

    }
    else if( vc)
    {
        [ctroller.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 埋点
+(void) setID:(UIViewController*) page  prePage:(UIViewController*) control
{
    if( page == nil || control == nil)
        return ;
    if( [control isKindOfClass:[UIViewController class] ] )
    {
//        page.prepageID = ((UIViewController*) control).pageID;
    }
}



#pragma mark - 判断信盾事件中有没有P/Cid
+ (void)HandlePidAndCidUri:(XUri *)uri
{
    NSString* cid = [CommonUtils getString:uri.querys key:@"cid"];
    NSString* pid = [CommonUtils getString:uri.querys key:@"pid"];
    if( !CZ_IsEmptyString(cid))
    {
        [self baseActionUrlHandleCid:cid];
    }
    if( !CZ_IsEmptyString(pid))
    {
        [self baseViewUrlHandlePid: pid];
    }
}

+ (void)baseActionUrlHandleCid:(NSString *)actionID
{
    // 发送事件统计
//    [XDTracker sendEventWithID:actionID result:YES];
}

+ (void)baseViewUrlHandlePid:(NSString *)viewID
{
    // 发送事件统计
//    [XDTracker sendViewsWithID:viewID];
}


@end
