//
//  ConstantHeader.h

//  Faith in life
//
//  Created by kingcong on 16/5/26.
//  Copyright © 2016年 allan. All rights reserved.
//



#ifndef  ConstantHeader_H
#define  ConstantHeader_H

#define  APP_NAME_TEXT  @"糯米袋"
#define App_Url @"itms-apps://itunes.apple.com/us/app/nuo-mi-dai/id1190063406?mt=8"

/**
 *  界面标题
 */
#define LOGIN_TITLE                 @"快捷登录"
#define LOGINCODE_TITLE                 @"填写验证码"
#define START_ADD                   @"启动页广告"
#define HOME_TITLE                  @"糯米袋"
#define SETPASSWARD_TITLE           @"设置密码"
#define FIND_TITLE                  @"发现"
#define MINE_TITLE                  @"我的"
#define CONSULT_TITLE               @"咨询"

/**
 *  登陆相关返回码描述
 */
#define CHECK_PHONE_FAIL_BADNUMBER   @"请输入正确的移动/电信/联通手机号"
#define SEND_VOIVE_FAIL_HIHT        @"语音验证码获取失败，请重试"
#define CHECK_PHONE_TEXTFILER       @"请输入您最常使用的手机号码"
#define LOGIN_PHONE_LENTH           @"手机号不能大于11位"
#define LOGIN_CHECK_PHONE           @"请检查输入的手机号是否正确"
#define LOGIN_CHECK_PHONE_REGISTER  @"请确认该手机号码在移动/电信/联通登记姓名为您本人，否则将无法获得额度"



/**
 *  登陆UI描述
 */
#define CodeLabelHiht      @"验证码已发送至 : "
#define SendLabelHiht      @"60秒您仍未收到验证码,可使用"
#define ErrorLabelHiht     @"请检查输入的验证码是否正确"
#define VoiceLabelHiht     @"5s 内您将收到语音电话，请注意接听"
#define CodeHiht           @"60秒内仅可获取一次验证码，20分钟内有效"
#define LoginFail          @"请检查输入的验证码是否正确"
/**
 *  首页UI描述
 */
#define Credit_State_Failure  @"未通过审核"
#define Home_btn_get_limit    @"获得信用额度"
#define Home_Lab_limit        @"最高额度"      
#define Home_Btn_Activate     @"立即激活"
#define Credit_State_ALab     @"额度审核中"
#define Credit_State_BLab     @"请稍等片刻"
#define Home_Lab_CreditLimit  @"信用额度"
#define Home_Lab_SurPlusLimit @"剩余额度(元)"
#define Home_Btn_Check_Limit  @"查看授权信息"
#define Home_Btn_Updata_Limit @"更新授信额度"
#define Credit_State_OutLab   @"已过期"
/**
 *  弹框提示
 */
#define AlterTitle           @"提示"
#define AlterQuify           @"确定"
#define AlterCertain         @"确认"
#define PleaseFirstFinished  @"请先完成"
#define GoSetting            @"去授权"
#define GoUpdate             @"去更新"
#define Cancel               @"取消"
#define MyKnow               @"我知道了"
#define AlterAccredit        @"去授权"
#define InputAgain           @"重新输入"
#define NewOrder             @"新建订单"
#define InstanceSign         @"立即签约"

/**
 *  相机照片权限提示
 */
#define PHOTO_AUTHORITY      @"亲,您需要在[系统设置->隐私->相机]里面设置允许手机访问相机才行哦~"

/**
 *  首页弹框提示
 */
#define ALTER_HOME_GET_LIMIT             @"请先授权信息并获得信用额度"
#define ALTER_HOME_ACCREDIT_GETTIME      @"您的授权信息已过期，请更新后重试"
#define ALTER_HOME_ACCREDIT_FAIL         @"请先获得信用额度~"
#define ALTER_HOME_ACCREDITING           @"额度审核即将完成，之后即可分期，请稍作等待"
#define ALTER_HOME_BYSTAGES              @"您已经有一个分期订单了,完成还款后可再次分期"
#define ALTER_HOME_LIMIT_NOENOUGH        @"您的额度小于最小分期额度800元，敬请期待其他业务！"
#define ALTER_HOME_SET_PASSWARD          @"为了您账户安全，请先设置支付密码！"

#define ALTER_HOME_HAVE_SIGNORDER        @"您有一笔订单待签约，创建订单将会覆盖原有的订单哦！"
#define ALTER_HOME_HAVE_NOTREVIEWORDER   @"您有一笔订单正在进行中，暂时无法创建新订单哦！"
#define ALERT_GETLIMIT_SKIN              @"填写电商认证将大大提升您的信用额度，提交后将无法修改"

