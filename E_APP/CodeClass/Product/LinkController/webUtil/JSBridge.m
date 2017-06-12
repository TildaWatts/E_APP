//
//  JSBridge.m
//  Faith in life
//
//  Created by alexanxiong on 16/9/22.
//  Copyright © 2016年 Xinnuo. All rights reserved.
//

#import "JSBridge.h"
#import "CURLInput.h"
#import "CURLEngine.h"
#import "JSUtil.h"
#import "WKWebViewController.h"
#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"

#define CUSTOM_SEQID  @"1"

/**
 *  JSB网络请求返回错误码列表
 */
#define RET_OKAY  0     // 成功
#define RET_FAIL  -1  // 失败
#define RET_None  -2    // 代码不全
#define RET_Exception  -3 // Native异常
#define RET_IllegalArgument  -4  // 接口参数不正确
#define RET_AUTHORIZE_FAIL  -5   // 未登陆或者认证不通过
#define RET_SERVER_BUSY  -6       // 预留。服务器忙
#define RET_Busy  -100       // 预留。接口调用太频繁
#define RET_SUPPORT  -7      // 接口不支持。

//特定回调
#define  FUNC_READY_CALLBACK @"readyCallback"

//自定义函数
#define kJsbSetWebView   @"setWebView"    // setWebView方法
#define kJsbReport       @"report"    // report方法
#define kJsbCloseWebView       @"closeWebView"    // 关闭webView
#define kJsbCurl         @"curl"                  //启动客户端拉取数据

//参数定义
#define kJsbSetPropertyTitle @"title"
#define kJsbSetPropertyTitleColor @"titleColor"
#define kJsbSetPropertyToolBar @"toolbar"
#define kJsbSetPropertyTitlebar @"titlebar"

#define kJsbReportPropertyActionID @"action_id"
#define kJsbReportPropertyActionValue @"action_value"

#define kJsbJumpPhone @"call"
#define kJsbJumpSMS @"sms"



@interface JSBridge()
{
}
@end

@implementation JSBridge

-(void)handlerEvent:(NSNotification *)  event
{
    if( event.object != nil)
    {
        Event* evt = (Event*)event.object;
        XResponse *response = (XResponse *)evt.obj;
        
        NSLog(@"=====%d%@..%@",evt.what,evt.data,response);
        switch (evt.what)
        {
                
        }
    }
}

-(void) attach:(UIWebView*)  web wk:(WKWebView*) wk view: (SuperViewController *)  view
{
    self.web  = web;
    self.wk   = wk;
    self.view = view;

    // add event listener if you wish!
}

-(void) deattach
{
    if(self.view != nil)
    [EventCenter Event_Remove:self];

    self.wk = nil;
    self.web= nil;
    self.view=nil;
    
}

-(void) onReady
{
    NSString *callBackStr = [JSUtil formatXJS:FUNC_READY_CALLBACK seqid:CUSTOM_SEQID method:nil s_ret:RET_OKAY];
    [self excuteJS:callBackStr];
}

-(int) handlerJSB:(XUri*) uri
{
    int iret = RET_SUPPORT;
    
    XLog(@"==%@",uri.host);
    if( uri.host == nil)
    {
        return iret;
    }
    
    NSString* seqid  =  nil;
    NSString* callback = nil;
    if( uri.paths != nil)
    {
        if( uri.paths.count >0)
            seqid = uri.paths[0];
        if( uri.paths.count > 1)
            callback = uri.paths[1];
    }
    
    
    if( [uri.host isEqualToString:kJsbReport])
    {
        iret = [self report:uri seqid:seqid callback:callback];
    }
    else if( [uri.host isEqualToString:kJsbSetWebView] )
    {
        iret = [self setWebView:uri seqid:seqid callback:callback];
    }
    else if( [uri.host isEqualToString:kJsbCloseWebView])
    {
        iret = [self closeWebView:uri seqid:seqid callback:callback];
    }
    else if( [uri.host isEqualToString:kJsbCurl])
    {
        iret = [self curl:uri seqid:seqid callback:callback];
    }
    else if ([uri.host isEqualToString:kJsbJumpPhone])
    {
        iret = [self callPhone:uri seqid:seqid callback:callback];
    }
    else if ([uri.host isEqualToString:kJsbJumpSMS])
    {
        iret = [self smsPhone:uri seqid:seqid callback:callback];
    }
    
    if(  callback != nil)
    {
        NSString *callBackStr = [JSUtil formatXJS:callback seqid:seqid method:uri.host s_ret:RET_OKAY];
        [self excuteJS:callBackStr];
    }
    
    return iret;
}

