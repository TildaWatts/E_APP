//
//  KLineItem.h
//  E_APP
//
//  Created by Ezra on 2017/6/21.
//  Copyright © 2017年 Ezra. All rights reserved.
//

#import "XEngine.h"

@interface KLineDataItem : NSObject

@property (nonatomic, assign) long int dataTime;//时间
@property (nonatomic, assign) double openPri;//开盘价
@property (nonatomic, assign) double closePri;//收盘价
@property (nonatomic, assign) double todayMax;//最高价
@property (nonatomic, assign) double todayMin;//最低价
@property (nonatomic, assign) double traNumber;//成交量

@end

@interface KLineItem : XEngine

@property (nonatomic, strong) NSArray<KLineDataItem *> *data;
@property (nonatomic, strong) NSString *moneyType;
@property (nonatomic, strong) NSString *symbol;

@end
