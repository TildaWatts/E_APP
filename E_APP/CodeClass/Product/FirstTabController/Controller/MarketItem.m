//
//  MarketItem.m
//  E_APP
//
//  Created by Ezra on 2017/6/16.
//  Copyright © 2017年 Ezra. All rights reserved.
//

#import "MarketItem.h"

@implementation MarketItemInfo


@end

@implementation MarketItem


+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"ticker":[MarketItemInfo class]};
    
}

-(void)setChannel:(NSString *)channel
{
    if ([channel isEqualToString:@"btc_cny_ticker"]) {
        _channel = @"BTC";
    }
    if ([channel isEqualToString:@"ltc_cny_ticker"]) {
        _channel = @"LTC";
    }
    if ([channel isEqualToString:@"eth_cny_ticker"]) {
        _channel = @"以太币";
    }
    if ([channel isEqualToString:@"etc_cny_ticker"]) {
        _channel = @"ETC";
    }
    if ([channel isEqualToString:@"bts_cny_ticker"]) {
        _channel = @"BTS";
    }
    
}

@end
@implementation MarketItemArr
//
//-(void)setMarketArr:(NSArray<MarketItem *> *)marketArr
//{
//    if (marketArr.count) {
//        NSMutableArray<MarketItem *> *tempArrM = [NSMutableArray array];
//        for (int i = 0; i < marketArr.count; i++) {
//            if ([marketArr[i].channel isEqualToString:@"BTC"]) {
//                [tempArrM addObject:marketArr[i]];
//            }
//            if ([marketArr[i].channel isEqualToString:@"LTC"]) {
//                [tempArrM addObject:marketArr[i]];
//            }
//            if ([marketArr[i].channel isEqualToString:@"ETC"]) {
//                [tempArrM addObject:marketArr[i]];
//            }
//            if ([marketArr[i].channel isEqualToString:@"BTS"]) {
//                [tempArrM addObject:marketArr[i]];
//            }
//        }
//        _marketArr = tempArrM;
//    }
//}

@end
