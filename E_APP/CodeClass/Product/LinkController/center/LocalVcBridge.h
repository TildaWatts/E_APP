//
//  LocalVcBridge.h
//  U_APP
//
//  Created by Ezra on 16/12/3.
//  Copyright © 2016年 Ezra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XUri.h"


//TODO: add more action
#pragma mark - 公共

#pragma mark - 首页
#define ACTION_HOME @"home"                           //1.首页———————————————————HomeViewController
#define ACTION_ADDCARD @"addcard"                     //3添加银行卡——————————————XDAddBankCardController
#define ACTION_FINANCE @"finance"                     //4获取信用额度—————————--——XDCreditLimitViewController
#define ACTION_MESSAGE @"message"                     //6消息——————————————---——HomeMessageController
#define ACTION_QRCODE @"qrcode"                       //7扫描商家提供的二维码————-—QRCodeViewController
#define ACTION_INSTALMENT @"instalment"               //8线下分期————————————————XDStagesConsumeViewController
#define ACTION_BASEINFO_AUTH @"baseinfo_auth"         //22基本信息————————————————XDUserInfoVerifyController
#define ACTION_TAOBAO_AUTH @"taobao_auth"             //23淘宝认证————————————————XDTaobaoVerifyController
#define ACTION_JD_AUTH @"jd_auth"                     //23京东认证————————————————XDTaobaoVerifyController
#define ACTION_ISP_AUTH @"isp_auth"                   //24运营商认证—————————————OperatorInfoViewController
#define ACTION_BANK_AUTH @"bank_auth"                 //25银行卡认证——————————————XDPayedVerifiedProduct2Controller
#define ACTION_PAY @"pay"                             //26线下分期——————————————-—XDStagesConsumeViewController
#define ACTION_PAYABILITY @"payability"               //27还款能力认证—————————————XDPayedVerifiedProduct2Controller、、
#define ACTION_JUMP_MIDPAGE @"loadingPage"            //还款银行卡中间页             JumpBankMidController


#define ACTION_BIND_STORE @"bind_store"                //绑定门店引导页
#define ACTION_BIND_STORE_MID @"mid"                   //绑定门店页（中间过程、成功失败)


#pragma mark - 我的
#define ACTION_MY   @"my"                             //2.我的———————————————————MineViewController
#define ACTION_INSTALMENT_LIST @"instalment_list"     //9分期记录————————————————XDPaymentRecordController
#define ACTION_PAYMENT @"payment"                     //01还款———————————————---—XDRepaymentController
#define ACTION_PAYMENT_ALL @"payment_all"             //11全部还清————————————————XDAllPayedController
#define ACTION_PHOTO_AUTH @"photo_auth"               //13身份证照片验证——————————-CreditVerifiedController
#define ACTION_LOGIN @"login"                         //15一键登录————————————————LoginViewController
#define ACTION_USER_INFO @"user_info"                 //16用户信息————————————————PersonViewController
#define ACTION_COMMON_PROBLEM @"common_problem"       //17常见问题————————————————USOpinionViewController
#define ACTION_ABOUT_US @"about_us"                   //18关于我们————————————————AboutUsViewController
#define ACTION_FEEDBACK @"feedback"                   //19用户反馈————————————————USOpinionViewController
#define ACTION_FEEDBACK_SUCC @"feedback_success"      //反馈成功————————————————--USSecOpinionViewController
#define ACTION_SETTING @"setting"                     //20设置———————————————---—XDSetViewController
#define ACTION_TOOL @"tool"                           //21小工具—————————————--———HomeToolsViewController
#define ACTION_PAYMENTBANKCARD @"payment_card"         //22 还款银行卡-------------CurrentBandBankController
#define ACTION_MODIFY_NICKNAME @"nicename"             //23修改昵称----------------USGetNickViewController

#pragma mark - 咨询
#define ACTION_CUSTOM_SERVICE @"customer_service"      //咨询页面
#define ACTION_ART_SERVICE @"art_service"      //在线客服
#define ACTION_ROBOT_SERVICE @"robot_service"  //智能客服





@interface LocalVcBridge : NSObject


+(void) LinkDestinationVc:(XUri*) uri obj:(UIViewController *)nav dict:(NSMutableDictionary *)dict;

+(void) forward2Page:(NSString*) page obj:(UIViewController *)nav dict:(NSMutableDictionary *)dict uri:(XUri *)uri;


@end
