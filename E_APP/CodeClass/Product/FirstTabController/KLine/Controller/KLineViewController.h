//
//  KLineViewController.h
//  E_APP
//
//  Created by Ezra on 2017/6/21.
//  Copyright © 2017年 Ezra. All rights reserved.
//

#import "SuperViewController.h"
#import "Chart.h"

@interface KLineViewController : SuperViewController

/**
 *  k线图
 */
@property (nonatomic,strong) Chart *candleChart;

@property (nonatomic, strong) NSString *currency;


@end
