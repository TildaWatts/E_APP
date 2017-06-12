//
//  EventListener.h
//  Faith in life
//
//  Created by alexanxiong on 16/5/12.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#ifndef EventListener_h
#define EventListener_h
#import <Foundation/Foundation.h>

#import "Event.h"

@protocol EventListener


/**
 * eg:
    -(void) handlerEvent:(NSNotification *)note
    {
        if( note.object != nil)
        {
            Event* event = (Event*)note.object;
            switch (event.what)
            {
                case MSG_CHECK_PHONE_SUCCESS:
                {
                    CheckPhoneInfo* info = event.obj;
                    if( info != nil  && info.phone != nil)
                    {
                        [[LoginEngine shareInstance] sendLoginSMS:info.phone reged: info.reged model: _SMS_MODEL_SMS ];
                        [self SecLoginView];
                    }
            }break;
            case MSG_CHECK_PHONE_FAIL:
            {
            }  break;
*/

-(void)handlerEvent:(NSNotification *)  event;

@end

#endif /* EventListener_h */
