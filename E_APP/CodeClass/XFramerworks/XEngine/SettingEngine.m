//
//  SettingEngine.m
//  Faith in life
//
//  Created by alexanxiong on 16/5/13.
//  Copyright © 2016年 alexanxiong . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingEngine.h"
#import "Global.h"
#import "EventCenter.h"
#import "CodeZipper.h"
#import "ErrorCode.h"
//#import "LoginEngine.h"


#define CMD_TOOL_SETTING @"tools.settings"
#define CMD_USER_SETTING @"user.setting"
#define CMD_GET_USER_SETTING  @"user.getSetting"

static  SettingEngine* _instance = nil;


@implementation SettingEngine
{
    double requestTime ;
}


+(SettingEngine*) shareInstance
{
    @synchronized (self)
    {
        if( _instance == nil)
        {
            _instance = [[SettingEngine alloc] init] ;
        }
    }
    
    return _instance ;
}

- (instancetype)init
{
    self = [super init];
    requestTime =  0;
    return self;
}

-(SettingInfo*) getData:(BOOL) bImport
{
    if( self.info == nil)
    {
        [self request];
    }
    else
    {
        //刷新时间超出大间隔则更新数据
        double now = CZ_getCurrentLocalTime();
        if( bImport || (now - requestTime > GREAT_GAP)  )
        {
            [self request];
        }
    }
    return self.info;
}

-(int) getCreditMax
{
    if( self.info != nil )
    {
        return  self.info.maxCredit;
    }
    return 7000;
}

- (int) getCreditMin
{
    if( self.info != nil )
    {
        return  self.info.goodsPrinceMin;
    }
    return 1000;
}

-(int) getFaceLimit
{
    if(  self.info != nil)
    {
        return self.info.userauthLimit;
    }
    return 3;
}

//修改用户设置
-(void) setUserSetting:(NSString*) key value:(NSString*) value
{
    if( key == nil)
        return ;
    XRequest* request = [[XRequest alloc] initWithCmd:CMD_USER_SETTING ];
    [request addData:key value:value];
    request.mode  =  CACHE_MODE_OFF;
    [self doRequest:request];
}
//拉取用户设置
-(void) getUserSetting
{
    XRequest* request = [[XRequest alloc] initWithCmd:CMD_GET_USER_SETTING ];
    request.mode  =  CACHE_MODE_OFF;
    [self doRequest:request];
}

-(void) request
{
    XLog(@"-------settingEngine getData ");
    XRequest* request = [[XRequest alloc] initWithCmd:CMD_TOOL_SETTING ];
    request.mode  =  CACHE_MODE_ON;
    [self doRequest:request];
}


-(void) onSuccess:(XRequest*) request response:(XResponse*) response
{
    XLog(@"SettingEngine onSuccess request:%@=response:%@",request,response);
    if( request == nil  || request.cmd == nil)
        return ;
    
    if( [request.cmd isEqualToString:CMD_TOOL_SETTING])
    {
        SettingInfo* info = [[SettingInfo alloc] initWithXResponse:response ];
        self.info = info;
        
        [EventCenter Event_PostData: MSG_SETTING_UPDATE obj:info ];
        
        if( !response.isCache)
        {
            requestTime = CZ_getCurrentLocalTime();
            [response saveAppCache];
        }
    }
    else if( [request.cmd isEqualToString:CMD_USER_SETTING])
    {
        [EventCenter Event_PostData: MSG_USER_SETTING_SUC obj:response ];
    }
    else if( [request.cmd isEqualToString:CMD_GET_USER_SETTING])
    {
        [EventCenter Event_PostData: MSG_GET_USER_SETTING_SUC obj:response.o_ret ];
    }
}


-(void) onFail:(XRequest*) request   response:(XResponse*) response
{
    if( request == nil  || request.cmd == nil)
        return ;
    
    XLog(@"SettingEngine onFail request:%@=response=%@ errorCode=:%d",request,response,response.errorCode);
    
    if( [request.cmd isEqualToString:CMD_TOOL_SETTING])
    {
        if( self.info == nil)
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(50.0 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
                if( self.info == nil)
                    [[SettingEngine shareInstance] getData:YES];
            });
        }
        
        // 登录失败
        if (response.errorCode == ERROR_SERVER_NOT_LOGIN)
        {
//            [[LoginEngine shareInstance] quick_login];
        } else if (response.errorCode == ERROR_SERVER_KICKED){
            [EventCenter Event_PostData:MSG_OUT_LOGIN_FAILURE data:response];
            return;
        }
    }
    else if( [request.cmd isEqualToString:CMD_USER_SETTING])
    {
        [EventCenter Event_PostData: MSG_USER_SETTING_FAIL obj:response ];
    }
    else if( [request.cmd isEqualToString:CMD_GET_USER_SETTING])
    {
        [EventCenter Event_PostData: MSG_GET_USER_SETTING_FAIL obj:response ];
    }

}

@end
