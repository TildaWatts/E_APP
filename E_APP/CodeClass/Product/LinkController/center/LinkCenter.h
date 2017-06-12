//
//  LinkCenter.h
//  Faith in life
//
//  Created by Ezra on 16/11/9.
//  Copyright © 2016年 Xinnuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XUri.h"

@interface LinkCenter : NSObject

@property (nonatomic, assign,getter=isHideToolBar)BOOL hideToolBar;

+ (void)centerForJumpLink:(UIViewController *)vc action:(NSString *)url otherObj:(id)obj;

+ (void)center2Page:(UIViewController *)vc page:(NSString *) page otherObj:(id)obj;

+ (void)forward2Page:(UIViewController *)vc view:(UIViewController *) page ;

+ (void)forward2Page:(UIViewController *)vc class:(Class) page ;

/**
 判断二维码的合法性

 @param uri uri
 @param want_action 链接
 @return 正确性
 */
+ (BOOL)checkQrCodeWithUrlStr:(XUri*) uri  want_action:(XUri*) want_action;

// 构造绑定门店二维码扫描Action
+(NSString*) formBindStoreQRCode;

@end
