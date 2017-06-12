//
//  CommonUtils.m
//  Faith in life
//
//  Created by alexanxiong on 16/5/12.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#import "CommonUtils.h"

@implementation CommonUtils

static int _id = 0;

+(int) getUniqueID
{
    @synchronized (self)
    {
        ++_id;
    }
    return _id;
}

+(NSString *)URLDecodedString:(NSString *)str
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}

+(NSString*) int2NString:(int) i
{
    return [NSString stringWithFormat:@"%d",i];
}

+(NSString*) long2NString:(long) i
{
    return [NSString stringWithFormat:@"%ld",i];;
}


+ (NSString*) getString:(NSDictionary*) dic key:(NSString*) key
{
    id value = [dic objectForKey:key];
    if( value != nil && [value isKindOfClass:[NSString class]  ])
    {
        return value;
    }
    if( value != nil  && [value isKindOfClass:[NSNumber class]])
    {
        NSNumber* number = value;
        return [number stringValue];
    }
    return nil;
}

+ (int)       getInt:(NSDictionary*) dic key:(NSString*) key;
{
    id value = [dic objectForKey:key];
    if( value != nil  && [value isKindOfClass:[NSNumber class]])
    {
        NSNumber* number = value;
        return  [number intValue];
    }
    else if( value != nil  &&  [value isKindOfClass:[NSString class]])
    {
        NSString* str = value;
        return [str intValue];
    }
    return 0;
}

+ (double)       getDouble:(NSDictionary*) dic key:(NSString*) key
{
    id value = [dic objectForKey:key];
    if( value != nil  && [value isKindOfClass:[NSNumber class]])
    {
        NSNumber* number = value;
        return  [number doubleValue];
    }
    else if( value != nil  &&  [value isKindOfClass:[NSString class]])
    {
        NSString* str = value;
        return [str doubleValue];
    }
    return 0;
}


+ (BOOL)       getBool:(NSDictionary*) dic key:(NSString*) key
{
    id value = [dic objectForKey:key];
    if( value != nil  && [value isKindOfClass:[NSNumber class]])
    {
        NSNumber* number = value;
        return  [number boolValue];
    }
    else if( value != nil  &&  [value isKindOfClass:[NSString class]])
    {
        NSString* str = value;
        return [str boolValue];
    }
    return 0;
}

+ (NSDictionary*) getDic:(NSDictionary*) dic key:(NSString*) key
{
    id value = [dic objectForKey:key];
    if( value != nil &&  [value isKindOfClass:[NSDictionary class]  ])
    {
        return value;
    }
    return nil;
}

+ (NSArray *)getArray:(NSDictionary *) dic key:(NSString *)key
{
    id value = [dic objectForKey:key];
    if( value != nil &&  [value isKindOfClass:[NSArray class]  ])
    {
        return value;
    }
    return nil;
}

+(NSData*)   getChunkedData:(NSData*)     data
{
    if( data == nil || data.length < 6)
        return nil;
    
    NSData* n_data = nil;
    int       len = 0;
    NSRange ran ;
    ran.location = 0;
    ran.length   = 4;
    
    BOOL bNext = YES;
    while( bNext )
    {
        NSData* t_data =  [data subdataWithRange:ran];
        if( t_data != nil)
        {
            NSString* str = [[NSString alloc] initWithData:t_data  encoding:NSUTF8StringEncoding];
            if( str != nil &&[str isEqualToString:@"\r\n\r\n"])
            {
                ran.location = ran.location+4;
                ran.length   = 4;
            }
            else if( str != nil)
            {
                len =  [str intValue];

                ran.location = ran.location+2;
                ran.length   = len;
                
                bNext = false;
                break;
            }
            else
            {
                break;
            }
            
        }
        else
        {
            break;
        }
    }
    

    
    if( len > 0)
    {
        n_data = [data subdataWithRange:ran];
    }
    else
        n_data = data;
    
    return n_data;
}

@end
