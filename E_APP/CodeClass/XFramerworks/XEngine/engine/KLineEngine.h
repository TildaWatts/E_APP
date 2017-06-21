//
//  KLineEngine.h
//  E_APP
//
//  Created by Ezra on 2017/6/21.
//  Copyright © 2017年 Ezra. All rights reserved.
//

#import "XEngine.h"


@interface KLineEngine : XEngine

+(KLineEngine *) shareInstance;
- (void)kLineWithCurrency:(NSString *)currency type:(NSString *)type since:(id)since size:(int)size;

@end
