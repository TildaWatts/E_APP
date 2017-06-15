//
//  FirstViewController.m
//  E_APP
//
//  Created by Ezra on 2017/6/12.
//  Copyright © 2017年 Ezra. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"行情";
    
    /**
     *
     *  开启连接
     */
    NSString *url = @"wss://api.chbtc.com:9999/websocket";
    [[ESocketManager shareManager] e_open:url connect:^{
        NSLog(@"成功连接");
    } receive:^(id message, ESocketReceiveType type) {
        if (type == ESocketReceiveTypeForMessage) {
            NSLog(@"接收 类型1--%@",message);
        }
        else if (type == ESocketReceiveTypeForPong){
            NSLog(@"接收 类型2--%@",message);
        }
    } failure:^(NSError *error) {
        NSLog(@"连接失败");
    }];
    
}



- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[ESocketManager shareManager] e_close:^(NSInteger code, NSString *reason, BOOL wasClean) {
        NSLog(@"code = %zd,reason = %@",code,reason);
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"event":@"addChannel",@"channel":@"btc_cny_ticker"} options:NSJSONWritingPrettyPrinted error:nil];
    
    [[ESocketManager shareManager] e_send:jsonData];
}

@end
