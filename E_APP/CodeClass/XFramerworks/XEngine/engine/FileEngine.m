//
//  FileEngine.m
//  U_APP
//
//  Created by alexanxiong on 2016/12/2.
//  Copyright © 2016年 Ezra. All rights reserved.
//

#import "FileEngine.h"
#import "CommonUtils.h"

@implementation FileEngine

//上传图片Engine
+(int) uploadImg:(id) img
{
    int seq_id = [CommonUtils getUniqueID];
    XResponse* response  = [[XResponse alloc] init] ;
    response.reqNO  = seq_id;
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr POST:Upload parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *data = UIImageJPEGRepresentation(img,0.8);
        [formData appendPartWithFileData:data name:@"file" fileName:@"upload.jpg" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        [response loadData:responseObject];
        [EventCenter Event_PostData: MSG_FILE_UPLOAD_SUCCESS obj:response];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        response.errorCode =  ERROR_AFN_ERROR;
        [EventCenter Event_PostData: MSG_FILE_UPLOAD_FAIL obj:response];
    }];
    
    return seq_id;
}


//获取安全目录中的图片Engine
+ (void)getDataWithParams:(NSString *)fileId sessionKey:(NSString *)sessionKey success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"fid"] = fileId;
    params[@"uid"] = @([DataCenter shareInstance].uid);
    params[@"sessionkey"] = sessionKey;
    
    [mgr POST:GetUploadImage parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@", responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure(error);
    }];
}

@end
