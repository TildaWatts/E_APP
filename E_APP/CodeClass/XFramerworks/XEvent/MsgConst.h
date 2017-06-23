//
//  MsgConst.h
//  Xinnuo
//
//  Created by alexanxiong on 16/5/10.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#ifndef MsgConst_h
#define MsgConst_h


//////// 基本事件
//   系统事件
#define MSG_NET_CHANGE        1
#define MSG_BATTERY_CHANGE    2

#define MSG_VERSIONUPDATE_SUCCESS 10
#define MSG_VERSIONUPDATE_FAILURE 11

//   文件事件
#define MSG_FILE_UPLOAD_SUCCESS       100
#define MSG_FILE_UPLOAD_FAIL          101

#define MSG_SETTING_UPDATE             110   //APP设置更新

#define MSG_USER_SETTING_SUC           120   //递交用户设置成功
#define MSG_USER_SETTING_FAIL          121   //递交用户设置失败
#define MSG_GET_USER_SETTING_SUC           130  //获取用户设置成功
#define MSG_GET_USER_SETTING_FAIL          131  //获取用户设置失败

#define MESSAGE_INFO_SUCCESS 140
#define MESSAGE_INFO_FAILURE 141

#define MSG_REPAYMENTNOTI_SUCCESS 142  // 文字通知(还款提醒成功)
#define MSG_REPAYMENTNOTI_FAILURE 143  //

#define MSG_LIST_NOTICE_SUCC 144       //通知拉取
#define MSG_LIST_NOTICE_FAIL 145

#define MSG_CLEAR_NOTICE_SUCC     146  //清除授信成功通知
#define MSG_CLEAR_NOTICE_FAIL     147



///////////////////////////////////
/**
*E_APP_MSG
*
**/

#define MSG_KLINE_SUCCESS 300








/** 2016.10.21 Version：2.2.2
 *   风控日志
 */
#define MSG_TRACELOG_SUCCESS 180
#define MSG_TRACELOG_FAILURE 181

#define MSG_TEMPSESSIONKEY_SUCCESS 190
#define MSG_TEMPSESSIONKEY_FAILURE 191

///////////////////////////////////////////
/**
 * 登录相关事件
 */
#define MSG_CHECK_PHONE_SUCCESS        200
#define MSG_CHECK_PHONE_FAIL           201

#define MSG_SEND_SMS_SUCCESS           202
#define MSG_SEND_SMS_FAIL              203

#define MSG_CHECK_INVITE_SUCCESS       204
#define MSG_CHECK_INVITE_FAIL          205

#define MSG_LOGIN_SUCCESS              206
#define MSG_LOGIN_FAIL                 207
#define MSG_ALOGIN_SUCCESS             208
#define MSG_ALOGIN_FAIL                209
#define MSG_LOGOUT                     210

#define MSG_SEND_VOICE_SUCCESS         211
#define MSG_SEND_VOIVE_FAIL            212

#define MSG_OUT_LOGIN_FAILURE          213

#define MSG_CHECK_CODE_SUCCESS         214
#define MSG_CHECK_CODE_FAIL            215

#define MSG_AUTO_LOHIN_FAIL            216


////////////用户相关事件

#define MSG_USERINFO2_SUCCESS 400
#define MSG_USERINFO2_FAILURE 401

#define MSG_OPINION_CALLBACK_SUCCESS 402
#define MSG_OPINION_CALLBACK_FAILURE 403

#define MSG_ALTER_NICK_SUCCESS   404
#define MSG_ALTER_NICK_FAILURE   405

#define MSG_ALTER_PHOTO_SUCCESS   406
#define MSG_ALTER_PHOTO_FAILURE   407

#define MSG_SET_PAY_PASSWORD_SUCC      410
#define MSG_SET_PAY_PASSWORD_FAIL      411

#define MSG_AMEND_PAY_PASSWARD_SUCCESS   412
#define MSG_AMEND_PAY_PASSWARD_FAILURE   413

#define MSG_RESET_PAY_PASSWARD_SUCCESS   414
#define MSG_RESET_PAY_PASSWARD_FAILURE   415

#define MSG_CHECK_PAY_PASSWARD_SUCCESS   416
#define MSG_CHECK_PAY_PASSWARD_FAILURE   417

//////////////////////////////////////




/////////////////////////////////////






#endif /* MsgConst_h */


/** 2016.9.27 Version：2.0.1
 *   相关接口
 */
#define MSG_GOODSPRICERANGE_MAX 2800
#define MSG_GOODSPRICERANGE_MIN 2801

#define MSG_CHECKCREDIT_SUCCESS 2802
#define MSG_CHECKCREDIT_FAILURE 2803

#define MSG_UPLOAD_USER_SUCCESS 2804
#define MSG_UPLOAD_USER_FAILURE 2805

#define MSG_UPLOAD_USER_ADRESS_SUCCESS 2806
#define MSG_UPLOAD_USER_ADRESS_FAILURE 2807




