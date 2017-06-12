//
//  CoderZipper.h
//  Xinnuo
//
//  Created by alexanxiong on 16/5/10.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#ifndef EventCenter_h
#define EventCenter_h


#import <Foundation/Foundation.h>
#import "EventListener.h"
#import "MsgConst.h"

#ifdef __cplusplus
extern "C" {
#endif
    
    //////////////////////////////////////////////////////
    //    事件中心
    
    /**
     * 增加事件监控。eg:     CZ_AddObj2DeftNotiCenter(self, @selector(becomeActive), UIApplicationDidBecomeActiveNotification, nil);
     *  obs 为对象，sel 为响应函数，name为事件名
     */
    void CZ_AddObj2DeftNotiCenter(id obs, SEL sel, NSString* name, id obj);
    
    void CZ_RemoveObjFromDeftNotiCenter(id obs, NSString* name, id obj);
    
    void CZ_RemoveObjFromDeftNotiCenterOnly(id obs);
    
    void CZ_PostNotifyWithInfo(NSString* name, id obj, NSDictionary* userInfo);
    
    void CZ_PostNotify(NSString* name, id obj);
    
    
    
#ifdef __cplusplus
}
#endif

@interface EventCenter : NSObject

/**
 *  msg see in MsgConst.h
 *  obj implements EventListener
 */
+(void) Event_Add:(int) msg obj:(NSObject*) obj;

/**
 * same as  Event_Add
 */
+(void) Event_Remove:(int) msg obj:(id) obj;


+(void) Event_Remove:(id) obj;

/**
 * post msg
 *
 */
+(void) Event_Post:(int) msg;

/**
 * post msg and obj
 *
 */
+(void) Event_PostData:(int) msg obj:(id) obj;

+(void) Event_PostData:(int) msg data:(XResponse*) obj;


@end



#endif /* EventCenter_h */
