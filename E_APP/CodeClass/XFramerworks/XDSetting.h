//
//  Setting.h
//  Faith in life
//
//  Created by alexanxiong on 16/5/13.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#ifndef Setting_h
#define Setting_h


@interface XDSetting : NSObject
//******基本存取接口
+(id) get:(NSString*) key;
+(void)set:(NSString*) key value:(id) obj;

+(NSString*) getString:(NSString*) key;
+(void)      setString:(NSString*) key value:(NSString*) str;

+(BOOL) getBool:(NSString*) key;
+(void) setBool:(NSString*) key value:(BOOL) bValue;

+(NSInteger) getInt:(NSString*) key;
+(void) setInt:(NSString*) key value:(int) iValue;

+(double) getDouble:(NSString*) key;
+(void) setDouble:(NSString*) key value:(double) dValue;

+(int64_t) getInt64:(NSString*) key;
+(void)    setInt64:(NSString*) key value:(int64_t) i64Value;

//***** 特定接口
/**
 *  获取上次启动时间。不建议外部调用该接口
 *  建议使用 DataCenter thisLauchTime lastLauchTime 替代
 */
+(double) getLastLauchTime  ;

/**
 *   设置启动时间。DataCenter 初始化使用，不建议调用
 */
+(double)    setLauch  ;

/**
 *  获取上次登录时间。
 */
+(double) getLoginTime  ;

/**
 *  设置上次登录时间。登录模块调用，不建议外部调用
 */
+(double)    setLogin  ;

/**
 *  获取用户ID。之前登录成功 未主动登出或者T出用户仍然有效
 *  0 表示无使用用户
 *  登录模块调用。不建议外部调用
 *  其他模块建议使用 DataCenter.uid
 */
+(int)    getUID;

/**
 *  设置用户ID。登录模块调用，不建议外部调用
 */
+(void)   setUID:(int) uid;

/**
 *  获取用户Token。之前登录成功 未主动登出或者T出用户仍然有效
 *  nil 表示无使用用户
 *  登录模块调用。不建议外部调用
 *  其他模块建议使用 DataCenter.token
 *  @warning 该数据不要泄露，不允许出现在 log、理论上不能明文传输
 */
+(NSString*)    getToken;

/**
 *  设置用户Token。登录模块调用，不建议外部调用
 */
+(void)   setToken:(NSString*) token;

/**
 *  获取用户Session。之前登录成功 未主动登出或者T出用户仍然有效
 *  nil 表示无使用用户
 *  登录模块调用。不建议外部调用
 *  其他模块建议使用 DataCenter.sessionkey
 *  @warning 该数据不要泄露，不允许出现在 log、理论上不能明文传输
 */
+(NSString*)    getSessionKey;

/**
 *  设置用户session。登录模块调用，不建议外部调用
 */
+(void)   setSessionKey:(NSString*) key;

/**
 *  获取用户phone。之前登录成功 未主动登出或者T出用户仍然有效
 *  nil 表示无使用用户
 *  登录模块调用。不建议外部调用
 *  其他模块建议使用 DataCenter.phone
 *  @warning 该数据不要泄露，不允许出现在 log、理论上不能明文传输
 */
+(NSString*)    getPhone;

/**
 *  设置用户phone。登录模块调用，不建议外部调用
 */
+(void)   setPhone:(NSString*) key;

@end

#endif /* XDSetting_h */
