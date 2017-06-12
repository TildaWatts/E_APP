//
//  JSUtil.h
//  Faith in life
//
//  Created by alexanxiong on 16/10/18.
//  Copyright © 2016年 Xinnuo. All rights reserved.
//

#ifndef JSUtil_h
#define JSUtil_h

@interface JSUtil : NSObject

+(NSString*) formatJS:(NSString*) method s_ret:(NSString*) s_str;
+(NSString*) formatXJS:(NSString*) callback seqid:(NSString*) seqid method:(NSString*) method s_ret:(NSString*) s_ret  data:(NSString*)  data;
+(NSString*) formatXJS:(NSString*) callback seqid:(NSString*) seqid method:(NSString*) method s_ret:(NSString*) s_ret  ;



@end

#endif /* JSUtil_h */
