//
//  Header.h
//  Faith in life
//
//  Created by alexanxiong on 16/9/22.
//  Copyright © 2016年 Xinnuo. All rights reserved.
//

#ifndef CURLInput_H
#define CURLInput_H

#import "XResponse.h"

@interface CURLInput : XData

-(id) initWithDic:(NSDictionary *) dic;
-(id) initWithXResponse:(XResponse *)res;


@property(nonatomic, copy) NSString *task_id;
@property(nonatomic, copy) NSString *url;
@property(nonatomic, copy) NSString *data;
@property(nonatomic, copy) NSString *method;
@property(nonatomic, copy) NSString *cookie;

@property (nonatomic, strong) NSDictionary * params;

@end

#endif /* CURLInput_H */
