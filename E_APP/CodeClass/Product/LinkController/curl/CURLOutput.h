//
//  CURLOutput.h
//  Faith in life
//
//  Created by alexanxiong on 16/9/22.
//  Copyright © 2016年 Xinnuo. All rights reserved.
//

#ifndef CURLOutput_h
#define CURLOutput_h

#import "XRequest.h"

@interface CURLOutput : XRequest

-(id)initWithURL:(NSString*) url  task:(NSString*) taskid  code:(NSString*) code;
-(void) addheader:(NSString*) key value:(NSString*) value;
-(void) fill;

@property(nonatomic, copy) NSString *taskid;
@property(nonatomic, copy) NSString *url;
@property(nonatomic, copy) NSString *content;
@property(nonatomic, copy) NSString *code;

@property(nonatomic, copy) NSMutableDictionary* c_header;

@end

#endif /* CURLOutput_h */
