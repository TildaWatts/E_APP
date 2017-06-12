//
//  XHead.h
//  Faith in life
//
//  Created by alexanxiong on 16/5/12.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#ifndef XHead_h
#define XHead_h

#import <Foundation/Foundation.h>

@interface XHead : NSObject

+(XHead*) shareInstance;

-(NSMutableDictionary*) getXHead;
-(void) updateXHead ;
-(void) loadFromDic :(NSDictionary*) dic;

@end


#endif /* XHead_h */