/**
 *  基类
 */
#define SUPER_USER_QUILT    @"您的账号在另一个地方登录，请您重新登录"
#define SUPER_USER_OUTDATE    @"登录过期，请重新登录"


/**
 *  基本信息
 */
#define CreditLimitTitle     @"激活额度"  // 信用额度标题
#define PopWindowNotiMessage @"您需要先更新授权信息"
#define BankVerifyTitle      @"支持银行卡"
#define TaobaoVerifyTitle    @"淘宝认证"
#define TaobaoHeaderDesc     @"为用户安全保障，由xxx保险公司100%承担"
#define RealNameNetWrong     @"网络异常，请尝试切换网络后再重新提交"

/**
 *  还款
 */
#define RepaymentOrderNotExist @"还款明细订单不存在"
#define RepaymentBankCardNotExist @"还款银行卡不存在"

/**
 *  支付订单号
 */
#define InvalidOrderNumberDesc @"无效订单号"
#define InvalidOrderStateDesc @"无效订单状态"
#define InvalidRepaymentBankCardDesc @"您还未绑定还款银行卡"
#define OrderOnHandledDesc @"订单正在处理中"
#define AddDataFailureDesc @"添加数据失败"
#define ReturnDataFailureDesc @"返回数据失败"

#define SendCodeSuccess @"发送验证码成功"
#define SendCodeFailure @"发送验证码失败"


#define CreatePreOrderSuccess @"创建预支付订单成功"
#define CreatePreOrderFailure @"创建预支付订单失败"

/**
 *  返回码其他错误提示或网络问题
 */
#define OTHER_FAIL_OR_NETWORK       @"网络不稳定，建议您切换网络后重试"
#define NewworkConnectFailure       @"亲，您的网络好像有问题哦"
#define RequestFailure              @"网络请求失败"
#define REQUEST_TIMEOUT             @"请求超时,请稍后重试"


#define LaunchTimeCompare @"LaunchTimeCompare"
#define AdPopViewTimeCompare @"AdPopViewTimeCompare"
#define AdPopViewTimeInterval @"AdPopViewTimeInterval"  // 广告弹窗时间间隔


#define PRODUCTPRICENOTI @"请输入商品价格"
#define CARDNULLNOTI @"请输入储蓄卡号"
#define GOODSPRICERANGE @"商品金额范围：1000-30000"


//修改密码
#define VerityIDNum @"您身份证后6位错误次数已达到5次，已失去重置密码机会"


#define LocationErrorServiceUnable 20   // 定位服务未开启
#define LocationErrorPowerStatusNotDetermined 21 // 用户未决定授权
#define LocationErrorPowerStatusRestricted 22
#define LocationErrorPowerStatusDenied 23   // 用户拒绝授权
#define LocationErrorPower




/**
 *  URL Scheme
 */
#define GaodeMapAppScheme @"iosamap://" // 高德地图
#define BaiduMapAppScheme @"baidumap://"  // 百度地图




//********************************风控日志****************************************//
/**
 *风控日志
 *
 */
#define BeginExpose @"曝光"
#define BeginClick @"点击"
#define STEP_END   @"结束"

#define RESULT_SUCC  @"成功"
#define RESULT_FAIL  @"失败"


#define RiskBlank @""
/**
 *风控日志P1
 *
 */
#define RiskVestingOfTrust @"授信"
#define RiskLimitTest      @"额度测试"
#define RiskOrder          @"订单"

/**
 *风控日志P2
 *
 */
#define RiskP2RealNameVerify      @"实名认证"
#define RiskP2UserInfo            @"基本信息授信"
#define RiskP2RepayAbilityVerify  @"还款能力认证"
#define RiskP2OperatorVerify      @"运营商认证"
#define RiskP2ECommerceVerify     @"电商认证"
#define RiskP2FaceDetect          @"刷脸"
#define RiskP2PayPassword         @"支付密码"
#define RiskP2LocationRisk        @"本地风控"
#define RiskP2OrderScanner        @"订单扫码"
#define RiskP2OrderInstalSelect   @"订单分期选择"
#define RiskP2OrderPayPassword    @"订单支付密码"

/**
 *风控日志P3
 *
 */

#define RiskP3UserInfo              @"第一步-基本信息"
#define RiskP3Contact               @"第二步-通讯录联系人"
#define RiskP3TaobaoVerify          @"淘宝认证"
#define RiskP3JDVerify              @"京东认证"
#endif

