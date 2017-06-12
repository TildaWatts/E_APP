//
//  CURLEngine.m
//  Faith in life
//
//  Created by alexanxiong on 16/9/22.
//  Copyright © 2016年 Xinnuo. All rights reserved.
//

#import "CURLEngine.h"
#import "XDLog.h"
#import "CommonUtils.h"

@implementation CURLEngine


static  CURLEngine* _instance = nil;

+(CURLEngine*) shareInstance
{
    @synchronized (self)
    {
        if( _instance == nil)
        {
            _instance = [[CURLEngine alloc] init] ;
        }
    }
    
    return _instance ;
}

-(void)addTask:(CURLInput*) task
{
    if( task == nil)
        return ;
    if(  task.url == nil || task.url.length <= 0)
    {
        CURLOutput* co = [[CURLOutput alloc] initWithURL:task.url task:task.task_id code: [CommonUtils int2NString:0]];
        [co fill];
        [self pushCURL:co];
        return ;
    }
    NSURLSession *session =  [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc]init]];
    NSURL *url = [NSURL URLWithString:task.url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    if( task.method != nil && [task.method caseInsensitiveCompare:@"POST"] == 0)
        [request setHTTPMethod:@"POST"];
    else
        [request setHTTPMethod:@"GET"];
    
    if( task.params != nil)
    {
        NSString* content_type = [CommonUtils getString:task.params key:@"Content-Type"];
        if( content_type  != nil)
        {
            [request setValue: content_type forHTTPHeaderField:@"Content-Type"];
        }
    }
    
    NSString* cookie  = [[CCookie shareInstance] getCookie:task.url];
    if( cookie == nil  || cookie.length <= 0)
    {
        cookie = task.cookie;
        if( cookie != nil && cookie.length > 0)
        {
            [ [CCookie shareInstance] addCookie:task.url key:[CCookie getCookieKey:task.url] value:task.url];
        }
    }
    if( cookie != nil && cookie.length > 0)
    {
        [request setValue: cookie forHTTPHeaderField:@"Cookie"];
    }
    
    CURLOutput* co = [[CURLOutput alloc] initWithURL:task.url task:task.task_id code: 0];
    if( task.data != nil && task.data.length > 0)
        [request setHTTPBody:[task.data dataUsingEncoding:NSUTF8StringEncoding]];

    NSURLSessionTask* c_task = [session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error) {
        //拿到响应头信息
        NSHTTPURLResponse *res       = (NSHTTPURLResponse *)response;
        int               satus_code = (int)res.statusCode;
        NSDictionary*     dic        = res.allHeaderFields;
        
        NSString* chunked = [CommonUtils getString:dic key:@"Transfer-Encoding"];
        NSString* len = [CommonUtils getString:dic key:@"Content-Length"];

        if( chunked != nil )
        {
            NSLog(@"%@=%@",chunked,len);
        }

        co.code = [CommonUtils int2NString:satus_code];
        NSString* content_type = [CommonUtils getString:dic key:@"Content-Type"];
        if( content_type != nil)
        {
            [co addheader:@"Content-type" value:content_type];
        }
        NSString* e_tag = [CommonUtils getString:dic key:@"ETag"];
        if( e_tag != nil)
        {
            [co addheader:@"ETag" value:e_tag];
        }
        NSString* l_modify = [CommonUtils getString:dic key:@"Last-Modify"];
        if( l_modify != nil)
        {
            [co addheader:@"Last-Modify" value:l_modify];
        }
        
        NSArray* new_cookie =  [NSHTTPCookie cookiesWithResponseHeaderFields:dic forURL:response.URL];
        int i ;
        for (i = 0; i < [new_cookie count]; i++)
        {
            NSHTTPCookie *cookie = [new_cookie objectAtIndex:i];
            [[CCookie shareInstance] addCookie:task.url key: cookie.name value:cookie.value];
        }

        
        if( cookie != nil  &&  cookie.length > 0)
        {
            NSLog(@"====%@",cookie);
            [co addheader:@"Cookie" value:cookie];
        }
        
        XLog(@"dataTaskWithRequest onFail request:=response:  %@",cookie);

        if( content_type == nil  && data != nil)
        {
            co.content  =   [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
        }
        else if( data != nil  && content_type != nil  && ([content_type rangeOfString:@"text"].location != NSNotFound
                                                     || [content_type rangeOfString:@"html"].location != NSNotFound
                                                     || [content_type rangeOfString:@"json"].location != NSNotFound
                                                     || [content_type rangeOfString:@"plain"].location != NSNotFound)   )
        {
            if( [content_type containsString:@"GBK"] || [content_type containsString:@"gbk"])
            {
                NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
                co.content = [[NSString alloc] initWithData:data encoding:enc] ;
            }
            else
                co.content  =   [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
        }
        else if( data != nil)
        {
            NSString*  base64Encoded =[data base64EncodedStringWithOptions:0];
            co.content = base64Encoded;
        }
        
        [co fill];
        [self pushCURL:co];
    }];

    [c_task resume];
}



-(void)pushCURL:(CURLOutput*) task
{
    [self doRequest:task];
}

// 工作中直接复制这一段代理Ok了
// 金融公司
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * __nullable credential))completionHandler {
    NSLog(@"%@",challenge.protectionSpace);
    // 如果是请求证书信任，我们再来处理，其他的不需要处理
    if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
        NSURLCredential *cre = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        // 调用block
        completionHandler(NSURLSessionAuthChallengeUseCredential,cre);
    }
}


-(void) onSuccess:(XRequest*) request response:(XResponse*) response
{
    if( request == nil  || request.cmd == nil)
        return ;
    
    if( [request.cmd  isEqualToString:@"curl.data"])
    {
        if( response.errorCode == 0 && response.o_ret != nil)
        {
            CURLInput* input = [[CURLInput alloc] initWithDic:response.o_ret];
            if( input != nil  && input.url != nil  && input.url.length > 0)
            {
                [self addTask:input];
            }
        }
    }
}


-(void) onFail:(XRequest*) request   response:(XResponse*) response
{
    XLog(@"CURLEngine onFail request:%@=response:%@",request.cmd,response.raw_Json);
}

@end
