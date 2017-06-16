//
//  MarketItem.h
//  E_APP
//
//  Created by Ezra on 2017/6/16.
//  Copyright © 2017年 Ezra. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MarketItemInfo : NSObject

@property (nonatomic, strong) NSString *high;
@property (nonatomic, strong) NSString *low;

@property (nonatomic, strong) NSString *buy;
@property (nonatomic, strong) NSString *sell;

@property (nonatomic, strong) NSString *vol;
@property (nonatomic, strong) NSString *last;


@end


@interface MarketItem : NSObject

@property (nonatomic, strong) NSString *channel;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) MarketItemInfo *ticker;

@end
