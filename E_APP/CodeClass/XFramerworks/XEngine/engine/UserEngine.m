//
//  UserEngine.m
//  Faith in life
//
//  Created by kingcong on 16/5/16.
//  Copyright © 2016年 allan. All rights reserved.
//

#import "UserEngine.h"
#import "DataCenter.h"
#import "ErrorCode.h"
//#import "LoginEngine.h"
//#import "USStarViewController.h"
//#import "CityCard.h"
//#import "MessageEngine.h"
#import "AppDelegate.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFURLRequestSerialization.h>
//意见反馈
#define CDM_OPINION_CALLBACK @"tools.suggestion"

//修改用户昵称
#define CDM_ALTER_NICK       @"user.modifyNick"
//修改头像
#define CMD_ALTER_PHOTO      @"user.modifyPhoto"
#define CMD_CHECK_IDNUM      @"user.checkIdnoLastsix"      //检查身份证号后六位

#define CMD_SET_PAY_PASSWORD @"user.setPaypass"            //设置支付密码
#define CMD_MODIFY_PAY_PASS  @"user.modifyPaypass"         //修改支付密码
#define CMD_RESET_PAY_PASS   @"user.resetPaypass"          //重置支付密码
#define CMD_CHECK_PAY_PASS   @"user.checkPaypass"          //检查支付密码

#define CMD_USERMODEL_INFO2 @"user.info"

#define CMD_TEMP_SESSIONKEY @"user.getImgSession"   //获取临时Sessionkey


/**
 *  2.2.2风控检日志
 */
#define CMD_TRACE_LOG @"tools.trace" //风控日志


//上传用户经纬度
#define CMD_UPLOAD_USER_ADRESS @"credit.userposition"


@implementation UserEngine

static  UserEngine* _instance = nil;

+(UserEngine*) shareInstance
{
    @synchronized (self)
    {
        if( _instance == nil)
            _instance = [[UserEngine alloc] init] ;
    }
    
    return _instance ;
}
- (void)testinterface:(NSString *)word
{
    XRequest* request = [[XRequest alloc] initWithCmd:CMD_ALTER_PHOTO];
}

//修改头像
-(void) modifyPhoto:(NSString *)photo;
{
    XRequest* request = [[XRequest alloc] initWithCmd:CMD_ALTER_PHOTO];
    [request addData:@"photo" value:photo];
    [request setMode:CACHE_MODE_OFF];
    [self doRequest:request];
    
}



#pragma mark - 高能标记
//风控日志
- (void)traceLog:(NSMutableDictionary *)params
{
    XRequest* request = [[XRequest alloc] initWithCmd:CMD_TRACE_LOG data:params];
    [self doRequest:request];
}


- (void)traceLogp1:(NSString *)p1 p2:(NSString *)p2 p3:(NSString *)p3 process:(NSString *)process
{
    [self traceLogp1:p1 p2:p2 p3:p3 process:process result:nil reaseon:nil];
}

- (void)traceLogp1:(NSString *)p1 p2:(NSString *)p2 p3:(NSString *)p3 process:(NSString *)process  result:(NSString*) result reaseon:(NSString*) reason
{
    XRequest *request = [[XRequest alloc]initWithCmd:CMD_TRACE_LOG ];
    //2.2.2风控日志
    [request addData:@"p1" value:p1];
    [request addData:@"p2" value:p2];
    [request addData:@"p3" value:p3];
    [request addData:@"process" value:process];
    
    if( result)
        [request addData:@"result" value:result];
    if( reason)
        [request addData:@"reason" value:reason];
    [self doRequest:request];
}

- (void)ss:(NSString *)ss
{
    XRequest *request = [[XRequest alloc]initWithCmd:@"aa12c29240ec1a11"];
    [request addData:@"word" value:@"你"];
//    [request addData:@"appkey" value:@"aa12c29240ec1a11"];
    [self doRequest:request];
    
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/html",@"text/json", nil];
////    NSString *sss = @"appkey=aa12c29240ec1a11&word=你";
//    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
//    dictM[@"appkey"] = @"aa12c29240ec1a11";
//    dictM[@"word"] = @"你";
//    [manager POST:Usuite parameters:dictM progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%s %d",__func__, __LINE__);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%s %d",__func__, __LINE__);
//    }];
    
    
}

//上传用户经纬度
-(void)userAdresssLnt:(NSString *)lnt lat:(NSString *)lat{
    XRequest* request = [[XRequest alloc] initWithCmd:CMD_UPLOAD_USER_ADRESS];
    [request addData:@"lnt" value:lnt];
    [request addData:@"lat" value:lat];
    [self doRequest:request];
}



