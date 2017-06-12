//
//  CURLOutput.m
//  Faith in life
//
//  Created by alexanxiong on 16/9/22.
//  Copyright © 2016年 Xinnuo. All rights reserved.
//


#import "CURLOutput.h"
#import "CommonUtils.h"

@implementation CURLOutput

-(id) initWithURL:(NSString*) url  task:(NSString*) task code:(NSString*) code
{
    self = [super init];
    self.reqNO = [CommonUtils getUniqueID ];
    self.cmd   = @"curl.data";
    self.mode  = CACHE_MODE_OFF;
    
    self.url   = url;
    self.taskid= task;
    self.code  = code;
    
    return self;
}

-(void) addheader:(NSString*) key value:(NSString*) value
{

    @synchronized (self)
    {
        if( self.c_header == nil)
        {
            self.c_header = [NSMutableDictionary dictionaryWithObject:value forKey:key];
        }
        else if ( self.c_header != nil && key != nil  && value != nil)
        {
            [self.c_header setObject:value forKey:key];
        }
        XLog(@"...%@",self.c_header);
    }
}


-(void) fill
{
    NSMutableDictionary* dic  =  [NSMutableDictionary dictionary];
    dic[@"taskid"]    =  self.taskid;
    dic[@"url"]       =  self.url;
    dic[@"code"]      =  self.code;
    if( self.content != nil)
    {
        dic[@"content"]  = self.content;
    }
    
    if( self.c_header != nil )
        dic[@"header"]         =   self.c_header;
    
    self.data  = dic;
}

@end
