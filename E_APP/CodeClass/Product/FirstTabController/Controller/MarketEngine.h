//
//  MarketEngine.h
//  E_APP
//
//  Created by Ezra on 2017/6/16.
//  Copyright © 2017年 Ezra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MarketItem.h"
#import "XSocketEngine.h"

@interface MarketEngine : XSocketEngine






+(MarketEngine*) shareInstance ;

@property(nonatomic) MarketItem* marketItem;


-(NSString *) getDataWithKind:(NSString *) kind;

@end
