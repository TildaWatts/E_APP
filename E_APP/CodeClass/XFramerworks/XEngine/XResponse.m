//
//  XResponse.m
//  Faith in life
//
//  Created by alexanxiong on 16/5/12.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#import "XResponse.h"
#import "Global.h"
#import "ErrorCode.h"
#import "Protocol.h"
#import "CommonUtils.h"
#import "DataCenter.h"
#import "FileManagerUtils.h"
#import "DataTool.h"
#import "CacheModel.h"

@implementation XResponse

-(id) init
{
    self = [super init];
    self.errorCode =  ERROR_INVALID_JSON;
    return self;
}


-(void) loadData :(nullable id) obj
{
    if( obj == nil )
    {
        self.errorCode =  ERROR_HTTP_NULL;
        return ;
    }
    
    
    if( [obj isKindOfClass:[NSDictionary class]] )
    {
        [self loadDic:obj fromCache:NO];
    }
    else
        self.errorCode =  ERROR_INVALID_JSON;
}

/**
 * 加载json数据
 */
-(void) loadDic :(nullable NSDictionary*) dic fromCache:(BOOL) bFromCache;{
    if( dic == nil)
        return ;
    
    // 存储原生数据
    self.raw_Json = dic;
    
    self.isCache = bFromCache;
    self.cmd = [CommonUtils getString:dic key:XD_PROTOCOL_R_CMD];
    
    // 网络数据才加载header。缓存数据忽略header
    if( !bFromCache )
    {
        self.header = [CommonUtils getDic:dic key:XD_PROTOCOL_R_HEADER];
        self.errorCode = [CommonUtils getInt:dic key:XD_PROTOCOL_S_CODE];
        self.bizCode = [CommonUtils getInt:dic key:XD_PROTOCOL_S_BIZCODE];
    }
    else
    {
        self.header  = nil;
        self.errorCode = OKAY;
        self.bizCode   = OKAY;
    }
   

    self.i_ret = [CommonUtils getInt:dic key:XD_PROTOCOL_S_I_RET];
    self.s_ret = [CommonUtils getString:dic key:XD_PROTOCOL_S_S_RET];
    self.message=[CommonUtils getString:dic key:XD_PROTOCOL_MESSAGE];

    if ([dic[XD_PROTOCOL_S_O_RET] isKindOfClass:[NSDictionary class]]) {
        self.o_ret = [CommonUtils getDic:dic key:XD_PROTOCOL_S_O_RET];
    } else if ([dic[XD_PROTOCOL_S_O_RET] isKindOfClass:[NSArray class]]) {
        self.o_ret = [CommonUtils getArray:dic key:XD_PROTOCOL_S_O_RET];
    }
    
    if( self.errorCode == OKAY && self.bizCode != OKAY)
    {
        self.errorCode = self.bizCode;
    }
    
    XLog(@"%@ ",self);
}


/**
 * 加载缓存数据
 */
-(id) loadFromCache
{
    NSDictionary *content = [self loadCache];
    if( content == nil)
        return nil;
    [self loadDic:content fromCache:YES];
    return self;
}

// 从数据库中加载缓存
- (nullable id)loadFromSql_cache
{
    return nil;
}

- (void)saveSql_cache
{

}

-(void) saveCache:(int) uid
{
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    data[XD_PROTOCOL_R_CMD]  = self.cmd;
    data[XD_PROTOCOL_S_I_RET]  = [NSNumber   numberWithInt:self.i_ret];
    data[XD_PROTOCOL_S_S_RET]  = self.s_ret;
    data[XD_PROTOCOL_S_O_RET]  = self.o_ret;
    
    if (self.local_ext == nil) {
        self.local_ext = @"";
    }
    
    NSString* cacheName = [NSString stringWithFormat:@"%@_%d_%@",self.cmd,self.local_id,self.local_ext];
    NSString *uidStr = [NSString stringWithFormat:@"%zd",uid];
    
    NSString *rootPath = [FileManagerUtils createFileDirectory:uidStr];
    
    [DataTool cache_saveObject:data WithKeyPath:rootPath keyName:cacheName];
}

-(void) saveAppCache
{
    [self saveCache:0];
}


-(void) saveCache
{
    [self saveCache:[DataCenter shareInstance].uid];
}

-(NSDictionary *)loadCache
{
    if (self.local_ext == nil) {
        self.local_ext = @"";
    }
    
    NSString* cacheName = [NSString stringWithFormat:@"%@_%d_%@",self.cmd,self.local_id,self.local_ext];
    
    NSString *uidStr = [NSString stringWithFormat:@"%zd",[DataCenter shareInstance].uid];
    NSString *rootPath = [FileManagerUtils createFileDirectory:uidStr];
    
    CacheModel *cacheModel = [DataTool cache_readWithKeyPath:rootPath keyName:cacheName];
    
    // 从缓存中读取数据
    return cacheModel.data;
}

@end


/**
 XData
 */
@implementation XData

-(id) initWithXResponse:(XResponse*) res
{
    self = [super init];
    return self;
}

@end

/**
 XItem
 */
@implementation XItem

- (id)initWithDict:(NSDictionary *)res
{
    return self;
}
@end
