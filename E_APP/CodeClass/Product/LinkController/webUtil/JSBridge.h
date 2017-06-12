//
//  JSBridge.h
//  Faith in life
//
//  Created by alexanxiong on 16/9/22.
//  Copyright © 2016年 Xinnuo. All rights reserved.
//

#ifndef JSBridge_h
#define JSBridge_h

#import <WebKit/WKWebView.h>
#import <UIKit/UIKit.h>
#import "SuperViewController.h"
#import "EventListener.h"
#import "XUri.h"

/**
 *  接口列表:
 *  report
 *  setWebView
 *
 */
#define JSB_REPORT       @"report"
#define JSB_SETWEBVIEW   @"setWebView"
#define JSB_CLOSEWEBVIEW @"closeWebView"
#define JSB_CURL         @"curl"

@interface JSBridge : NSObject<EventListener>

@property (nonatomic,strong) UIWebView*  web;
@property (nonatomic,strong) WKWebView*  wk;
@property (nonatomic,strong) SuperViewController *view;

-(void) attach:(UIWebView*)  web wk:(WKWebView*) wk view: (UIViewController *)  view;
-(void) deattach;
-(void) onReady ;


-(int) handlerJSB :(XUri*) uri ;
-(void)excuteJS:(NSString*)   js_str;


@end

#endif /* JSBridge_h */
