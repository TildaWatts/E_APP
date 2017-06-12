//
//  CacheModel.h
//  Faith in life
//
//  Created by kingcong on 16/5/18.
//  Copyright © 2016年 allan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheModel : NSObject <NSCoding>

@property (nonatomic, copy) NSString *time;

@property (nonatomic, strong) id data;

- (id)init;

@end
