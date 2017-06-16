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
