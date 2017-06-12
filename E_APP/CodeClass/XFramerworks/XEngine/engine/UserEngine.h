//
//  UserEngine.h
//  Faith in life
//
//  Created by kingcong on 16/5/16.
//  Copyright © 2016年 allan. All rights reserved.
//

#import "XEngine.h"

@interface UserEngine : XEngine


+ (UserEngine *)shareInstance;




//风控日志
- (void)traceLog:(NSMutableDictionary *)params;
- (void)traceLogp1:(NSString *)p1 p2:(NSString *)p2 p3:(NSString *)p3 process:(NSString *)process;
- (void)traceLogp1:(NSString *)p1 p2:(NSString *)p2 p3:(NSString *)p3 process:(NSString *)process  result:(NSString*) result reaseon:(NSString*) reason;

- (void)testinterface:(NSString *)word;
- (void)ss:(NSString *)ss;

/**
 *  重新刷新用户信息数据
 */

/**
 *   判断审核状态
 */

//- (XDCreditStageModel *)getCreditStages;

@end
