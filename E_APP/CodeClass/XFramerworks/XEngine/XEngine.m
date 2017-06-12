//
//  XEngine.m
//  Xinnuo
//
//  Created by alexanxiong on 16/5/11.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//
#import "XEngine.h"
#import <Foundation/Foundation.h>

#import "AFNetworkReachabilityManager.h"
#import "NetworkMonitor.h"
#import "ErrorCode.h"
#import "AppDev.h"
#import "XDLog.h"
#import "XHead.h"
#import "CommonUtils.h"

#define HTTP  0
#define HTTPS 1

@implementation XEngine

static AFHTTPSessionManager* http_client = nil;
static AFHTTPSessionManager* https_client = nil;

static     NSMutableDictionary* time_dic  = nil;



+(AFHTTPSessionManager*) getDefaultHttpClient
{
    @synchronized (self)
    {
        if( http_client == nil)
        {
            AFHTTPSessionManager *manager  = [[AFHTTPSessionManager manager] initWithBaseURL:nil sessionConfiguration: [AppDev setProxyWithConfig] ];
//            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
            manager.requestSerializer.timeoutInterval = 10;
            [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
            
            http_client = manager ;
        }
    }
    return http_client;
}

+(AFHTTPSessionManager*) getDefaultHttpsClient
{
    @synchronized (self)
    {
        if( https_client == nil)
        {
            AFHTTPSessionManager *manager  = [[AFHTTPSessionManager manager] initWithBaseURL:nil sessionConfiguration: [AppDev setProxyWithConfig] ];
//            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
            manager.requestSerializer.timeoutInterval = 15;
            [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
            
            AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
            securityPolicy.allowInvalidCertificates = YES;
            manager.securityPolicy = securityPolicy;
            [manager.securityPolicy setAllowInvalidCertificates:YES];
            
            https_client = manager ;
        }
    }
    return https_client;
}

+(double)  getRequestTime:(NSString*) cmd
{
    @synchronized (XEngine.self)
    {
        if( time_dic != nil)
        {
            return [CommonUtils getDouble:time_dic key:cmd];
        }
        else
            return 0;
    }
}

+(void)    setRequestTime:(NSString*) cmd time:(double) time
{
    if( cmd == nil)
        return ;
    @synchronized (XEngine.self)
    {
        if( time_dic == nil)
        {
            time_dic = [[NSMutableDictionary alloc] init];
        }
        time_dic[cmd] =  [[NSNumber alloc ] initWithDouble:time];
    }
}



/**
 *  通过AFN发送网络请求
 *
 *  @param request   请求参数模型
 *  @param type      类型：分为HTTP和HTTPS
 *  @param local_id  配置的本地ID，通过这个保存不同缓存文件
 *  @param local_ext 扩展字段
 *
 *  @return 返回请求的唯一标识，用于标识不同请求
 */
-(int) raw_request:(XRequest*)  request  type:(int) type i_id:(int) local_id s_str:(NSString*) local_ext;
{
    XResponse* response =  [[XResponse alloc] init] ;
    response.reqNO  =  request.reqNO;
    response.cmd    =  request.cmd;
    response.local_id = local_id;
    response.local_ext= local_ext;
    
    BOOL bCacheLoad = NO;
    if( request.mode == CACHE_MODE_ON  || request.mode == CACHE_MODE_CACHE_NO_REQUEST )
    {
        id cache =[response  loadFromCache];
        if( cache != nil)
        {
            [self onSuccess:request  response:response];
            if( response.errorCode == OKAY)
            {
                bCacheLoad = YES;
            }
        }
    }

    // 缓存模式为 CACHE_ONLY 时有缓存不会
    if( request.mode == CACHE_MODE_CACHE_NO_REQUEST)
    {
        return request.reqNO;
    }
    
    if( [NetworkMonitor getNetworkState] == NotReachable)
    {
        response.errorCode =  ERROR_NET_NOT_REACHABLE;
        [self onFail:request  response:response];
        return request.reqNO ;
    }
    NSDictionary *paramDic = [request formRequest];
    
    AFHTTPSessionManager *manager  =   nil;
    if( type == HTTPS)
        manager = [XEngine getDefaultHttpsClient] ;
    else if( type == HTTP)
        manager = [XEngine getDefaultHttpClient] ;

#pragma mark - POST
    
    [manager POST:Usuite parameters:paramDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        [response loadData:responseObject];
        if( response.errorCode == OKAY && response.bizCode == OKAY )
        {
            XLog(@"请求成功");
            XLog(@"%@", response);
            
            requestTime = CZ_getCurrentLocalTime();
            
            if( response.local_ext == nil)
            {
                [XEngine setRequestTime:request.cmd time:requestTime];
            }
            else
            {
                [XEngine setRequestTime:response.local_ext time:requestTime];
            }
            
            //请求成功，更新header
            [[XHead shareInstance] loadFromDic:response.header];
            
            /**
             *  当缓存模式为 CACHE_MODE_DEFAULT 并且 缓存存在情况下。
             *  先请求返回缓存。之后再请求数据
             *  最后自行保存缓存
             */
            
            if( request.mode != CACHE_MODE_OFF  && bCacheLoad == NO )
            {
                [response saveCache];
            }
            
            [self onSuccess:request  response:response];
          
        }
        else
            [self onFail:request  response:response];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        NSLog(@"%@:%@", Usuite,[error localizedDescription]);
        response.errorCode =  ERROR_AFN_ERROR;
        [self onFail:request  response:response];
    }];
    return request.reqNO ;
}


-(int) doRequest:(XRequest*)  request
{
    return [self doRequest:request i_id:0 s_str:nil];
}

-(int) doRequest:(XRequest*)  request  i_id:(int) local_id s_str:(NSString*) local_ext;
{
    return [self raw_request:request type:HTTP i_id:local_id s_str: local_ext];
}

-(int) doRequest_s:(XRequest*) request
{
    return [self doRequest_s:request i_id:0 s_str:nil];
}

-(int) doRequest_s:(XRequest*) request i_id:(int) local_id s_str:(NSString*) local_ext;
{
    return [self raw_request:request type:HTTPS i_id:local_id s_str: local_ext];
}

-(void) onSuccess:(XRequest*) request response:(XResponse*) response
{
    XLog(@"XEngine onSuccess request:%@=response:%@",request,response);
}


-(void) onFail:(XRequest*) request   response:(XResponse*) response
{
    XLog(@"XEngine onFail request:%@=response:%d",request,response.errorCode);
}

// 父类请求缓存
-(void) clearCache
{
    
}



@end
