//
//  WebViewUtil.m
//  Faith in life
//
//  Created by alexanxiong on 16/10/18.
//  Copyright © 2016年 Xinnuo. All rights reserved.
//

#import "WebViewUtil.h"
#import "XUri.h"

@implementation WebViewUtil

+ (NSString *)handleUrlStrWithUrl:(NSString *)urlStr
{
    NSString *finalUrl = urlStr;
    
    // 1.拼接UID和sessionkey
    XUri* uri = [XUri parseFromString:urlStr]  ;
    if( uri   && ([uri.host isEqualToString:@"192.168.1.11"] ||
       [uri.host isEqualToString:@"static.xinnuo.info"] || [uri.host isEqualToString:@"app.xinnuo.info"])  )
    {
        NSInteger uid = [DataCenter shareInstance].uid;
        NSString *sessionkey = [DataCenter shareInstance].sessionkey;
        
        
        if ([urlStr containsString:@"?"]) {
            finalUrl = [NSString stringWithFormat:@"%@&uid=%zd&sessionkey=%@",urlStr,uid,sessionkey];
        } else {
            finalUrl = [NSString stringWithFormat:@"%@?uid=%zd&sessionkey=%@",urlStr,uid,sessionkey];
        }
        
        // 2.截取cid和pid
        [self sendSTDataWithUlrStr:urlStr];
    }

    
    return finalUrl;
}

// 发送统计数据
+ (void)sendSTDataWithUlrStr:(NSString *)urlStr
{
    // 2.截取cid和pid
    //    "http://house.baidu.com/cn/wap/calcul/pg?cid=3130400000000"
    
    XUri* uri = [XUri parseFromString:urlStr];
    if( uri != nil && uri.querys!= nil)
    {
//        NSString* pid = uri.querys[@"pid"];
//        NSString* cid = uri.querys[@"cid"];
//        
//        if( pid != nil)
////            [XDTracker sendViewsWithID:pid];
//        if( cid != nil)
//            [XDTracker sendEventWithID:cid result:YES];
    }
}

+ (void) deleteCookies:(NSString*) url
{
    NSHTTPCookieStorage *sharedHTTPCookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [sharedHTTPCookieStorage cookiesForURL:[NSURL URLWithString:url]];
    
    for (NSHTTPCookie *cookie in cookies) {
        [sharedHTTPCookieStorage deleteCookie:cookie];
    }
}



+ (NSString *)getCookieWithRequest:(NSMutableURLRequest *)request url:(NSString*) url
{
    NSHTTPCookieStorage *sharedHTTPCookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [sharedHTTPCookieStorage cookiesForURL:[NSURL URLWithString:url]];
    if (cookies == nil) {
        return nil;
    }
    NSDictionary * headers = [NSHTTPCookie requestHeaderFieldsWithCookies: cookies];
    
    if (cookies.count != 0) {
        [request setHTTPMethod:@"Post"];
        [request setHTTPShouldHandleCookies:YES];
        [request setAllHTTPHeaderFields:headers];
        
        NSString *cookie = [[request allHTTPHeaderFields] objectForKey:@"cookie"];
        NSLog(@"Request: %@", [[request allHTTPHeaderFields] objectForKey:@"cookie"]);
        return cookie;
    }
    return nil;
}

/**
 *  查询cookies
 */
+ (void)queryCookies:(NSString*) url
{
    
    NSHTTPCookieStorage *sharedHTTPCookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [sharedHTTPCookieStorage cookiesForURL:[NSURL URLWithString:url]];
    NSEnumerator *enumerator = [cookies objectEnumerator];
    NSHTTPCookie *cookie;
    while (cookie = [enumerator nextObject]) {
        NSLog(@"COOKIE{name: %@, value: %@}", [cookie name], [cookie value]);
    }
    
}

+ (void) dumpCookies:(NSString *)msgOrNil
{
    NSMutableString *cookieDescs    = [[NSMutableString alloc] init];
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [cookieJar cookies]) {
        [cookieDescs appendString:[self cookieDescription:cookie]];
    }
    NSLog(@"------ [Cookie Dump: %@] ---------\n%@", msgOrNil, cookieDescs);
    NSLog(@"----------------------------------");
}

+ (NSString *) cookieDescription:(NSHTTPCookie *)cookie
{
    
    NSMutableString *cDesc      = [[NSMutableString alloc] init];
    [cDesc appendString:@"[NSHTTPCookie]\n"];
    [cDesc appendFormat:@"  name            = %@\n",            [[cookie name] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [cDesc appendFormat:@"  value           = %@\n",            [[cookie value] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [cDesc appendFormat:@"  domain          = %@\n",            [cookie domain]];
    [cDesc appendFormat:@"  path            = %@\n",            [cookie path]];
    [cDesc appendFormat:@"  expiresDate     = %@\n",            [cookie expiresDate]];
    [cDesc appendFormat:@"  sessionOnly     = %d\n",            [cookie isSessionOnly]];
    [cDesc appendFormat:@"  secure          = %d\n",            [cookie isSecure]];
    [cDesc appendFormat:@"  comment         = %@\n",            [cookie comment]];
    [cDesc appendFormat:@"  commentURL      = %@\n",            [cookie commentURL]];
    [cDesc appendFormat:@"  version         = %lu\n",            (unsigned long)[cookie version]];
    
    return cDesc;
}



@end
