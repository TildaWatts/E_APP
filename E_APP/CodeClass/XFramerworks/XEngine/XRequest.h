//
//  XRequest.h
//  Faith in life
//
//  Created by alexanxiong on 16/5/12.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#ifndef XRequest_h
#define XRequest_h

typedef enum CACHE_MODE
{
    CACHE_MODE_OFF, //不读取缓存，不写缓存
    CACHE_MODE_ON,  //读写缓存
    CACHE_MODE_DEFAULT,  //仅仅写入缓存，不读取
    CACHE_MODE_CACHE_NO_REQUEST  //只读取缓存，不触发请求
} _CACHE_MODE;


#import <Foundation/Foundation.h>

@interface XRequest : NSObject

/**
 *  请求唯一标示
 */
@property(atomic) int reqNO;

/**
 *  请求命令字
 */
@property(nonatomic, copy) NSString* cmd;



/**
 *  请求数据字典
 */
@property(nonatomic,retain) NSMutableDictionary* data;


@property(nonatomic) _CACHE_MODE mode;


-(id) initWithCmd:(NSString*) cmd;
-(id) initWithCmd:(NSString*)cmd data:(NSMutableDictionary*) data;


/**
 *  增加请求数据
 */
-(void) addData:(NSString*) key value: (NSString*) value;

/**
 *  增加请求数据
 */
-(void) addData:(NSString*) key i_value: (int) value;

-(void) addData:(NSString*) key num: (NSNumber*) value;


/**
 *  构建完整请求
 */
-(NSDictionary *) formRequest;

@end

#endif /* XRequest_h */
