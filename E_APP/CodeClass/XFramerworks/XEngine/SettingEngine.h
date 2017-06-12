//
//  SettingEngine.h
//  Faith in life
//
//  Created by alexanxiong on 16/5/13.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#import "XEngine.h"
#import "SettingInfo.h"

@interface SettingEngine : XEngine

+(SettingEngine*) shareInstance ;

@property(nonatomic) SettingInfo* info;

-(void) request;

-(SettingInfo*) getData:(BOOL) bImport;

-(int) getCreditMax ;

-(int) getCreditMin ;

-(int) getFaceLimit ;


//修改用户设置
-(void) setUserSetting:(NSString*) key value:(NSString*) value;
//拉取用户设置
-(void) getUserSetting;

@end
