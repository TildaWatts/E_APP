//
//  WebViewUtil.h
//  Faith in life
//
//  Created by alexanxiong on 16/10/18.
//  Copyright © 2016年 Xinnuo. All rights reserved.
//

#ifndef WebViewUtil_h
#define WebViewUtil_h

@interface WebViewUtil : NSObject

+ (NSString *)handleUrlStrWithUrl:(NSString *)urlStr;
+ (void)sendSTDataWithUlrStr:(NSString *)urlStr     ;
+ (NSString *)getCookieWithRequest:(NSMutableURLRequest *)request url:(NSString*) url;
+ (void)queryCookies:(NSString*) url;
+ (void) dumpCookies:(NSString *)msgOrNil;
+ (NSString *) cookieDescription:(NSHTTPCookie *)cookie;
+ (void) deleteCookies:(NSString*) url;
@end

#endif /* WebViewUtil_h */
