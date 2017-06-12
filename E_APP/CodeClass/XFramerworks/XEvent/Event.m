//
//  Event.m
//  Faith in life
//
//  Created by alexanxiong on 16/5/12.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#import "Event.h"

@implementation Event


-(id) initWithid:(int) event_id
{
    self = [super init];//调用父类的构造方法
    self.what = event_id;
    return self;
}

@end
