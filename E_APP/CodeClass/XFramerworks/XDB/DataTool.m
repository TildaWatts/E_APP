//
//  DataTool.m
//  Faith in life
//
//  Created by kingcong on 16/5/17.
//  Copyright © 2016年 allan. All rights reserved.
//

#import "DataTool.h"
#import "FileManagerUtils.h"
#import "XDCache.h"

#define kDefaultName @"defaultName"

@implementation DataTool



+(FMDatabaseQueue *)getSharedInstance
{
    static FMDatabaseQueue *my_FMDatabaseQueue=nil;
    
    if (!my_FMDatabaseQueue) {
        
        my_FMDatabaseQueue = [FMDatabaseQueue databaseQueueWithPath:@""];
    }
    NSLog(@"++++++++++++++++++++++++++++++++++++++:%@",my_FMDatabaseQueue);
    return my_FMDatabaseQueue;
}

// 数据库实例
//static FMDatabase * _db;
static FMDatabaseQueue * _dbQueue;

+ (void)initialize
{
    NSInteger uid = [DataCenter shareInstance].uid;
    // 1.打开数据库
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingFormat:@"/%zd/status.sqlite",uid];
    
    NSLog(@"数据库路径%@",path);
    
    // 创建文件路径
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        NSString *directoryPath = [documentPath stringByAppendingFormat:@"/%zd",uid];
        [fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    _dbQueue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    // 3.打开数据库
}


+ (void)openSql_TableWithName:(NSString *)tableName
{
    // 4.创表
    
    NSString *sql = [NSString stringWithFormat:@"create table if not exists '%@' (id integer primary key autoincrement,type text,time text not null,data blob not null,isRead integer,ext text ext2 text);",tableName];

    [_dbQueue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:sql];
        if (result) {
            NSLog(@"创表成功");
        }else{
            NSLog(@"创表失败");
        }
    }];

}


// 初始化
static  DataTool* _instance = nil;

+ (DataTool *)shareInstance
{
    @synchronized (self)
    {
        if( _instance == nil)
            _instance = [[DataTool alloc] init] ;
    }
    
    return _instance ;
}


#pragma mark + 模型缓存方式
+ (void)saveCache:(id)object Key:(NSString *)keyName
{
    CacheModel *cacheModel = [[CacheModel alloc] init];
    cacheModel.data = object;
    [[TMCache sharedCache] setObject:cacheModel forKey:kDefaultName];

}

+ (CacheModel *)cacheWithKey:(NSString *)keyName
{
    CacheModel *cacheModel = [[TMCache sharedCache] objectForKey:keyName];
    
    return cacheModel;
}

+ (void)removeCacheWithKey:(NSString *)keyName
{
    [[TMCache sharedCache] removeObjectForKey:keyName];
}


+ (void)cache_saveObject:(id)object WithKeyPath:(NSString *)keyPath keyName:(NSString *)keyName
{
    CacheModel *cacheModel = [[CacheModel alloc] init];
    cacheModel.data = object;
    
    [[XDCache shareCache] setObject:cacheModel forKey:keyName path:keyPath];

}

+ (CacheModel *)cache_readWithKeyPath:(NSString *)keyPath keyName:(NSString *)keyName
{
    CacheModel *result = [[XDCache shareCache] objectForKey:keyName path:keyPath];
    
    return result;
}

+ (void)cache_removeWithKeyPath:(NSString *)keyPath keyName:(NSString *)keyName
{
    TMCache *cache = [[TMCache alloc] initWithName:keyName rootPath:keyPath];
    [cache removeObjectForKey:kDefaultName];
    
    [cache removeAllObjects];
}

+ (void)cache_removeWithUid:(NSInteger)uid
{
    NSString *uidStr = [NSString stringWithFormat:@"%zd",[DataCenter shareInstance].uid];
    
    NSString *rootPath = [FileManagerUtils createFileDirectory:uidStr];
    
    [FileManagerUtils removeFileDirectoryOfFile:rootPath];
}

+ (void)cache_saveObjectWithUid:(NSInteger)uid keyName:(NSString *)keyName
{

}

+ (CacheModel *)cache_readWithUid:(NSInteger)uid keyName:(NSString *)keyName
{
    return nil;
}


#pragma mark + 0.默认保存数据

/**
 *  移除所有的缓存数据
 */
+ (void)removeAllObjects
{
    [[TMCache sharedCache] removeAllObjects];
}


/**
 *  默认保存方式
 */
+ (void)saveObject:(id)object
{
    [[TMCache sharedCache] setObject:object forKey:kDefaultName];
}

/**
 *  默认读取方式
 *
 *  @return 返回结果
 */
+ (id)read
{
    id result = [[TMCache sharedCache] objectForKey:kDefaultName];
    return result;
}

/**
 *  删除数据
 */
+ (void)remove
{
    [[TMCache sharedCache] removeObjectForKey:kDefaultName];
}


#pragma mark + 1.Caches保存数据

/**
 *  根据文件名保存数据
 *
 *  @param keyName 文件名
 */
+ (void)saveObject:(id)object WithKey:(NSString *)keyName
{
    [[TMCache sharedCache] setObject:object forKey:keyName];
}

/**
 *  根据路径名读取数据，返回ID类型
 *
 *  @param keyName 文件名
 *
 *  @return 读取的数据，可能为nil
 */
