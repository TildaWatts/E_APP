//
//  ESocketManager.m
//  E_APP
//
//  Created by Ezra on 2017/6/15.
//  Copyright © 2017年 Ezra. All rights reserved.
//

#import "ESocketManager.h"
#import "SRWebSocket.h"

@interface ESocketManager()<SRWebSocketDelegate>

@property (nonatomic,strong)SRWebSocket *webSocket;

@property (nonatomic,assign)ESocketStatus e_socketStatus;

@property (nonatomic,weak)NSTimer *timer;

@property (nonatomic,copy)NSString *urlString;

@end

@implementation ESocketManager

{
    NSInteger _reconnectCounter;
}


+ (instancetype)shareManager{
    static ESocketManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.overtime = 1;
        instance.reconnectCount = 5;
    });
    return instance;
}

- (void)e_open:(NSString *)urlStr connect:(ESocketDidConnectBlock)connect receive:(ESocketDidReceiveBlock)receive failure:(ESocketDidFailBlock)failure{
    [ESocketManager shareManager].connect = connect;
    [ESocketManager shareManager].receive = receive;
    [ESocketManager shareManager].failure = failure;
    [self e_open:urlStr];
}

- (void)e_close:(ESocketDidCloseBlock)close{
    [ESocketManager shareManager].close = close;
    [self e_close];
}

// Send a UTF8 String or Data.
- (void)e_send:(id)data{
    switch ([ESocketManager shareManager].e_socketStatus) {
        case ESocketStatusConnected:
        case ESocketStatusReceived:{
            NSLog(@"发送中。。。");
            [self.webSocket send:data];
            break;
        }
        case ESocketStatusFailed:
            NSLog(@"发送失败");
            break;
        case ESocketStatusClosedByServer:
            NSLog(@"已经关闭");
            break;
        case ESocketStatusClosedByUser:
            NSLog(@"已经关闭");
            break;
    }
    
}

#pragma mark -- private method
- (void)e_open:(id)params{
    //    NSLog(@"params = %@",params);
    NSString *urlStr = nil;
    if ([params isKindOfClass:[NSString class]]) {
        urlStr = (NSString *)params;
    }
    else if([params isKindOfClass:[NSTimer class]]){
        NSTimer *timer = (NSTimer *)params;
        urlStr = [timer userInfo];
    }
    [ESocketManager shareManager].urlString = urlStr;
    [self.webSocket close];
    self.webSocket.delegate = nil;
    
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    self.webSocket.delegate = self;
    
    [self.webSocket open];
}

- (void)e_close{
    
    [self.webSocket close];
    self.webSocket = nil;
    [self.timer invalidate];
    self.timer = nil;
}

- (void)e_reconnect{
    // 计数+1
    if (_reconnectCounter < self.reconnectCount - 1) {
        _reconnectCounter ++;
        // 开启定时器
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.overtime target:self selector:@selector(e_open:) userInfo:self.urlString repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        self.timer = timer;
    }
    else{
        NSLog(@"Websocket Reconnected Outnumber ReconnectCount");
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
        return;
    }
    
}

#pragma mark -- SRWebSocketDelegate
- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    NSLog(@"Websocket Connected");
    
    [ESocketManager shareManager].connect ? [ESocketManager shareManager].connect() : nil;
    [ESocketManager shareManager].e_socketStatus = ESocketStatusConnected;
    // 开启成功后重置重连计数器
    _reconnectCounter = 0;
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@":( Websocket Failed With Error %@", error);
    [ESocketManager shareManager].e_socketStatus = ESocketStatusFailed;
    [ESocketManager shareManager].failure ? [ESocketManager shareManager].failure(error) : nil;
    // 重连
    [self e_reconnect];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    NSLog(@":( Websocket Receive With message %@", message);
    [ESocketManager shareManager].e_socketStatus = ESocketStatusReceived;
    [ESocketManager shareManager].receive ? [ESocketManager shareManager].receive(message,ESocketReceiveTypeForMessage) : nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    NSLog(@"Closed Reason:%@  code = %zd",reason,code);
    if (reason) {
        [ESocketManager shareManager].e_socketStatus = ESocketStatusClosedByServer;
        // 重连
        [self e_reconnect];
    }
    else{
        [ESocketManager shareManager].e_socketStatus = ESocketStatusClosedByUser;
    }
    [ESocketManager shareManager].close ? [ESocketManager shareManager].close(code,reason,wasClean) : nil;
    self.webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
    [ESocketManager shareManager].receive ? [ESocketManager shareManager].receive(pongPayload,ESocketReceiveTypeForPong) : nil;
}

- (void)dealloc{
    // Close WebSocket
    [self e_close];
}


@end
