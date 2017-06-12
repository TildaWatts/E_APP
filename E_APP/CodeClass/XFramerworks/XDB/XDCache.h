//
//  XDCache.h
//  Faith in life
//
//  Created by kingcong on 16/5/19.
//  Copyright © 2016年 allan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDCache : NSObject

+ (XDCache *)shareCache;

@property (nonatomic, copy) NSString *keyName;

@property (nonatomic, copy) NSString *directoryName;

@property (nonatomic, copy) NSString *save_Path;


- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key;

- (id)objectForKey:(NSString *)key;

- (void)removeObjectForKey:(NSString *)key;


- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key path:(NSString *)path;

- (id)objectForKey:(NSString *)key path:(NSString *)path;

- (void)removeObjectForKey:(NSString *)key path:(NSString *)path;



@end