+ (id)readWithKey:(NSString *)keyName
{
    id result = [[TMCache sharedCache] objectForKey:keyName];
    return result;
}

/**
 *  删除缓存
 *
 *  @param keyName  根据缓存名称
 */
+ (void)removeWithKey:(NSString *)keyName
{
    [[TMCache sharedCache] removeObjectForKey:keyName];
}

/**
 *  根据文件路径存储数据
 *
 *  @param keyPath 文件路径
 */
+ (void)saveObject:(id)object WithKeyPath:(NSString *)keyPath keyName:(NSString *)keyName
{
    TMCache *cache = [[TMCache alloc] initWithName:keyName rootPath:keyPath];
    [cache setObject:object forKey:keyName];
}

/**
 *  根据文件路径读取数据
 *
 *  @param keyPath 文件路径
 *
 *  @return 读取数据
 */
+ (id)readWithKeyPath:(NSString *)keyPath keyName:(NSString *)keyName
{
    TMCache *cache = [[TMCache alloc] initWithName:keyName rootPath:keyPath];
    
    id data = [cache objectForKey:keyName];
    return data;
}


/**
 *  根据路径名和文件名移除缓存
 *
 *  @param keyPath 根路径
 *  @param keyName 路径名称
 */
+ (void)removeWithKeyPath:(NSString *)keyPath keyName:(NSString *)keyName
{
    TMCache *cache = [[TMCache alloc] initWithName:keyName rootPath:keyPath];
    [cache removeObjectForKey:keyName];
}

#pragma mark + 2.数据库保存数据
/**
 *  使用数据库保存
 *
 *  @param tableName 表名传入
 */
+ (void)sql_saveObject:(NSArray *)object WithTableName:(NSString *)tableName
{
    [self handleSql_cache:tableName object:object params:@{@"type":@0,@"isRead":@0,@"ext":@"default",@"ext2":@"default"}];
}

+ (void)sql_saveObject:(NSArray *)object WithTableName:(NSString *)tableName params:(NSDictionary *)params
{
    [self handleSql_cache:tableName object:object params:params];
}

+ (void)handleSql_cache:(NSString *)tableName object:(NSArray *)objectArray params:(NSDictionary *)params
{
    // 打开数据库
    [self openSql_TableWithName:tableName];
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    [dateFormatter setDateFormat:@"yyyy+MM+dd HH:mm:ss"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    // 取出参数
    NSNumber *isRead = params[@"isRead"];
    NSString *ext = params[@"ext"];
    NSString *ext2 = params[@"ext"];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        for (NSDictionary *status in objectArray) {
            // NSDictionary ++> NSData
            NSData *statusData = [NSKeyedArchiver archivedDataWithRootObject:status];
            
            NSString *sql = [NSString stringWithFormat:@"insert into %@(data,time,isRead,ext,ext2) values (?,?,?,?,?)",tableName];
            NSArray *array = @[statusData,destDateString,isRead,ext,ext2];
            if ([db executeUpdate:sql withArgumentsInArray:array]) {
                NSLog(@"success执行sql语句%@",sql);
            } else {
                NSLog(@"error执行sql语句%@",sql);
            }
        }
        
        // 返回结果
    }];

}


/**
 *  根据表名读取数据
 *
 *  @param tableName 表名
 *
 *  @return 返回数据数组
 */
+ (NSArray *)sql_readWithTableName:(NSString *)tableName
{
    return [self handleSql_readWithTableName:tableName size:nil startId:nil];
}

/**
 *  使用数据库读取数据
 *
 *  @param tableName 表名
 *  @param size 取出数据的个数
 *  @param startId   开始ID，默认从0开始
 *  @result   返回结果数组
 */
+ (NSArray *)sql_readWithTableName:(NSString *)tableName size:(NSString *)size startId:(NSString *)startId
{
    return [self handleSql_readWithTableName:tableName size:size startId:startId];
}

+ (NSArray *)handleSql_readWithTableName:(NSString *)tableName size:(NSString *)size startId:(NSString *)startId
{
    [self openSql_TableWithName:tableName];
    
    NSMutableArray *statuses = [NSMutableArray array];
    // 频繁的查询操作放到其他线程中去
    //    NSThread *thread = [NSThread currentThread];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY id;",tableName];
        
        // 执行SQL
        FMResultSet *set = [db executeQuery:sql];
        
        while (set.next) {
            
            // 这个只能卸载里面，写在外面会出问题
            NSMutableDictionary *statusDict = [NSMutableDictionary dictionary];
            
            // 取出存储的字符串数据
            NSData *statusData = [set objectForColumnName:@"data"];
            NSString *result  =[[ NSString alloc] initWithData:statusData encoding:NSUTF8StringEncoding];
            NSString *time = [set objectForColumnName:@"time"];
            
            // 取出存储的类型数据
            NSString *type = [set objectForColumnName:@"type"];
            
            statusDict[@"result"] = result;
            statusDict[@"type"] = type;
            statusDict[@"time"] = time;
            
            [statuses addObject:statusDict];
        }
        
        NSLog(@"%@",statuses);
        
    }];
    
    return statuses;
}

#pragma mark + 3.偏好设置保存数据

// XDSetting中已经做了处理

//+ (void)prefrence_saveWithKey:(NSString *)name;

@end
