//
//  XDCache.m
//  Faith in life
//
//  Created by kingcong on 16/5/19.
//  Copyright © 2016年 allan. All rights reserved.
//

#import "XDCache.h"

@implementation XDCache

static  XDCache* _instance = nil;

+ (XDCache *)shareCache
{
    @synchronized (self)
    {
        if( _instance == nil)
            _instance = [[XDCache alloc] init] ;
    }
    
    return _instance ;
}

- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key
{
    
}

- (id)objectForKey:(NSString *)key
{
    return nil;
}

- (void)removeObjectForKey:(NSString *)key
{
    
}


- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key path:(NSString *)path
{
    NSString *finalPath = [NSString stringWithFormat:@"%@/%@.archive",path,key];
    [NSKeyedArchiver archiveRootObject:object toFile:finalPath];
}

- (id)objectForKey:(NSString *)key path:(NSString *)path
{
    NSString *finalPath = [NSString stringWithFormat:@"%@/%@.archive",path,key];
    id result = [NSKeyedUnarchiver unarchiveObjectWithFile:finalPath];

    return result;
}

- (void)removeObjectForKey:(NSString *)key path:(NSString *)path
{

}


@end
