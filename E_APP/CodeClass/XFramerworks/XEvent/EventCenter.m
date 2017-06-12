//
//  EventCenter.m
//  Xinnuo
//
//  Created by alexanxiong on 16/5/10.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#import "EventCenter.h"
#import "CommonUtils.h"
#import "EventListener.h"
#import "XResponse.h"

void CZ_AddObj2DeftNotiCenter(id obs, SEL sel, NSString* name, id obj)
{
    [[NSNotificationCenter defaultCenter] addObserver:obs selector:sel name:name object:obj];
}

void CZ_RemoveObjFromDeftNotiCenter(id obs, NSString* name, id obj)
{
    [[NSNotificationCenter defaultCenter] removeObserver:obs name:name object:obj];
}

void CZ_RemoveObjFromDeftNotiCenterOnly(id obs)
{
    [[NSNotificationCenter defaultCenter] removeObserver:obs];
}

void CZ_PostNotifyWithInfo(NSString* name, id obj, NSDictionary* userInfo)
{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj userInfo:userInfo];
}

void CZ_PostNotify(NSString* name, id obj)
{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];
}

@implementation EventCenter

+(void) Event_Add:(int) msg obj:(NSObject*) obj
{
    if( class_conformsToProtocol([obj class] ,@protocol(EventListener)) == YES)
    {
        CZ_AddObj2DeftNotiCenter(obj, @selector(handlerEvent:), [CommonUtils int2NString:msg] , nil);
    }
}

+(void) Event_Remove:(int) msg obj:(id) obj
{
    CZ_RemoveObjFromDeftNotiCenter(obj, [CommonUtils int2NString:msg],nil);
}

+(void) Event_Remove:(id) obj
{
    CZ_RemoveObjFromDeftNotiCenterOnly(obj);
}

/**
 *  不需要返回结果的发送类型
 *
 *  @param msg 消息类型
 */
+(void) Event_Post:(int) msg
{
    Event* event = [[Event alloc] initWithid:msg];
    CZ_PostNotify([CommonUtils int2NString:msg],event);
}

/**
 *  请求成功后发送通知
 *
 *  @param msg 请求类型为自己配置的ID
 *  @param obj 返回请求结果，此时为发送通知时自己配置的模型类型
 */
+(void) Event_PostData:(int) msg obj:(id) obj
{
    Event* event = [[Event alloc] initWithid:msg];
    event.obj = obj;
    
    CZ_PostNotify([CommonUtils int2NString:msg],event);
}

/**
 *  请求成功后发送通知
 *
 *  @param msg 请求类型
 *  @param obj 请求返回的结果，此时直接将XResponse返回
 */
+(void) Event_PostData:(int) msg data:(XResponse*) obj
{
    Event* event = [[Event alloc] initWithid:msg];
    event.data = obj;
    
    CZ_PostNotify([CommonUtils int2NString:msg],event);
}


@end
