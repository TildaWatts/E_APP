//
//  UIHeader.h
//  U_APP
//
//  Created by alexanxiong on 2016/12/1.
//  Copyright © 2016年 Ezra. All rights reserved.
//

#ifndef UIHeader_h
#define UIHeader_h

////////////////////////////////////
//屏幕宽高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//UI标注图的屏幕size为(375.f, 667.f)
//屏幕高度缩放
#define kScreenHeightScale  kScreenHeight / 667.f
// 屏幕宽度比例
#define KScreenWidthScale  kScreenWidth / 375.f

/***** 设备信息 *****/
#define kWindowWidth   [UIApplication sharedApplication].keyWindow.frame.size.width
#define kWindowHeight  [UIApplication sharedApplication].keyWindow.frame.size.height

#define SCREEN_MAX_LENGTH (MAX(kWindowWidth, kWindowHeight))
////////////////////////////////////


///////////////////////////////////

//随机色
#define kColorWithRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)];

#define HexRGBColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//字体颜色
#define kBorderColor [[UIColor colorWithRed:105 /255.0 green:105 /255.0 blue:105 /255.0 alpha:1.0]CGColor]

//背景颜色
#define kBackColor [UIColor colorWithRed:240 /255.0 green:239 /255.0 blue:244 /255.0 alpha:1.0]

//Page颜色
#define kPageCurrentColor [[UIColor colorWithRed:255.0 /255.0 green:158.0 /255.0 blue:4.0 /255.0 alpha:1.0]CGColor]

// 颜色改变
#define App_Color 10

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


//#define APP_PAGE_COLOR                  RGBACOLOR(243.0,244.0,245.0,1.0)
#define APP_PAGE_COLOR                  UIColorFromRGB(0xEFEFF4)
#define APP_LINE_COLOR                  UIColorFromRGB(0xC8C7CC)
#define APP_Button_COLOR                RGBACOLOR(243.0,157.0,58.0,1.0)

#define APP_THEME_COLOR_NORMAL          UIColorFromRGB(0xF4F4F4)
#define APP_THEME_COLOR                 UIColorFromRGB(0xFF4C4C)
#define APP_THEME_COLOR_HIGHLIGHT       UIColorFromRGB(0xC94141)
#define COLOR_TEXT_I                    SIMULATORIColorFromRGB(0x323232)
///////////////////////////////

#define kPaddingLeftWidth               36

//////////////////////////////
//字体
#define kFontWithSize(Size) [UIFont systemFontOfSize:Size]
#define kBoldFontWithSize(Size) [UIFont boldSystemFontOfSize:Size]
/////////////////////////////


#endif /* UIHeader_h */
