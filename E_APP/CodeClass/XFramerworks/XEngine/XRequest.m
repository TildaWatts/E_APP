//
//  XRequest.m
//  Faith in life
//
//  Created by alexanxiong on 16/5/12.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#import "XRequest.h"
#import "XHead.h"
#import "CommonUtils.h"
#import <Foundation/NSDictionary.h>

#import "Protocol.h"

@implementation XRequest

-(NSDictionary *) formRequest
{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    if( self.data != nil )
//        paramDic[XD_PROTOCOL_R_DATA] = self.data;
//    paramDic[XD_PROTOCOL_R_CMD] =  self.cmd;
//    paramDic[XD_PROTOCOL_R_HEADER] = [[XHead shareInstance] getXHead ];
        
        
//        paramDic[X_PROTOCOL_R_APPKEY] = self.cmd;
//    paramDic[X_PROTOCOL_R_WORD] = self.data;
    [paramDic addEntriesFromDictionary:self.data];
    return paramDic;
}


-(id) initWithCmd:(NSString*) cmd
{
    self = [super init];
    self.reqNO = [CommonUtils getUniqueID ];
    self.cmd   = cmd;
    self.mode  = CACHE_MODE_OFF;

    return self;
}

-(id) initWithCmd:(NSString*) cmd data:(NSMutableDictionary*) data
{
    self = [super init];
    self.reqNO = [CommonUtils getUniqueID ];
    self.cmd   = cmd;
    self.data  = data;
    self.mode  = CACHE_MODE_OFF;
    
    return self;
}


-(void) addData:(NSString*) key value:(NSString*) value
{
    if( self.data == nil)
    {
        self.data = [NSMutableDictionary dictionary];
    }
    [self.data setValue:value forKey:key];
}

-(void) addData:(NSString*) key i_value: (int) value
{
    if( self.data == nil)
    {
        self.data = [NSMutableDictionary dictionary];
    }
    [self.data setValue:[NSNumber numberWithInt:value] forKey:key];
}
-(void) addData:(NSString*) key long_i_value: (long int) value
{
    if( self.data == nil)
    {
        self.data = [NSMutableDictionary dictionary];
    }
    [self.data setValue:[NSNumber numberWithLong:value] forKey:key];
}
-(void) addData:(NSString*) key num: (NSNumber*) value
{
    if( self.data == nil)
    {
        self.data = [NSMutableDictionary dictionary];
    }
    [self.data setValue:value forKey:key];
}
@end
