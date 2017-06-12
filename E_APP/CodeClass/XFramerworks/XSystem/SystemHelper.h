//
//  SystemHelper.h
//  Faith in life
//
//  Created by 王聪 on 16/4/19.
//  Copyright © 2016年 allan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemHelper : NSObject

+ (NSString *)getDeviceName;    //获取设备名称

+ (NSString *)getApp_version;   // 获取APP版本号

+ (NSString *)getDeviceID;      // 获取设备ID

+ (NSString *)getCurrentDeviceModel;

+ (NSString *)getDeviceModel;

+(NSString*) getIMEI;

+ (NSString *)getSystem_version   ; // 获得系统版本号

+ (NSString *)getiOSSDKVersion  ;

+ (NSString *)getIOSID  ;

+ (NSString *)getTelephonyInfo  ;   // 获取运营商信息

+ (NSString *)getNetworkType  ;

+ (NSString *)getHardParam  ;       // 返回CPU类型

+ (NSString *)getBuildVersion ;

+ (NSString *)getApplicationScheme; //获取应用头

+ (NSString *)getApplicationName;   //获取应用名称

+ (NSString *)getApplicationVersion;//获取应用版本

@end
