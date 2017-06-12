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

////////认证相关事件
/**
 * 上传身份证数据
 */
#define MSG_SAVE_CARD_SUCCESS   300
#define MSG_SAVE_CARD_FAILURE   301

#define MSG_GET_CARD_SUCCESS    302
#define MSG_GET_CARD_FAILURE    303

#define MSG_SET_FACE_AUTH_SUCCESS   310
#define MSG_SET_FACE_AUTH_FAILURE   311

#define MSG_CHECK_FACE_ERRORCOUNT_SUCC  312
#define MSG_CHECK_FACE_ERRORCOUNT_FAIL  313

//上传用户身份证合照==人脸识别失败后，上传手持身份证照片
#define MSG_FACEPHOTO_SUCCESS  314
#define MSG_FACEPHOTO_FAILURE  315


//判断审核状态
#define MSG_CREDITSTAGE_SUCCESS  320//作废
#define MSG_CREDITSTAGE_FAILURE  321//作废

#define MSG_BASEINFO_SUCCESS 330   // 提取基本信息认证数据成功
#define MSG_BASEINFO_FAILURE 331   // 提取基本信息认证数据失败

//基本信息第一步
#define MSG_USERINFO_FIRST_SUCCESS 332
#define MSG_USERINFO_FIRST_FAILURE 333

//基本信息第二步
#define MSG_USERINFO_SEC_SUCCESS 334
#define MSG_USERINFO_SEC_FAILURE 335

//基本信息第三步
#define MSG_USERINFO_THIRD_SUCCESS 336
#define MSG_USERINFO_THIRD_FAILURE 337

#define MSG_TAOBAOVERIFY_SUCCESS 340
#define MSG_TAOBAOVERIFY_FAILURE 341

//获取额度
#define MSG_AUTHREQUEST_SUCCESS 390
#define MSG_AUTHREQUEST_FAILURE 391

//////////////////////////////////////


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


////////////// TAB相关


#define MSG_BANNER_SUCCESS   500
#define MSG_BANNER_FAILURE   501

#define MSG_HOMETAB_SUCCESS   502
#define MSG_HOMETAB_FAILURE   503

// 获取附近门店
#define MSG_NEARBYSHOP_SUCCESS 510
#define MSG_NEARBYSHOP_FAILURE 511

// 发现页
#define MSG_DISCOVERYPAGE_SUCCESS 520
#define MSG_DISCOVERYPAGE_FAILURE 521

// 活动列表页
#define MSG_ACTIVITYPAGE_SUCCESS 530
#define MSG_ACTIVITYPAGE_FAILURE 531


#define Finance_Improve_Success  550
#define Finance_Improve_Failure  551
////////////////////////////////////

////////////// 订单相关

//正在还款订单
#define MSG_GET_PAYING_ORDER_SUCCESS 600
#define MSG_GET_PAYING_ORDER_FAILURE 601

//已还清订单
#define MSG_GET_PAYED_ORDER_SUCCESS 602
#define MSG_GET_PAYED_ORDER_FAILURE 603

#define MSG_GET_INSTAL_SUCCESS 604
#define MSG_GET_INSTAL_FAILURE 605
//创建订单
#define MSG_CREATE_ORDER_SUCCESS 606
#define MSG_CREATE_ORDER_FAILURE 607
//确认订单
#define MSG_CONFIRM_ORDER_SUCCESS 608
#define MSG_CONFIRM_ORDER_FAILURE 609

//订单详情
#define MSG_GET_ORDERDETAIL_SUCCESS 610
#define MSG_GET_ORDERDETAIL_FAILURE 611

//待还款明细订单详情
#define MSG_GET_REPAYORDERDETAIL_SUCCESS 612
#define MSG_GET_REPAYORDERDETAIL_FAILURE 613

//创建还款订单
#define MSG_CREATE_PREPAY_SUCCESS 614
#define MSG_CREATE_PREPAY_FAILURE 615

//检查订单状态
#define MSG_CHECK_ORDERSTATE_SUCCESS 616
#define MSG_CHECK_ORDERSTATE_FAILURE 617


/////////////////////////////////////


///////////////////银行相关

//可绑定银行卡列表
#define MSG_GET_BANK_BANDLIST_SUCCESS 701
#define MSG_GET_BANK_BANDLIST_FAILURE 702
//可用银行卡列表
#define MSG_GET_BANDLIST_SUCCESS 703
#define MSG_GET_BANDLIST_FAILURE 704

//保存绑卡
#define MSG_SAVE_BANDBANK_SUCCESS 705
#define MSG_SAVE_BANDBANK_FAILURE 706

