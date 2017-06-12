//
//  CCookie.h
//  Faith in life
//
//  Created by alexanxiong on 16/9/23.
//  Copyright © 2016年 Xinnuo. All rights reserved.
//

#ifndef CCookie_h
#define CCookie_h


@interface CCookie : NSObject

+ (CCookie *)shareInstance;
@property (nonatomic, strong) NSMutableDictionary * dic;

+(NSString*) getHost:(NSString*) str;
+(NSString*) getCookieKey:(NSString*) key;

-(void)     addCookie:(NSString*) url key:(NSString*) key value:(NSString*) value;
-(NSString*)     getCookie:(NSString*) url ;
-(NSString*)     getCookieDisplay:(NSString*) url;
-(void)     removeCookie:(NSString*) url;

@end

#endif /* CCookie_h */