- (void)excuteJS:(NSString*) js_str
{
    if( self.web != nil)
        [self.web stringByEvaluatingJavaScriptFromString:js_str];
    else if( self.wk != nil)
        [self.wk evaluateJavaScript:js_str completionHandler:nil];
}

/**
 *  打电话
 */
- (int)callPhone:(XUri *) uri seqid:(NSString*) seqid callback:(NSString*) callback
{
    if (uri && uri.querys)
        [self call:uri.querys];
    
    return RET_OKAY;
}
/**
 *  发短信
 */
- (int)smsPhone:(XUri *) uri seqid:(NSString*) seqid callback:(NSString*) callback
{
//    if (uri&& uri.querys)
//        [self sms:uri.querys];
    if(uri && uri.querys)
    {
        if( self.view && [self.view  isKindOfClass:[WKWebViewController class]] )
        {
            WKWebViewController* wkVc = (WKWebViewController*)self.view;
            [wkVc sms:uri.querys];
        }
        else
            return RET_Exception;
    }
    return RET_OKAY;
}
/**
 *  上报统计接口
 *
 */
-(int) report:(XUri *) uri seqid:(NSString*) seqid callback:(NSString*) callback
{
    if( uri == nil  || uri.querys == nil || uri.querys[kJsbReportPropertyActionID] == nil)
        return RET_IllegalArgument;
    
//    [XDTracker sendEventResultWithID:uri.querys[kJsbReportPropertyActionID] result:uri.querys[kJsbReportPropertyActionValue]];
    return RET_OKAY;
}

/**
 *  关闭当前webView
 *
 */
- (int)closeWebView:(XUri *) uri seqid:(NSString*) seqid callback:(NSString*) callback
{
    if( self.view != nil)
    {
        [self.view.navigationController popViewControllerAnimated:YES];
    }
    return RET_OKAY;
}


/**
 *  设置当前webView属性
 *
 */
- (int)setWebView:(XUri *) uri seqid:(NSString*) seqid callback:(NSString*) callback
{
    if( uri == nil || uri.querys == nil  || self.view == nil)
        return 0;
    NSString* title = uri.querys[kJsbSetPropertyTitle];
    if( title != nil)
    {
        self.view.title = title;
    }
    
    NSString* title_color = uri.querys[kJsbSetPropertyTitleColor];
    if( title_color != nil)
    {
        UIColor *color = UIColorFromRGB([title_color intValue]);
        [self.view.navigationController.navigationBar setBackgroundColor:color];
    }
    
    NSString* title_bar = uri.querys[kJsbSetPropertyTitlebar];
    if( title_bar != nil)
    {
        if( [self.view isKindOfClass:[WKWebViewController class] ])
        {
            BOOL isShowToolbar = [title_bar boolValue];
            WKWebViewController* wk = (WKWebViewController*)self.view;
            [wk hideToolBar:isShowToolbar];
        }
    }

    NSString* tool_bar = uri.querys[kJsbSetPropertyToolBar];
    if( tool_bar != nil)
    {
        self.view.navigationController.navigationBar.hidden = ![tool_bar boolValue];
    }
    return RET_OKAY;
}


/**
 *  设置当前webView属性
 *
 */
