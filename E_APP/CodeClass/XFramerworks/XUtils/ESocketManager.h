//
//  ESocketManager.h
//  E_APP
//
//  Created by Ezra on 2017/6/15.
//  Copyright © 2017年 Ezra. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *
 *  socket状态
 */
typedef NS_ENUM(NSInteger,ESocketStatus){
    ESocketStatusConnected,// 已连接
    ESocketStatusFailed,// 失败
    ESocketStatusClosedByServer,// 系统关闭
    ESocketStatusClosedByUser,// 用户关闭
    ESocketStatusReceived// 接收消息
};
/**
 *
 *  消息类型
 */
typedef NS_ENUM(NSInteger,ESocketReceiveType){
    ESocketReceiveTypeForMessage,
    ESocketReceiveTypeForPong
};
/**
 *
 *  连接成功回调
 */
typedef void(^ESocketDidConnectBlock)();
/**
 *
 *  失败回调
 */
typedef void(^ESocketDidFailBlock)(NSError *error);
/**
 *
 *  关闭回调
 */
typedef void(^ESocketDidCloseBlock)(NSInteger code,NSString *reason,BOOL wasClean);
/**
 *
 *  消息接收回调
 */
typedef void(^ESocketDidReceiveBlock)(id message ,ESocketReceiveType type);
@interface ESocketManager : NSObject




/**
 *
 *  连接回调
 */
@property (nonatomic,copy)ESocketDidConnectBlock connect;
/**
 *
 *  接收消息回调
 */
@property (nonatomic,copy)ESocketDidReceiveBlock receive;
/**
 *
 *  失败回调
 */
@property (nonatomic,copy)ESocketDidFailBlock failure;
/**
 *
 *  关闭回调
 */
@property (nonatomic,copy)ESocketDidCloseBlock close;
/**
 *
 *  当前的socket状态
 */
@property (nonatomic,assign,readonly)ESocketStatus e_socketStatus;
/**
 *
 *  超时重连时间，默认1秒
 */
@property (nonatomic,assign)NSTimeInterval overtime;
/**
 *
 *  重连次数,默认5次
 */
@property (nonatomic, assign)NSUInteger reconnectCount;
/**
 *
 *  单例调用
 */
+ (instancetype)shareManager;
/**
 *
 *  开启socket
 *
 *  @param urlStr  服务器地址
 *  @param connect 连接成功回调
 *  @param receive 接收消息回调
 *  @param failure 失败回调
 */
- (void)e_open:(NSString *)urlStr connect:(ESocketDidConnectBlock)connect receive:(ESocketDidReceiveBlock)receive failure:(ESocketDidFailBlock)failure;
/**
 *
 *  关闭socket
 *
 *  @param close 关闭回调
 */
- (void)e_close:(ESocketDidCloseBlock)close;
/**
 *
 *  发送消息，NSString 或者 NSData
 *
 *  @param data Send a UTF8 String or Data.
 */
- (void)e_send:(id)data;

@end
