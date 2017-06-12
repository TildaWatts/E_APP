//
//  SettingInfo.h
//  Faith in life
//
//  Created by alexanxiong  on 16/5/13.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#ifndef SettingInfo_h
#define SettingInfo_h

#import "XResponse.h"

@interface SettingInfo :XData


@property(nonatomic, copy) NSString* rear_url;
@property(nonatomic, copy) NSString* front_url;
@property(nonatomic, copy) NSString* hander_url;
@property(nonatomic, copy) NSString* hander_url2;

@property(nonatomic, copy) NSString* loading_url;
@property(nonatomic, copy) NSString* qalist_url;
@property(nonatomic, copy) NSString* agreement_url;
@property(nonatomic, copy) NSString* introduce_url;
@property(nonatomic, copy) NSString* report_url;
@property(nonatomic, copy) NSString* remarks_url;

@property(nonatomic, copy) NSString* endauth_url;

@property (nonatomic, copy) NSString *creditMax_url;

// 新增
@property (nonatomic, copy) NSString *linkqq_url;

@property (nonatomic, copy) NSString *linkwx_url;

@property (nonatomic, copy) NSString *defaultinter_url;

// 分期详情
@property (nonatomic, copy) NSString *paydetail_url;

@property (nonatomic, copy) NSString *taobaoauth_url;

@property (nonatomic, copy) NSString *jdauth_url;


@property (nonatomic, copy) NSString *stagepaying_url;

@property (nonatomic, copy) NSString *bankauth_url;

@property (nonatomic, copy) NSString *mobileauth_url;

@property (nonatomic, copy) NSString *autowithhold_url;

@property (nonatomic) int maxCredit;

/**
 *  支付相关
 */
@property (nonatomic, copy) NSString *payStart_url;

@property (nonatomic, copy) NSString *supportBank_url;

@property (nonatomic, copy) NSString *linkPhone_url;

@property (nonatomic, copy) NSString *linkPhone2_url;

@property (nonatomic, copy) NSString *payXindun_url;

@property (nonatomic, copy) NSString *ebankAuth_url;

//商品价格
@property (nonatomic) int goodsPrinceMax;
@property (nonatomic) int goodsPrinceMin;

// face limit count
@property (nonatomic)  int userauthLimit;
@property (nonatomic)  double userchecksimilar;

@property (nonatomic, strong) NSString *riskuserTime;

@end


#endif /* SettingInfo_h */
