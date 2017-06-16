//
//  XSocketEngine.m
//  E_APP
//
//  Created by Ezra on 2017/6/16.
//  Copyright © 2017年 Ezra. All rights reserved.
//

#import "XSocketEngine.h"

@implementation XSocketEngine


-(NSString *) doRequest:(NSString *)  request
{
    [self createConnect:request];
    
    return self.isConnect?self.message:@"nil";
}


- (NSString *)createConnect:(NSString *)  parame
{
    /**
     *
     *  开启连接
     */
    WS(weakSelf)
    [[ESocketManager shareManager] e_open:SocketUsuites connect:^{
        NSLog(@"成功连接");
        weakSelf.isConnect = YES;
        [weakSelf sendParame:parame];
    } receive:^(id message, ESocketReceiveType type) {
        if (type == ESocketReceiveTypeForMessage) {
            NSLog(@"接收 类型1--%@",message);
            weakSelf.message = (NSString *)message;
        }
        else if (type == ESocketReceiveTypeForPong){
            NSLog(@"接收 类型2--%@",message);
            weakSelf.message = (NSString *)message;
        }
    } failure:^(NSError *error) {
        NSLog(@"连接失败");
        weakSelf.message = @"连接失败";
    }];
    
    return weakSelf.message;
}


- (void)sendParame:(NSString *)parame
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"event":@"addChannel",@"channel":parame} options:NSJSONWritingPrettyPrinted error:nil];
    [[ESocketManager shareManager] e_send:jsonData];
}


@end
