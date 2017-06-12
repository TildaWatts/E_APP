//
//  XResponse.h
//  Faith in life
//
//  Created by alexanxiong on 16/5/12.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

//#ifndef XResponse_h
//#define XResponse_h

#import <Foundation/Foundation.h>

@interface XResponse : NSObject

/**
 *  服务器原生数据
 */
@property (nonatomic, nullable,strong) NSDictionary *raw_Json;

/**
 *  是否是缓存
 */
@property(atomic) BOOL isCache;

/**
 * 同XRequest.reqNo .本地数据
 */
@property(atomic) int reqNO;


/**
 * 服务器返回的命令字。含义同 XRequest.cmd
 */
@property(nonatomic,nullable, copy) NSString* cmd;

/**
 * 服务器返回的错误描述。
 */
@property(nonatomic,nullable, copy) NSString* message;

/**
 * 服务器返回的header。当收到服务器header时需要覆盖本地header。参见XHead
 */
@property(nonatomic,nullable,strong) NSDictionary* header;

/**
 * 服务器返回码。参见 ErrorCode.h
 */
@property(nonatomic) int errorCode;

/**
 * 服务器返回业务错误码。参见 ErrorCode.h
 */
@property(nonatomic) int bizCode;


/**
 * 服务器返回的简单整数型返回数据
 */
@property(nonatomic) int i_ret;

/**
 * 服务器返回的简单字符串返回数据
 */
@property(nonatomic,nullable,copy) NSString* s_ret;

/**
 * 服务器返回的JSON返回数据
 */
@property(nonatomic,nullable,strong) id o_ret;

/**
 * 本地辅助id。用于参数传递
 */
@property(nonatomic) int local_id;

/**
 * 本地辅助数据。用于参数传递
 */
@property(nonatomic,nullable, copy) NSString* local_ext;

-(void) loadData :(nullable id) obj;
-(void) loadDic :(nullable NSDictionary*) dic fromCache:(BOOL) bFromCache;
-(nullable id)   loadFromCache  ;

/**
 *  保存用户缓存。登出或者切换账号需要清理缓存
 */
-(void) saveCache;

/**
 *  保存APP缓存。正常情况下缓存不用清理
 */
-(void) saveAppCache;


-(nullable NSDictionary *) loadCache;

-(nonnull id) init;



- (nullable id)loadFromSql_cache;

- (void)saveSql_cache;

@end



/**
 XData
 */
@interface XData : XResponse

-(nonnull id) initWithXResponse:(nullable XResponse*) res;

@end

/**
 XItem
 */
#ifndef XItem_h
#define XItem_h

@interface  XItem :NSObject

//- (id)initWithDict:(NSDictionary *)res ;
-(id _Nullable )initWithDict:(NSDictionary *_Nullable)res;

@end
#endif /* XItem_h */







