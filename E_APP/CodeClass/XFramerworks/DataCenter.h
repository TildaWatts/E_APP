//
//  DataCenter.h
//  
//
//  Created by alexanxiong on 16/5/10.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#ifndef DataCenter_h
#define DataCenter_h

#import <UIKit/UIKit.h>

@interface DataCenter : NSObject
+(DataCenter*) shareInstance;

/**
 *  初始化App
 */
-(id) initApp;

/**
 *  加载用户信息
 */
-(void) load ;

/**
 *  清理用户数据
 */
-(void) clearUserInfo ;


//lauch property
@property(nonatomic) BOOL isFirstLauch;
@property(nonatomic) double lastLauchTime;
@property(nonatomic) double thisLauchTime;
@property(nonatomic) double lastLoginTime;


//phone property
@property(nonatomic, copy) NSString *model;
@property(nonatomic, copy) NSString *guid;
@property(nonatomic, copy) NSString *device_id;
@property(nonatomic, copy) NSString *platform;
@property(nonatomic, copy) NSString *channel;


//app property
@property(nonatomic) int versionCode;

@property(nonatomic, copy) NSString *app_version;


//net property
@property(nonatomic, copy) NSString *ip;
@property(nonatomic) int areacode;

//user property
@property(nonatomic) int uid;
@property(nonatomic, copy) NSString *phone;
@property(nonatomic, copy) NSString *token;
@property(nonatomic, copy) NSString *sessionkey;

@property (nonatomic, copy) NSString *tempSessionkey;

//@property (nonatomic, strong) UserInfo *userInfo;

@end


#endif /* DataCenter_h */