#define MSG_GET_BANKCARDNUM_SUCCESS 707
#define MSG_GET_BANKCARDNUM_FAILURE 708

#define MSG_GET_BANKURL_SUCCESS 709
#define MSG_GET_BANKURL_FAILURE 710

/////////////////////////////////////



/////////////////////////////////////
/**
 * 信用提升页数据
 */




#define CONTACT_UPLOAD_SUCCESS 2008
#define CONTACT_UPLOAD_FAILURE 2009

#define MSG_OPERATOR_LOGIN_SUCCESS 2010
#define MSG_OPERATOR_LOGIN_FAILURE 2011

#define MSG_OPERATOR_VERIFIED_SUCCESS 2012
#define MSG_OPERATOR_VERIFIED_FAILURE 2013









#pragma MARK - 信用额度

#define MSG_BANK_SUCCESS 2300
#define MSG_BANK_FAILURE 2301

#define MSG_CITY_SUCCESS 2302
#define MSG_CITY_FAILURE 2303





/******************2.0接口*******************/








#define MSG_USERBASEINFOAUTH_SUCCESS 2416
#define MSG_USERBASEINFOAUTH_FAILURE 2417

#define MSG_PAYBANKS_SUCCESS 2418
#define MSG_PAYBANKS_FAILURE 2419

#define MSG_ADDBANKS_SUCCESS 2420
#define MSG_ADDBANKS_FAILURE 2421

// 授权数据等待页
#define MSG_DOCLIST_SUCCESS 2422
#define MSG_DOCLIST_FAILURE 2423




/**
 *  订单相关
 */
#define MSG_CREATEORDER_SUCEESS 2426
#define MSG_CREAREORDER_FAILURE 2427


#define MSG_CONFIRMORDER_SUCEESS 2428
#define MSG_CONFIRMORDER_FAILURE 2429


#define MSG_REPAYMENTORDER_SUCCESS 2430     // 还款成功
#define MSG_REPAYMENTORDER_FAILURE 2431     // 还款失败

#define MSG_ALLREPAYMENTORDER_SUCCESS 2432  // 全部还款成功
#define MSG_ALLREPAYMENTORDER_FAILURE 2433  // 全部还款失败

#define MSG_DEFAULTBANKCARD_SUCCESS 2434
#define MSG_DEFAULTBANKCARD_FAILURE 2435

#define MSG_PREPAYORDER_SUCCESS 2436    // 创建预支付订单成功
#define MSG_PREPAYORDER_FAILURE 2437

#define MSG_CONFIRMPAY_SUCCESS 2438     // 支付成功
#define MSG_CONFIRMPAY_FAILURE 2439

#define MSG_AGAINSENDCODE_SUCCESS 2440      // 重新发送验证码成功
#define MSG_AGAINSENDCODE_FAILURE 2441      // 重新发送验证码失败

#define CONTACT_UPLOAD2_SUCCESS 2442    // 上传通讯录成功
#define CONTACT_UPLOAD2_FAILURE 2443    // 上传通讯录失败










/**
 * 线下消费
 */
#define MSG_BYSTAGES_PAY_SUCCESS   2601
#define MSG_BYSTAGES_PAY_FAILURE   2602



/**
 * 校验身份证
 */

#define MSG_VERIFY_IDNO_SUCCESS   2605
#define MSG_VERIFY_IDNO_FAILURE   2606
/**
 * 校验人脸
 */
#define MSG_VERIFY_FACE_SUCCESS   2607
#define MSG_VERIFY_FACE_FAILURE   2608

/**
 * 校验验证码是否有效
 */
#define MSG_QRVALIDITY_SUCCESS   2609
#define MSG_QRVALIDITY_FAILURE   2610















/**
 *  2.1相关接口
 */
#define MSG_BANKAUTH_SUCCESS 2700
#define MSG_BANKAUTH_FAILURE 2701

#define MSG_SUPPORTBANKLIST_SUCCESS 2702
#define MSG_SUPPORTBANKLIST_FAILURE 2703

#define MSG_BANKISRIGHT_SUCCESS 2704
#define MSG_BANKISRIGHT_FAILURE 2705

#define MSG_BANKBAND_SUCCESS 2706
#define MSG_BANKBAND_FAILURE 2707




// 支付订单相关
#define MSG_DOPAYORDER_SUCCESS 2710
#define MSG_DOPAYORDER_FAILURE 2711





// 获取合同
#define MSG_GET_BARGAIN_SUCCESS 2720
#define MSG_GET_BARGAIN_FAILURE 2721

// 检查用户订单
#define MSG_CHECK_USERORDER_SUCCESS 2722
#define MSG_CHECK_USERORDER_FAILURE 2723














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




