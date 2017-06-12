//
//  Event.h
//  Faith in life
//
//  Created by alexanxiong on 16/5/12.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#ifndef Event_h
#define Event_h

#import "Event.h"
#import "XResponse.h"
@interface Event:NSObject

@property(nonatomic)       int what;
@property(nonatomic , retain) XResponse*  data;

@property(nonatomic , retain) id  obj;


-(id) initWithid:(int) event_id;
@end

#endif /* Event_h */
