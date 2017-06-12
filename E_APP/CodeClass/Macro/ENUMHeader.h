//
//  ENUMHeader.h
//  Faith in life
//
//  Created by allan on 16/7/21.
//  Copyright © 2016年 Xinnuo. All rights reserved.
//

#ifndef ENUMHeader_h
#define ENUMHeader_h

typedef enum : NSUInteger
{
    PopupTypePass = 0, //审核通过弹窗
    PopupTypeSuccess = 1,  //获得额度弹窗
    PopupTypeFailure = 2,   //审核失败弹窗
    PopupTypePassToday = 3 //审核通过当天有效弹窗
}PopupType;

typedef enum : NSUInteger {
    PaymentTypeDefault = 0,//已还款
    PaymentTypeStart = 1,//待还款
    PaymentTypePaying = 2,//还款中
    PaymentTypeOutdated = 3,//已逾期
    PaymentTypePayed = 4,//已结清
    PaymentTypeErrorBill = 5,//坏账
    PaymentTypeRepaying = 6//扣款中
} PaymentType;

//扣款状态
typedef enum : NSUInteger {
    RepaymentStateTypeDefault = 0,//默认 不处理
    RepaymentStateTypeRepaying = 1,//扣款中
    RepaymentStateTypeRepaySuccess = 2,//扣款成功
    RepaymentStateTypeRepayFailure = 3//扣款失败
} RepaymentStateType;

// 枚举类型
typedef enum CreditPhotoType{
    CreditPhotoTypePositive = 0,
    CreditPhotoTypeNegative = 1,
    CreditPhotoTypeHand = 2
}CreditPhotoType;




// 检查用户订单
typedef enum : NSUInteger {
    UserOrderTypeNoOrder = 0,   // 无订单
    UserOrderTypeWaitSignOrder = 1,  // 有待签约订单
    UserOrderTypeWaitReviewOrder = 2,   // 有待审核订单
    UserOrderTypeNotPayedOrder = 3    // 有未还清订单（已签约）
} UserOrderType;



#endif /* ENUMHeader_h */
