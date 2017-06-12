
//
//  CacheModel.m
//  Faith in life
//
//  Created by kingcong on 16/5/18.
//  Copyright © 2016年 allan. All rights reserved.
//

#import "CacheModel.h"

@implementation CacheModel

- (id)init
{
    if (self = [super init]) {
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
        
        [dateFormatter setDateStyle:NSDateFormatterFullStyle];
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSString *fixString = [dateFormatter stringFromDate:[NSDate date]];
        self.time = fixString;
    }
    return self;
}

MJCodingImplementation

@end
