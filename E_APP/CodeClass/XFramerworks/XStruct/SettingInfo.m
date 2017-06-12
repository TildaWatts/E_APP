//
//  SettingInfo.m
//  Faith in life
//
//  Created by alexanxiong on 16/5/13.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#import "SettingInfo.h"
#import "CommonUtils.h"

#define KEY_REAR_URL   @"client.idcard.demopict.rear"
#define KEY_FRONT_URL  @"client.idcard.demopict.front"
#define KEY_HANDER_URL @"client.idcard.demopict.hander"
#define KEY_HANDER_URL2  @"client.idcard.demopict.hander2"
#define KEY_LOADING_URL  @"client.loading.pict"
#define KEY_QALIST_URL   @"client.h5.qalist"
#define KEY_AGREEMENTS_URL @"client.h5.agreements"//服务与隐私协议

#define KEY_INTRODUCE_URL  @"client.h5.introduce"
#define KEY_REPORTS_URL    @"client.credit.reports"
#define KEY_REMARKS        @"client.credit.address.remarks"
#define KEY_ENDAUTH_URL    @"client.credit.mobile.endauth"

#define KEY_CREDITMAX_URL  @"client.credit.max"

#define KEY_LINKQQ_URL   @"client.link.qq"
#define KEY_LINKWX_URL   @"client.link.wx"
#define KEY_DEFAULTINTER_URL   @"client.install.defaultinter"

#define KEY_PAYDETAIL_URL @"client.install.detailurl"   // 分期详情h5 URL

#define KEY_TAOBAOAUTH_URL @"client.taobao.auth.agreements"  // 淘宝授权协议
#define KEY_JDAUTH_URL @"client.jd.auth.agreements"  // 京东授权协议

#define KEY_BYSTAGESPAY_URL @"client.stage.paying.agreements"   // 糯米袋分期声明
#define KEY_BANKAUTH_URL @"client.ebank.auth.agreements"  // 银行授权协议
#define KEY_MOBILEAUTH_URL @"client.credit.mobile.agreements"   // 运营商授权协议
#define KEY_AUTOWITHHOLD_URL @"client.h5.withhold"  //连连支付代扣协议

#define KEY_USERCHECKSIMILAR_URL @"client.usercheck.similarity" // 人脸识别

#define KEY_CREDIT_MAX @"client.credit.max" // 人脸识别

#define KEY_PAYSTART_URL @"client.pay.starturl" // 支付开始URL

#define KEY_SUPPORTBANK_URL @"client.pay.banks"  // 支持银行

#define KEY_LINKPHONE_URL @"client.link.phone"  // 客服电话
#define KEY_LINKPHONE2_URL @"client.link.phone2"  // 备用客服电话

#define KEY_PAYXINDUN_URL @"client.pay.xinnuourl"   // 信盾支付URL

#define KEY_EBANKAUTH_URL @"client.ebank.auth"  // 银行卡跳转URL

#define KEY_GOODSPRICERANGE_MAX @"client.goods.max"//商品价格范围最小值
#define KEY_GOODSPRICERANGE_MIN @"client.goods.min"//商品价格方位最大值
#define KEY_USERAUTH_LIMIT      @"client.userauth.limit" //刷脸最大次数

#define KEY_RISKUSER_TIME @"client.credit.avaliable.time"//风险用户时限


@implementation SettingInfo

-(id) initWithXResponse:(XResponse*) res
{
//    self = [super init];
    
    if( res != nil  && res.o_ret != nil)
    {
        self.maxCredit = [CommonUtils getInt:res.o_ret key:KEY_CREDIT_MAX];

        self.goodsPrinceMax = [CommonUtils getInt:res.o_ret key:KEY_GOODSPRICERANGE_MAX];
        self.goodsPrinceMin = [CommonUtils getInt:res.o_ret key:KEY_GOODSPRICERANGE_MIN];
        
        self.rear_url = [CommonUtils getString:res.o_ret key:KEY_REAR_URL];
        self.front_url = [CommonUtils getString:res.o_ret key:KEY_FRONT_URL];
        self.hander_url = [CommonUtils getString:res.o_ret key:KEY_HANDER_URL];
        self.hander_url2 = [CommonUtils getString:res.o_ret key:KEY_HANDER_URL2];

        self.loading_url = [CommonUtils getString:res.o_ret key:KEY_LOADING_URL];
        self.qalist_url = [CommonUtils getString:res.o_ret key:KEY_QALIST_URL];
        self.agreement_url = [CommonUtils getString:res.o_ret key:KEY_AGREEMENTS_URL];
        self.introduce_url = [CommonUtils getString:res.o_ret key:KEY_INTRODUCE_URL];
        self.report_url = [CommonUtils getString:res.o_ret key:KEY_REPORTS_URL];
        self.remarks_url = [CommonUtils getString:res.o_ret key:KEY_REMARKS];
        self.endauth_url = [CommonUtils getString:res.o_ret key:KEY_ENDAUTH_URL];
        
        self.creditMax_url = [CommonUtils getString:res.o_ret key:KEY_CREDITMAX_URL];
        
        self.linkqq_url = [CommonUtils getString:res.o_ret key:KEY_LINKQQ_URL];
        self.linkwx_url = [CommonUtils getString:res.o_ret key:KEY_LINKWX_URL];
        self.defaultinter_url = [CommonUtils getString:res.o_ret key:KEY_DEFAULTINTER_URL];
        
        self.paydetail_url = [CommonUtils getString:res.o_ret key:KEY_PAYDETAIL_URL];
        
        self.taobaoauth_url = [CommonUtils getString:res.o_ret key:KEY_TAOBAOAUTH_URL];
        self.jdauth_url     = [CommonUtils getString:res.o_ret key:KEY_JDAUTH_URL];
        self.stagepaying_url = [CommonUtils getString:res.o_ret key:KEY_BYSTAGESPAY_URL];
        self.bankauth_url = [CommonUtils getString:res.o_ret key:KEY_BANKAUTH_URL];
        self.mobileauth_url = [CommonUtils getString:res.o_ret key:KEY_MOBILEAUTH_URL];
        self.autowithhold_url = [CommonUtils getString:res.o_ret key:KEY_AUTOWITHHOLD_URL];
        
        self.payStart_url = [CommonUtils getString:res.o_ret key:KEY_PAYSTART_URL];
        self.supportBank_url = [CommonUtils getString:res.o_ret key:KEY_SUPPORTBANK_URL];
        
        self.linkPhone_url = [CommonUtils getString:res.o_ret key:KEY_LINKPHONE_URL];
        self.linkPhone2_url = [CommonUtils getString:res.o_ret key:KEY_LINKPHONE2_URL];
        
        self.payXindun_url = [CommonUtils getString:res.o_ret key:KEY_PAYXINDUN_URL];
        
        self.ebankAuth_url = [CommonUtils getString:res.o_ret key:KEY_EBANKAUTH_URL];
        
        self.userauthLimit = [CommonUtils getInt: res.o_ret key:KEY_USERAUTH_LIMIT];
        self.userchecksimilar = [CommonUtils getDouble:res.o_ret key:KEY_USERCHECKSIMILAR_URL];
        self.riskuserTime = [CommonUtils getString:res.o_ret key:KEY_RISKUSER_TIME];
    
    }
    return self;
}

@end


