//
//  CCookie.m
//  Faith in life
//
//  Created by alexanxiong on 16/9/23.
//  Copyright © 2016年 Xinnuo. All rights reserved.
//

#import "CCookie.h"

@implementation CCookie

static  CCookie* _instance = nil;

+ (CCookie *)shareInstance
{
    @synchronized (self)
    {
        if( _instance == nil)
        {
            _instance = [[CCookie alloc] init] ;
            _instance.dic  =  [[NSMutableDictionary alloc] init];
        }
    }
    return _instance ;
}

+(NSString*) getHost:(NSString*) url
{
    NSRange range = [url rangeOfString:@"[\\w-]+\\.(com.cn|net.cn|gov.cn|org.cn|com|net|org|gov|cc|biz|info|cn|co)\\b()*" options:NSRegularExpressionSearch];
    
    if (range.location != NSNotFound)
    {
        return [url substringWithRange:range];
    }
    else
        return url;
}


-(void)     removeCookie:(NSString*) url
{
    NSString* host = [CCookie getHost:url];
    if( self.dic != nil  && host != nil)
        self.dic[host] = nil;
}

-(NSString*)     getCookie:(NSString*) url
{
    NSString* cookie = @"";
    NSString* host = [CCookie getHost:url];
    if( host == nil)
    {
        id i_v = self.dic[host];
        if( i_v != nil )
        {
            NSMutableDictionary* dict = i_v ;
            for (NSString* key in dict)
            {
                if( cookie.length > 0)
                    cookie = [cookie stringByAppendingString:@"; "];
                cookie = [cookie stringByAppendingString:dict[key]];
            }
        }
    }
    return cookie;
}


-(NSString*)     getCookieDisplay:(NSString*) url
{
    NSString* cookie = @"";
    NSString* host = [CCookie getHost:url];
    if( host == nil)
    {
        id i_v = self.dic[host];
        if( i_v != nil)
        {
            NSMutableDictionary* dict = i_v ;
            for (NSString* key in dict)
            {
                if( cookie.length > 0)
                    cookie = [cookie stringByAppendingString:@"\n"];
                cookie = [cookie stringByAppendingString:dict[key]];
            }
        }
    }
    return cookie;
}

-(void)     addCookie:(NSString*) url key:(NSString*) key value:(NSString*) value
{
    if( key == nil  || value == nil)
        return ;
    
    NSString* host = [CCookie getHost:url];
    if( host == nil)
        return ;
    if( self.dic[host] == nil)
        self.dic[host]  =  [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary* dict = self.dic[host];
    dict[key]  = value;
}

+(NSString*) getCookieKey:(NSString*) url
{
    NSArray *subitemStrs = [url componentsSeparatedByString:@"="];
    if( subitemStrs.count > 0)
        return subitemStrs.firstObject;
    return url;
}

@end