- (int)curl:(XUri *) uri  seqid:(NSString*) seqid callback:(NSString*) callback
{
    if( uri == nil || uri.querys == nil )
        return  RET_IllegalArgument;
    
    CURLInput* input = [[CURLInput alloc] initWithDic:uri.querys];
    [ [CURLEngine shareInstance] addTask:input ];
    return RET_OKAY;
}




//忘记服务密码
//使用人工服务找回密码
#pragma mark - 打电话
- (void)call:(NSMutableDictionary *)query
{
    if (query) {
        NSString *phoneNum = query[@"phone"];
        
        if (![phoneNum isEqualToString:@""]) {
            [self showPhoneViewAlertPhoneNum:phoneNum];
        }else{
//            [self.view showHint:@"号码不能为空"];
        }
    }
}

- (void)showPhoneViewAlertPhoneNum:(NSString *)phoneNum
{
    NSString *message;
    
    message = [NSString stringWithFormat:@"是否拨打电话%@",phoneNum];
    
//    [DailogUtils twoBtnDailogWithTitle:nil msg:message can_title:@"取消" can_handler:nil sure_title:@"拨打电话" sure_handler:^(UIAlertAction *action) {
//        NSString *allString = [NSString stringWithFormat:@"tel:%@",phoneNum];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString]];
//    }];
}

#pragma mark - H5发送信息
//- (void)sms:(NSMutableDictionary *)query
//{
//    if (query) {
//        NSString *phoneNumStr = query[@"phone"];
//        NSString *body = query[@"data"];
//        NSArray *phoneNum = [phoneNumStr componentsSeparatedByString:@","];
//        
//        if (![phoneNumStr isEqualToString:@""]) {
//            
//            [self showMessageViewAlertPhoneNumStr:phoneNumStr phoneNum:phoneNum body:body];
//        }else{
//            [self.view showHint:@"号码不能为空"];
//        }
//    }
//    
//}

//- (void)showMessageViewAlertPhoneNumStr:(NSString *)phoneNumStr phoneNum:(NSArray *)phoneNum body:(NSString *)body
//{
//    NSString *message;
//    
//    if ( body) {
//        message = [NSString stringWithFormat:@"发送短信\"%@\"到%@",body,phoneNumStr];
//    }else{
//        message = [NSString stringWithFormat:@"向%@发送信息",phoneNumStr];
//    }
//    
//    [DailogUtils twoBtnDailogWithTitle:nil msg:message can_title:@"取消" can_handler:nil sure_title:@"发送短信" sure_handler:^(UIAlertAction *action) {
//        [self showMessageView:phoneNum title:@"新消息" body:body];
//    }];
//}
//
//-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body{
//
//    
//    if ([MFMessageComposeViewController canSendText]) {
//        MFMessageComposeViewController *msgController = [MFMessageComposeViewController new];
//        //设置接收人 内容 标题
//        msgController.recipients = phones;
//        msgController.body = body;
//        msgController.title = title;
//        
//        //设置代理*********代理
//        msgController.messageComposeDelegate = self;
//        msgController.navigationBar.tintColor = [UIColor redColor];
//        
//        [self.view presentViewController:msgController animated:YES completion:nil];
//        
//        [[[[[msgController viewControllers] lastObject] navigationItem] rightBarButtonItem] setTitle:@"返回"];
//    }else{
//        NSLog(@"该设备不能发短信");
//    }
//}
//
////发送信息回调的代理
//-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
//    switch (result) {
//        case MessageComposeResultSent:
//            NSLog(@"发送成功");
//            [controller showHint:@"发送成功" yOffset:-125];
//            break;
//        case MessageComposeResultFailed:
//            NSLog(@"发送失败");
//        case MessageComposeResultCancelled:
//            NSLog(@"取消发送");
//        default:
//            break;
//    }
//    [controller dismissViewControllerAnimated:YES completion:nil];
//}

@end
