//
//  XHead.m
//  Faith in life
//
//  Created by alexanxiong on 16/5/12.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#import "XHead.h"
#import "DataCenter.h"
#import "CommonUtils.h"
#import "Protocol.h"
#import "XDSetting.h"

@implementation XHead


static  XHead* _instance = nil;
static  NSMutableDictionary* xhead;


+(XHead*) shareInstance
{
    @synchronized (self)
    {
        if( _instance == nil)
        _instance = [[self alloc] init] ;
    }
    return _instance ;
}

-(NSMutableDictionary*) getXHead
{
    @synchronized (self)
    {
        if( xhead == nil)
        {
            [ self updateXHead ];
        }
    }
    
    return xhead;
}

// 加载header
-(void) loadFromDic :(NSDictionary*) dic
{
    if( dic == nil || dic.count <= 0)
        return ;
    
    int count = 0;
 
    NSString* ip = [CommonUtils getString:dic key:XD_PROTOCOL_H_IP] ;
    if( ip != nil )
    {
        [DataCenter shareInstance].ip = ip;
        ++ count;
    }
    int area_code = [CommonUtils getInt:dic key:XD_PROTOCOL_H_AERACODE] ;
    if( area_code != 0 )
    {
        [DataCenter shareInstance].areacode = area_code;
        ++ count;
    }
    
    int uid = [CommonUtils getInt:dic key:XD_PROTOCOL_H_UID] ;
    if( uid != 0 )
    {
        [XDSetting setUID:uid];
        ++ count;
    }
    NSString* token = [CommonUtils getString:dic key:XD_PROTOCOL_H_TOKEN] ;
    if( token != nil )
    {
        [XDSetting setToken:token];
        ++ count;
    }
    NSString* sessionkey = [CommonUtils getString:dic key:XD_PROTOCOL_H_SESSIONKEY] ;
    if( sessionkey != nil )
    {
        [XDSetting setSessionKey:sessionkey];
        ++ count;
    }
    
    if( count > 0 )
    {
        [self updateXHead];
    }
    
}

/**
 *   更新Head
 */
-(void) updateXHead
{
    @synchronized (self)
    {
        xhead = nil;
        
        xhead = [NSMutableDictionary dictionary];
        
        if( [DataCenter shareInstance].ip != nil)
            xhead[XD_PROTOCOL_H_IP]= [DataCenter shareInstance].ip;
        if( [DataCenter shareInstance].areacode != 0)
            xhead[XD_PROTOCOL_H_AERACODE] = [NSNumber numberWithInt:[DataCenter shareInstance].areacode ];
        
        if ( [DataCenter shareInstance].guid != nil)
            xhead[XD_PROTOCOL_H_GUID]  = [DataCenter shareInstance].guid;
        if( [DataCenter shareInstance].platform != nil)
            xhead[XD_PROTOCOL_H_PLATFORM] = [DataCenter shareInstance].platform;
        
        if( [DataCenter shareInstance].uid != 0)
            xhead[XD_PROTOCOL_H_UID] = [NSNumber numberWithInt:[DataCenter shareInstance].uid];
        if([DataCenter shareInstance].token != nil)
        {
            xhead[XD_PROTOCOL_H_TOKEN] =  [DataCenter shareInstance].token;
        }
        if([DataCenter shareInstance].sessionkey != nil)
            xhead[XD_PROTOCOL_H_SESSIONKEY] = [DataCenter shareInstance].sessionkey;
        
        xhead[XD_PROTOCOL_H_VERSION] = [NSNumber numberWithInt:[DataCenter shareInstance].versionCode ];
    }

}



@end