//
//  KeyChainStore.h
//  UUID
//
//  Created by kingcong on 16/5/13.
//  Copyright © 2016年 kingcong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainStore : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKeyData:(NSString *)service;

@end
