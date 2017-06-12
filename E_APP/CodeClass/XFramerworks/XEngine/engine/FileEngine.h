//
//  FileEngine.h
//  U_APP
//
//  Created by alexanxiong on 2016/12/2.
//  Copyright © 2016年 Ezra. All rights reserved.
//

#ifndef FileEngine_h
#define FileEngine_h

@interface FileEngine : NSObject

/**
 *  上传文件。返回值请通过 EventListener 监听  
 *  #define MSG_FILE_UPLOAD_SUCCESS       100
 *  #define MSG_FILE_UPLOAD_FAIL          101
 *  返回OBJ 为XResponse  ,
 *  更多请看实现
 *  返回  XResponse.reqNO
 **/
+(int) uploadImg:(id) data;



/**
 *  获取安全目录中的图片
 *
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */

/*
+ (void)getDataWithParams:(NSString *)fileId sessionKey:(NSString *)sessionKey success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure;
 */

@end

#endif /* FileEngine_h */
