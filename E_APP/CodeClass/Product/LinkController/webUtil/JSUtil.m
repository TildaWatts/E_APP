//
//  JSUtil.m
//  Faith in life
//
//  Created by alexanxiong on 16/10/18.
//  Copyright © 2016年 Xinnuo. All rights reserved.
//

#import "JSUtil.h"

@implementation JSUtil

+(NSString*) formatJS:(NSString*) method s_ret:(NSString*) s_str
{
    NSMutableString *finalJsStr = [NSMutableString string];
    [finalJsStr appendFormat:@"if(!!window.%@){%@(%@)};",method,method,s_str];
    return finalJsStr;
}

+(NSString*) formatXJS:(NSString*) callback seqid:(NSString*) seqid method:(NSString*) method s_ret:(NSString*) s_ret
{
    return [self formatXJS:callback seqid:seqid method:method s_ret:s_ret data:nil];
}

+(NSString*) formatXJS:(NSString*) callback seqid:(NSString*) seqid method:(NSString*) method s_ret:(NSString*) s_ret  data:(NSString*) data
{
    NSMutableDictionary *finalDict = [NSMutableDictionary dictionary];
    if( data != nil)
        finalDict[@"data"] = data;
    if( s_ret != nil)
        finalDict[@"result"] = s_ret;
    if( seqid != nil)
        finalDict[@"seqid"] =  seqid;
    if( method != nil)
        finalDict[@"method"] = method;
    
    // 将字典转换成json字符串
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:finalDict options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *finalDictJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return [self formatJS:callback s_ret:finalDictJson];
}

@end
