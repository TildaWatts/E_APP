//
//  CURLEngine.h
//  Faith in life
//
//  Created by alexanxiong on 16/9/22.
//  Copyright © 2016年 Xinnuo. All rights reserved.
//

#ifndef CURLEngine_h
#define CURLEngine_h

#import "XEngine.h"
#import "CURLInput.h"
#import "CURLOutput.h"
#import "CCookie.h"

@interface CURLEngine : XEngine<NSURLSessionDelegate,NSURLSessionDataDelegate>

+(CURLEngine*) shareInstance ;

- (void)addTask:(CURLInput*) task;
-(void)pushCURL:(CURLOutput*) task;


@end
#endif /* CURLEngine_h */
