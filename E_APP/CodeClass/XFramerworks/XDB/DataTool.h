//
//  DataTool.h
//  Faith in life
//
//  Created by kingcong on 16/5/17.
//  Copyright © 2016年 allan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CacheModel.h"

@interface DataTool : NSObject

// 初始化
+ (DataTool *)shareInstance;


#pragma mark + 模型方法存储cache

+ (void)saveCache:(id)object Key:(NSString *)keyName;

+ (CacheModel *)cacheWithKey:(NSString *)keyName;

+ (void)removeCacheWithKey:(NSString *)keyName;



+ (void)cache_saveObject:(id)object WithKeyPath:(NSString *)keyPath keyName:(NSString *)keyName;

+ (CacheModel *)cache_readWithKeyPath:(NSString *)keyPath keyName:(NSString *)keyName;

+ (void)cache_removeWithKeyPath:(NSString *)keyPath keyName:(NSString *)keyName;



/**
 *  移除当前登录用户的缓存数据
 *
 *  @param uid 当前用户的Uid
 */
+ (void)cache_removeWithUid:(NSInteger)uid;

+ (void)cache_saveObjectWithUid:(NSInteger)uid keyName:(NSString *)keyName;

+ (CacheModel *)cache_readWithUid:(NSInteger)uid keyName:(NSString *)keyName;

#pragma mark + 0.默认保存数据

/**
 *  移除所有的缓存数据
 */
+ (void)removeAllObjects;

/**
 *  默认保存方式
 */
+ (void)saveObject:(id)object;

/**
 *  默认读取方式
 *
 *  @return 返回结果
 */
+ (id)read;

/**
 *  删除数据
 */
+ (void)remove;

#pragma mark + 1.Caches保存数据

/**
 *  根据文件名保存数据
 *
 *  @param keyName 文件名
 */
+ (void)saveObject:(id)object WithKey:(NSString *)keyName;

/**
 *  根据路径名读取数据，返回ID类型
 *
 *  @param keyName 文件名
 *
 *  @return 读取的数据，可能为nil
 */
+ (id)readWithKey:(NSString *)keyName;


/**
 *  删除缓存
 *
 *  @param keyName  根据缓存名称
 */
+ (void)removeWithKey:(NSString *)keyName;

/**
 *  根据文件路径存储数据
 *
 *  @param keyPath 文件路径
 */
+ (void)saveObject:(id)object WithKeyPath:(NSString *)keyPath keyName:(NSString *)keyName;

/**
 *  根据文件路径读取数据
 *
 *  @param keyPath 文件路径
 *
 *  @return 读取数据
 */
+ (id)readWithKeyPath:(NSString *)keyPath keyName:(NSString *)keyName;

/**
 *  根据路径名和文件名移除缓存
 *
 *  @param keyPath 根路径
 *  @param keyName 路径名称
 */
+ (void)removeWithKeyPath:(NSString *)keyPath keyName:(NSString *)keyName;


#pragma mark + 2.数据库保存数据
/**
 *  使用数据库保存
 *
 *  @param tableName 表名传入
 */
+ (void)sql_saveObject:(NSArray *)object WithTableName:(NSString *)tableName;

/**
 *  使用数据库保存
 *
 *  @param object    保存数组
 *  @param tableName 表名
 *  @param params    传入参数
 */
+ (void)sql_saveObject:(NSArray *)object WithTableName:(NSString *)tableName params:(NSDictionary *)params;

/**
 *  根据表名读取数据
 *
 *  @param tableName 表名
 *
 *  @return 返回数据数组
 */
+ (NSArray *)sql_readWithTableName:(NSString *)tableName;

/**
 *  使用数据库读取数据
 *
 *  @param tableName 表名
 *  @param size 取出数据的个数
 *  @param startId   开始ID，默认从0开始
 *  @result   返回结果数组
 */
+ (NSArray *)sql_readWithTableName:(NSString *)tableName size:(NSString *)size startId:(NSString *)startId;

#pragma mark + 3.偏好设置保存数据

// XDSetting中已经做了处理


@end
