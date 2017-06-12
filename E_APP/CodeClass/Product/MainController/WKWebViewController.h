//
//  WKWebViewController.h
//  Faith in life
//
//  Created by 王聪 on 16/4/27.
//  Copyright © 2016年 allan. All rights reserved.
//

//#import "SuperViewController.h"

@interface WKWebViewController : UIViewController

/** 链接 */
@property (nonatomic, copy) NSString *url;

//是否隐藏工具栏
@property (nonatomic, assign) BOOL showToolBar;

// 是否不适用H5 Title
@property (nonatomic, assign) BOOL isNotUseHtmlTitle;

// 是否在其他H5页面打开Link
@property (nonatomic, assign) BOOL jumpToOtherWebView;


//H5 顶部自定义View
@property (nonatomic, strong) UIView *wkHeaderView;
//H5 底部自定义View
@property (nonatomic, strong) UIView *wkFooterView;


- (instancetype)initWithUrlStr:(NSString *)urlStr;

-(void) hideToolBar:(BOOL) isShowToolbar;

- (void)sms:(NSMutableDictionary *)query;

@end
