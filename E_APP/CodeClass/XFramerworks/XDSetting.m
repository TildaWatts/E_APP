//
//  Setting.m
//  Faith in life
//
//  Created by alexanxiong on 16/5/13.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#import "XDSetting.h"
#import "DataCenter.h"

#define LAST_LANCH_TIME  @"lauch_time"
#define LAST_LOGIN_TIME  @"login_time"

#define KEY_UID          @"uid"
#define KEY_TOKEN        @"token"
#define KEY_SESSIONKEY   @"sessionkey"
#define KEY_PHONE        @"phone"


@implementation XDSetting

+(id) get:(NSString*) key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey: key];
}

+(void)set:(NSString*) key value:(id) obj
{
    return [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];;
}

+(NSString*) getString:(NSString*) key
{
    return [[NSUserDefaults standardUserDefaults] stringForKey: key];
}

+(void)      setString:(NSString*) key value:(NSString*) str
{
    return [[NSUserDefaults standardUserDefaults] setObject:str forKey:key];;
}

+(BOOL) getBool:(NSString*) key
{
    return [[NSUserDefaults standardUserDefaults] boolForKey: key];
}
+(void)setBool:(NSString*) key value:(BOOL) bValue
{
    return [[NSUserDefaults standardUserDefaults] setBool:bValue forKey:key];;
}

+(NSInteger) getInt:(NSString*) key
{
    return [[NSUserDefaults standardUserDefaults] integerForKey: key];
}

+(void) setInt:(NSString*) key value:(int) iValue
{
    return [[NSUserDefaults standardUserDefaults] setInteger:iValue forKey:key];;
}

+(double) getDouble:(NSString*) key
{
    return [[NSUserDefaults standardUserDefaults] doubleForKey: key];
}
+(void) setDouble:(NSString*) key value:(double) dValue
{
    return [[NSUserDefaults standardUserDefaults] setDouble:dValue forKey:key];;
}

+(int64_t) getInt64:(NSString*) key
{
    int64_t i64 =  0;
    NSString* n_str =  [[NSUserDefaults standardUserDefaults] stringForKey: key];
    if(n_str != nil)
    {
        i64 = atoll([n_str UTF8String]);
    }
    return i64;
}

+(void)    setInt64:(NSString*) key value:(int64_t) i64Value;
{
    NSString* format = [NSString stringWithFormat:@"%lld",i64Value];
    return [[NSUserDefaults standardUserDefaults] setObject:format forKey:key];;
}

+(double) getLastLauchTime  ;
{
    return [XDSetting getDouble:LAST_LANCH_TIME];
}

+(double)    setLauch
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [dat timeIntervalSince1970];

    [XDSetting setDouble : LAST_LANCH_TIME value: time];
    
    return time;
}

+(double) getLoginTime
{
    return [XDSetting getDouble:LAST_LOGIN_TIME];
}

+(double)    setLogin
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [dat timeIntervalSince1970];
    
    [XDSetting setDouble : LAST_LOGIN_TIME value: time];
    
    [DataCenter shareInstance].lastLoginTime = time;
    
    return time;
}

+(int)    getUID
{
    return (int) [XDSetting getInt:KEY_UID];
}

+(void)   setUID:(int) uid
{
    [DataCenter shareInstance].uid = uid;
    return [XDSetting setInt:KEY_UID value:uid];
}

+(NSString*)    getToken
{
    return [XDSetting getString:KEY_TOKEN];
}

+(void)   setToken:(NSString*) token
{
    [DataCenter shareInstance].token = token;
    return [XDSetting setString:KEY_TOKEN value:token];
}

+(NSString*)    getSessionKey
{
    return [XDSetting getString:KEY_SESSIONKEY];
}

+(void)   setSessionKey:(NSString*) key
{
    [DataCenter shareInstance].sessionkey = key;
    return [XDSetting setString:KEY_SESSIONKEY value:key];
}

+(NSString*)    getPhone
{
    return [XDSetting getString:KEY_PHONE];
}

+(void)   setPhone:(NSString*) phone
{
    [DataCenter shareInstance].phone = phone;
    return [XDSetting setString:KEY_PHONE value:phone];
}

@end