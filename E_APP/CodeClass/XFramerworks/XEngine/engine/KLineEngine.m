//
//  KLineEngine.m
//  E_APP
//
//  Created by Ezra on 2017/6/21.
//  Copyright © 2017年 Ezra. All rights reserved.
//

#import "KLineEngine.h"

#define CMD_KLINE @"kline"

static  KLineEngine * _instance = nil;

@implementation KLineEngine


+(KLineEngine *) shareInstance
{
    @synchronized (self)
    {
        if( _instance == nil)
            _instance = [[KLineEngine alloc] init] ;
    }
    
    return _instance ;
}


- (void)kLineWithCurrency:(NSString *)currency type:(NSString *)type since:(long int)since size:(int)size
{
    XRequest *request = [[XRequest alloc]initWithCmd:CMD_KLINE];
    [request addData:@"currency" value:currency];
    [request addData:@"type" value:type];
    [request addData:@"since" long_i_value:since];
    [request addData:@"size" i_value:size];

    [self doRequest:request];
}


-(void) onSuccess:(XRequest*) request response:(XResponse*) response
{
    XLog(@"KLineEngine onSuccess request:%@=response:%@",request,response);
    if( request == nil  || request.cmd == nil)
        return ;
    
    if( [request.cmd isEqualToString:CMD_KLINE])
    {
        [EventCenter Event_PostData: MSG_KLINE_SUCCESS obj:response ];
    }

    
}
- (void)onFail:(XRequest *)request response:(XResponse *)response
{
    
}

@end
