//
//  XEngine.h
//  Xinnuo
//
//  Created by alexanxiong on 16/5/10.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#ifndef XEngine_h
#define XEngine_h

#import "XRequest.h"
#import "XResponse.h"
#import "AFNetworking.h"

#import <Foundation/Foundation.h>

#ifndef MIN_GAP
#define MIN_GAP      300
#endif

#ifndef GREAT_GAP
#define GREAT_GAP    60*60*3
#endif

@interface XEngine : NSObject
{
    double requestTime ;
}

+(AFHTTPSessionManager*) getDefaultHttpClient;
+(AFHTTPSessionManager*) getDefaultHttpsClient;
+(double)  getRequestTime:(NSString*) cmd;
+(void)    setRequestTime:(NSString*) cmd time:(double) time;

-(int) raw_request:(XRequest*)  request  type:(int) type i_id:(int) local_id s_str:(NSString*) local_ext;

-(int) doRequest:(XRequest*)  request  ;
-(int) doRequest_s:(XRequest*) request ;

-(int) doRequest:(XRequest*)  request  i_id:(int) local_id s_str:(NSString*) local_ext;
-(int) doRequest_s:(XRequest*) request i_id:(int) local_id s_str:(NSString*) local_ext;

-(void) onSuccess:(XRequest*) request response:(XResponse*) response;
-(void) onFail:(XRequest*) request    response:(XResponse*) response;

-(void) clearCache;
@end

#endif /* XEngine_h */
