//
//  MarketEngine.m
//  E_APP
//
//  Created by Ezra on 2017/6/16.
//  Copyright © 2017年 Ezra. All rights reserved.
//

#import "MarketEngine.h"
#import "MarketItem.h"

@interface MarketEngine()

@end

static  MarketEngine* _instance = nil;

@implementation MarketEngine


+(MarketEngine*) shareInstance
{
    @synchronized (self)
    {
        if( _instance == nil)
        {
            _instance = [[MarketEngine alloc] init] ;
        }
    }
    
    return _instance ;
}

- (instancetype)init
{
    self = [super init];
    return self;
}


-(NSString *) getDataWithKind:(NSString *) kind
{
    NSString *json = [self doRequest:kind];
    
    return json;
}


@end
