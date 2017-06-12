//
//  ErrorCode.h
//  Faith in life
//
//  Created by alexanxiong on 16/5/12.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#ifndef ErrorCode_h
#define ErrorCode_h

#define OKAY   0

// 本地错误码
#define ERROR_NET_NOT_REACHABLE  -1
#define ERROR_AFN_ERROR          -2
#define ERROR_HTTP_NULL          -3
#define ERROR_INVALID_JSON       -4
#define ERROR_AUTO_FAILED        -5

//服务器错误码

/*  未登录。或者登录过期  */
#define ERROR_SERVER_NOT_LOGIN   1001

/*  无效token  */
#define ERROR_SERVER_BAD_TOKEN   1002

/*  被其他用户踢出  */
#define ERROR_SERVER_KICKED      1003

/*  缺少基础参数  */
#define ERROR_SERVER_INVALID_ARG 2001

/*  缺少业务参数  */
#define ERROR_SERVER_INVALID_ARG2 2002

/*  系统异常     */
#define ERROR_SERVER_EXCEPTION    3001

/*   无效的请求数据  */
#define ERROR_SERVER_INVALID_REQUEST  9001

/*   无效的cmd格式    */
#define ERROR_SERVER_INVALID_CMD  9002

/*   无效cmd,service无效   */
#define ERROR_SERVER_INVALID_CMD2  9003

/*   无效cmd,method无效   */
#define ERROR_SERVER_INVALID_CMD3  9004


/**
 *  通用结果字段
 */
#define RequestSuccess 0    // 请求成功
#define InvalidRequst 9001
#define InvalidCmdFormat 9002
#define InvalidCmd 9003
#define NoLogin 1001
#define InvalidToken 1002
#define LackBaseParam 2001
#define LackBusinessParam 2002
#define SystemException 3001
#define BusinessResponse @"4xxx"
#define CompetenceAbout @"11xx"
#define ParamAbout @"21xx"
#define SystemAbout @"31xx"

/**
 *  通用接口返回码
 */

#define PORT_FAIL_BIZCODE_FTANDONE    4001
#define PORT_FAIL_BIZCODE_FTANDTWO    4002
#define PORT_FAIL_BIZCODE_FTANDTHREE  4003
#define PORT_FAIL_BIZCODE_FTANDFORE   4004
#define PORT_FAIL_BIZCODE_FTANDFIVE   4005
#define PORT_FAIL_BIZCODE_FTANDSIX    4006
#define PORT_FAIL_BIZCODE_FTANDSEVEN  4007
#define PORT_FAIL_BIZCODE_FTANDEIGHT  4008
#define PORT_FAIL_BIZCODE_FTANDNINE   4009


#define PORT_FAIL_ERRORCODE_ONETANDON 1001
#define PORT_FAIL_ERRORCODE_ONETANDTH 1003
#define PORT_FAIL_ERRORCODE_TWOTANDO  2001
#define PORT_FAIL_ERRORCODE_TWOTANDTW 2002
#define PORT_FAIL_ERRORCODE_TWOTANDTH 2003
#define PORT_FAIL_ERRORCODE_TWOTANDFO 2004

/**
 *  支付订单号
 */
#define InvalidOrderNumber 4001
#define InvalidOrderState 4002
#define InvalidRepaymentBankCard 4003
#define OrderOnHandled 4007
#define AddDataFailure 3001
#define ReturnDataFailure 4004


#endif /* ErrorCode_h */
