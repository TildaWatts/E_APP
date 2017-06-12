//
//  UtilsHeader.h
//  Faith in life
//
//  Created by allan on 16/7/21.
//  Copyright © 2016年 Xinnuo. All rights reserved.
//

#ifndef UtilsHeader_h
#define UtilsHeader_h


//设备分类
#define iPhone4s  [UIScreen mainScreen].bounds.size.height == 480
#define iPhone5  [UIScreen mainScreen].bounds.size.height == 568
#define iPhone6  [UIScreen mainScreen].bounds.size.height == 667
#define iPhone6Plus  [UIScreen mainScreen].bounds.size.height == 736

//iOS7系统
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)


#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_4  (fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON)
#define IS_IPHONE_5  (fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON)
#define IS_IPHONE_6  (fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)



/****判断真机或是模拟器****/
#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#endif

#endif /* UtilsHeader_h */
