//
//  AppDev.m
//  Faith in life
//
//  Created by alexanxiong on 16/5/12.
//  Copyright © 2016年 allan. All rights reserved.
//

#import "AppDev.h"
#import "Global.h"

/**
 *  测试代理.调试可修改，但不建议递交
 */
#define PRXOY_ENABLE NO
#define PRXOY_IP @"192.168.1.52"
#define PRXOY_PORT @8888


@implementation AppDev

/**
 *  禁止网络缓存加载，并设置代理。使用PRXOY_ENABLE PRXOY_IP PRXOY_PORT
 */
+ (NSURLSessionConfiguration *)setProxyWithConfig
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    if( [Global isDev] && PRXOY_ENABLE )
    {
        config.connectionProxyDictionary = @
        {
            @"HTTPEnable":@YES,
            (id)kCFStreamPropertyHTTPProxyHost:PRXOY_IP,
            (id)kCFStreamPropertyHTTPProxyPort:PRXOY_PORT,
            @"HTTPSEnable":@YES,
            (id)kCFStreamPropertyHTTPSProxyHost:PRXOY_IP,
            (id)kCFStreamPropertyHTTPSProxyPort:PRXOY_PORT
        };
    }
    
    return config;
}

@end