-(void) onSuccess:(XRequest*) request response:(XResponse*) response
{
//    XDLog(@"UserEngine onSuccess request:%@=response:%@",request,response);
    if( request == nil  || request.cmd == nil)
        return ;
    if( response.errorCode != OKAY)
    {
        [self onFail:request response:response];
        return ;
    }
    
    if ([request.cmd isEqualToString:CDM_OPINION_CALLBACK])
    {
        [EventCenter Event_PostData: MSG_OPINION_CALLBACK_SUCCESS obj:nil];
        
    }
    else if ([request.cmd isEqualToString:CDM_ALTER_NICK])
    {
        [EventCenter Event_PostData: MSG_ALTER_NICK_SUCCESS obj:nil];
    }
    else if ([request.cmd isEqualToString:CMD_ALTER_PHOTO])
    {
        [EventCenter Event_PostData: MSG_ALTER_PHOTO_SUCCESS obj:nil];
    }
    else if([request.cmd isEqualToString:CMD_TEMP_SESSIONKEY]) {
        [EventCenter Event_PostData:MSG_TEMPSESSIONKEY_SUCCESS obj:response.s_ret];
    }
    

    
    else if ([request.cmd isEqualToString:CMD_TRACE_LOG])
    {
        [EventCenter Event_PostData:MSG_TRACELOG_SUCCESS obj:response];
    }
    else if([request.cmd isEqualToString:CMD_UPLOAD_USER_ADRESS]) {
        [EventCenter Event_PostData:MSG_UPLOAD_USER_ADRESS_SUCCESS obj:response];
    }

    else if ([request.cmd isEqualToString:CMD_CHECK_IDNUM])
    {
    }
    else if ([request.cmd isEqualToString:CMD_SET_PAY_PASSWORD])
    {
        [EventCenter Event_PostData: MSG_SET_PAY_PASSWORD_SUCC obj:response];
    }
    else if ([request.cmd isEqualToString:CMD_MODIFY_PAY_PASS])
    {
        [EventCenter Event_PostData: MSG_AMEND_PAY_PASSWARD_SUCCESS obj:response];
    }
    else if ([request.cmd isEqualToString:CMD_RESET_PAY_PASS])
    {
        [EventCenter Event_PostData: MSG_RESET_PAY_PASSWARD_SUCCESS obj:response];
    }
    else if ([request.cmd isEqualToString:CMD_CHECK_PAY_PASS])
    {
        [EventCenter Event_PostData: MSG_CHECK_PAY_PASSWARD_SUCCESS obj:response];
    }
    
    
    

}


-(void) onFail:(XRequest*) request   response:(XResponse*) response
{
//    XDLog(@"UserEngine onFail request:%@=response=%@ errorCode=:%d",request,response,response.errorCode);
    if( request == nil || request.cmd == nil)
        return ;
    
    // 登录失败
    
    // 请求失败类型
    if( [request.cmd isEqualToString: CMD_USERMODEL_INFO2])
    {
        [EventCenter Event_PostData: MSG_USERINFO2_FAILURE obj:nil];
    }
    else if( [request.cmd isEqualToString:CDM_OPINION_CALLBACK])
    {
        [EventCenter Event_PostData: MSG_OPINION_CALLBACK_FAILURE obj:nil];
    }
    else if ([request.cmd isEqualToString:CDM_ALTER_NICK])
    {
        [EventCenter Event_PostData: MSG_ALTER_NICK_FAILURE obj:nil];
    }
    else if ([request.cmd isEqualToString:CMD_ALTER_PHOTO])
    {
        [EventCenter Event_PostData: MSG_ALTER_PHOTO_FAILURE obj:nil];
        
    } else  if([request.cmd isEqualToString:CMD_TEMP_SESSIONKEY]) {
        
        [EventCenter Event_PostData: MSG_TEMPSESSIONKEY_FAILURE obj:response];
        
    } else if([request.cmd isEqualToString:CMD_USERMODEL_INFO2])
    {
        [EventCenter Event_PostData: MSG_USERINFO2_FAILURE obj:response];
    }
   
    else if ([request.cmd isEqualToString:CMD_CHECK_IDNUM])
    {
//        [EventCenter Event_PostData: MSG_CHECK_IDNUM_PASSWORD_FAIL obj:response];
    }
    else if ([request.cmd isEqualToString:CMD_TRACE_LOG])
    {
        [EventCenter Event_PostData:MSG_TRACELOG_FAILURE obj:response];
    }
    else if([request.cmd isEqualToString:CMD_UPLOAD_USER_ADRESS])
    {
        [EventCenter Event_PostData:MSG_UPLOAD_USER_ADRESS_FAILURE obj:response];
    }
    else if ([request.cmd isEqualToString:CMD_SET_PAY_PASSWORD])
    {
        [EventCenter Event_PostData: MSG_SET_PAY_PASSWORD_FAIL obj:response];
    }
    else if ([request.cmd isEqualToString:CMD_MODIFY_PAY_PASS])
    {
        [EventCenter Event_PostData: MSG_AMEND_PAY_PASSWARD_FAILURE  obj:response];
    }
    else if ([request.cmd isEqualToString:CMD_RESET_PAY_PASS])
    {
        [EventCenter Event_PostData: MSG_RESET_PAY_PASSWARD_FAILURE obj:response];
    }
    else if ([request.cmd isEqualToString:CMD_CHECK_PAY_PASS])
    {
        [EventCenter Event_PostData: MSG_CHECK_PAY_PASSWARD_FAILURE obj:response];
    }
    
}

@end
