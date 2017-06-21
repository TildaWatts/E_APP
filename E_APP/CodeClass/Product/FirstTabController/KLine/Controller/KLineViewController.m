//
//  KLineViewController.m
//  E_APP
//
//  Created by Ezra on 2017/6/21.
//  Copyright © 2017年 Ezra. All rights reserved.
//

#import "KLineViewController.h"
#import "KLineEngine.h"

@interface KLineViewController ()

@end

@implementation KLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    double now = [[NSDate date] timeIntervalSince1970];
    [[KLineEngine shareInstance]kLineWithCurrency:@"btc_cny" type:@"1day" since:nil size:nil];

}

@end
