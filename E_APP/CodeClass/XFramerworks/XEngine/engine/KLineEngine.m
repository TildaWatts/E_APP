//
//  KLineEngine.m
//  E_APP
//
//  Created by Ezra on 2017/6/21.
//  Copyright © 2017年 Ezra. All rights reserved.
//

#import "KLineEngine.h"

@implementation KLineEngine

static  KLineEngine * _instance = nil;

+(KLineEngine *) shareInstance
{
    @synchronized (self)
    {
        if( _instance == nil)
            _instance = [[KLineEngine alloc] init] ;
    }
    
    return _instance ;
}


- (void)kLineWithCurrency:(NSString *)currency type:(NSString *)type since:(id)since size:(int)size
{
    XRequest *request = [[XRequest alloc]initWithCmd:@"kline"];
    [request addData:@"currency" value:currency];
    [request addData:@"type" value:type];
//    [request addData:@"since" num:[NSNumber numberWithDouble:since]];
//    [request addData:@"size" i_value:size];

    [self doRequest:request];
}

@end
