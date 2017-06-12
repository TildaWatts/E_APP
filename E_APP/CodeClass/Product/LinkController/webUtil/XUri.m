//
//  XUri.m
//  Faith in life
//
//  Created by alexanxiong on 16/10/18.
//  Copyright © 2016年 Xinnuo. All rights reserved.
//

#import "XUri.h"
#import "XDLog.h"
#import "CommonUtils.h"

@implementation XUri

+(XUri*) parseFromString:(NSString*) urlStr
{
    NSLog(@"%s",__func__);

    NSURL *url = [NSURL URLWithString:urlStr];
    
    XUri* uri = [[XUri alloc] init];
    uri.raw_str   = urlStr;
    uri.scheme    = url.scheme;
    uri.host      = url.host;

    
    if( url.path != nil && url.path.length > 1)
    {
        NSString* str = [url.path substringFromIndex:1];
        uri.paths = [str componentsSeparatedByString:@"/"];
    }

    if( url.query != nil)
    {
        NSArray<NSString*>* array  = [url.query componentsSeparatedByString:@"&"];
        if( array != nil && array.count > 0)
        {
            uri.querys = [[NSMutableDictionary alloc] init];
            for( int i = 0 ;i < array.count ;i++)
            {
                NSArray<NSString*>* t_array  = [array[i] componentsSeparatedByString:@"="];
                if(t_array.lastObject != nil)
                uri.querys[t_array.firstObject]  =  [CommonUtils URLDecodedString:t_array.lastObject];
            }
        }
    }
    

    return uri;
}

@end


