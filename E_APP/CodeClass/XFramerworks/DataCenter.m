//
//  DataCenter.m
//  Xinnuo
//
//  Created by alexanxiong on 16/5/10.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#import "DataCenter.h"
#import "XDSetting.h"
#import <Foundation/Foundation.h>
#import "Global.h"
#import "SystemHelper.h"
#import "UUID.h"
#import "DataTool.h"


@implementation DataCenter

static  DataCenter* _instance = nil;

+(DataCenter*) shareInstance
{
    @synchronized (self)
    {
        if( _instance == nil)
        {
            _instance = [[DataCenter alloc ] initApp];
        }
    }
    return _instance ;
}

-(id) initApp
{
    if( _instance != nil)
    {
        return self;
    }
    
    self = [super init];
    
    self.lastLauchTime =  [XDSetting getLastLauchTime];
    self.isFirstLauch =   (self.lastLauchTime == 0);
    self.thisLauchTime =  [XDSetting setLauch ];
    
    [self load];
    
    NSString *platform = [NSString stringWithFormat:@"%@-%@-%@",PLATFORM,[SystemHelper getSystem_version],[SystemHelper getCurrentDeviceModel]];
    
    self.platform = platform;
    self.channel  =  CHANNEL;
    
    self.guid = [UUID getUUID];
    self.device_id = [SystemHelper getDeviceID];
    self.model    = [SystemHelper getDeviceModel];
    
    NSString* build = [SystemHelper getBuildVersion];
    self.versionCode = [build intValue];;
    self.app_version = [SystemHelper  getApp_version];

    return self;
}

/**
 *  加载用户信息
 */
-(void) load
{
    self.uid = [XDSetting getUID];
    self.phone=[XDSetting getPhone];
    self.token = [XDSetting getToken];
    self.sessionkey = [XDSetting getSessionKey];
    
    self.lastLoginTime =  [XDSetting getLoginTime];
    
}

-(void) clearUserInfo
{
    self.uid = 0;
    self.phone = nil;
    self.token = nil;
    self.sessionkey = nil;
    self.lastLoginTime  = 0;

    
    // 1.删除登录基本信息
    [XDSetting setPhone:nil];
    [XDSetting setUID:0];
    [XDSetting setToken:nil];
    [XDSetting setSessionKey:nil];
    
    // 2.删除缓存数据
    [DataTool removeAllObjects];
}



@end
