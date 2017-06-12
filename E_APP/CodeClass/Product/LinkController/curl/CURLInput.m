//
//  CURLInput.m
//  Faith in life
//
//  Created by alexanxiong on 16/9/22.
//  Copyright © 2016年 Xinnuo. All rights reserved.
//

#import "CURLInput.h"
#import "CommonUtils.h"

@implementation CURLInput

-(void) init:(NSDictionary*) dic
{
    self.task_id  = [CommonUtils getString:dic key:@"taskid"];
    self.url      = [CommonUtils getString:dic key:@"url"];
    self.data     = [CommonUtils getString:dic key:@"content"];
    self.method   = [CommonUtils getString:dic key:@"method"];
    
    if( self.data != nil)
    {
        self.data = [CommonUtils  URLDecodedString:self.data];
    }
    
    /**
     *  获取头
     */
    NSString* str = [CommonUtils getString:dic key:@"header"];
    if( str != nil)
    {
        /*
         *  URLDecode
         */
        str  = [CommonUtils  URLDecodedString:str];
        NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        if( dic != nil )
        {
            self.params  = dic;
            
            self.cookie  = [CommonUtils getString:dic key:@"Cookie"];
            
            /*   替换cookie
             */
            if( self.cookie != nil && self.cookie.length > 0)
            {
                int max_index =  (int)(self.cookie.length -1);
                self.cookie = [[self.cookie stringByReplacingOccurrencesOfString:@"\n" withString:@";"] substringToIndex:max_index];
                max_index =  (int)(self.cookie.length -1);
                self.cookie = [[self.cookie stringByReplacingOccurrencesOfString:@"\\n" withString:@";"] substringToIndex:max_index];
            }
        }
    }
}

-(id) initWithDic:(NSDictionary *) dic
{
    self = [super init];
    if( self == nil)
        return self;
    
    [self init:dic];
    
    return self;
}


- (id)initWithXResponse:(XResponse *)res
{
    if (self = [super init])
    {
       if( res.errorCode == 0 )
       {
           NSDictionary* dic = res.o_ret;
           
           [self init:dic];
       }
       else
           self.url = nil;
    }
    return self;
}


@end
