//
//  LinkCenter.m
//  Faith in life
//
//  Created by Ezra on 16/11/9.
//  Copyright © 2016年 Xinnuo. All rights reserved.
//

#import "LinkCenter.h"
#import <objc/runtime.h>

#import "WKWebViewController.h"
#import "LocalVcBridge.h"
#import "AppDelegate.h"
#import "NSString+URL.h"


#define QR_SIGN_APPEND @"@xinnuo.info"


@implementation LinkCenter


/**
 跳转中心，可跳转本地控制器和web

 @param vc 当前控制器 self
 @param url 目标url
 @param obj obj为字符串时即为目标控制器的title 
            obj为字典时的key：title(NSString)标题  nothidetoolbar(id)不隐藏web工具栏
 */

+ (void)centerForJumpLink:(UIViewController *)vc action:(NSString *)url otherObj:(id)obj

{
    XUri *uri = [XUri parseFromString:url];
    NSString *scheme = uri.scheme;
    
    if ([scheme isEqualToString:SCHEME_HTTP] || [scheme isEqualToString:SCHEME_HTTPS]) {
        [self handleHttpUri:uri object:vc object:obj];
    }
    else if ([scheme isEqualToString:SCHEME_XINNUO])
    {
        if( ![obj isKindOfClass:[NSDictionary class] ])
        {
            obj = nil;
        }
        [LocalVcBridge LinkDestinationVc:uri obj:vc dict:obj];
    }
    else
    {
    }
}

+ (void)center2Page:(UIViewController *)vc page:(NSString *) page otherObj:(id)obj
{
    [LocalVcBridge forward2Page:page obj:vc dict:obj uri:nil];
}

+ (void)forward2Page:(UIViewController *)vc view:(UIViewController *) page
{
    [vc.navigationController pushViewController:page animated:YES];
}

//跳转控制器
+ (void)forward2Page:(UIViewController *)vc class:(Class) class
{
    UIViewController* view = [[class alloc] init];
    [self forward2Page:vc view:view];
}

+ (void)handleHttpUri:(XUri *)uri object:(UIViewController *)vc object:(id)obj
{
    // 是H5界面
    WKWebViewController *webVc = [[WKWebViewController alloc] initWithUrlStr:uri.raw_str];
    if ([obj isKindOfClass:[NSString class]])webVc.title = obj;
    
    [vc.navigationController pushViewController:webVc animated:YES];
}

+(NSString*) formBindStoreQRCode
{
    NSString* bind_action = [NSString stringWithFormat:@"%@://%@",SCHEME_XINNUO,ACTION_BIND_STORE_MID];
    NSString* action      = [NSString stringWithFormat:@"%@://%@?action=%@",SCHEME_XINNUO,ACTION_QRCODE,[NSString encodeString:bind_action] ];
    return action;
}

+ (BOOL)checkQrCodeWithUrlStr:(XUri*) uri want_action:(XUri*) want_action
{
    if( uri == nil  || uri.querys == nil)
        return NO;
    
    if( ![uri.scheme isEqualToString:SCHEME_HTTP] && ![uri.scheme isEqualToString:SCHEME_HTTPS])
        return NO;
    
    // 获得sign
    NSString *sign = uri.querys[@"sign"] ;
    if( sign == nil)
        return NO;
    
    // 生成sign
    NSString *signKeyValue = [NSString stringWithFormat:@"&sign=%@",sign];
    NSString *tickSignStr = [uri.raw_str stringByReplacingOccurrencesOfString:signKeyValue withString:@""];
    
    NSString *newStr = [NSString stringWithFormat:@"%@%@",tickSignStr,QR_SIGN_APPEND];
    
    NSString *md5NewStr = [[newStr md5String] uppercaseString];
    
    sign = [sign uppercaseString];
    if (![md5NewStr isEqualToString:sign]) {  // 不相等直接返回
        return NO;
    }
    
    NSString* action = uri.querys[@"action"];
    if(action == nil)
        return NO;
    
    XUri* url_action = [XUri parseFromString:action];
    
    if( url_action == nil  || ![url_action.scheme isEqualToString:SCHEME_XINNUO] )
    {
        return NO;
    }
    
    if ([ACTION_BIND_STORE_MID isEqualToString:want_action.host] && [ACTION_PAY isEqualToString:url_action.host])
    {
        uri.querys[@"action"] = [url_action.raw_str stringByReplacingOccurrencesOfString:@"xinnuo://pay" withString:@"xinnuo://mid"];
        return YES;
    }
    else if( want_action && [SCHEME_XINNUO isEqualToString:want_action.scheme] && [ACTION_BIND_STORE_MID isEqualToString:want_action.host]
       && [ACTION_BIND_STORE_MID isEqualToString:url_action.host])
    {
        return YES;
    }
    else if( [ACTION_PAY isEqualToString:url_action.host] && (want_action ==nil || [ACTION_PAY isEqualToString:want_action.host]) )
    {
        return YES;
    }


    return NO;
}

@end
