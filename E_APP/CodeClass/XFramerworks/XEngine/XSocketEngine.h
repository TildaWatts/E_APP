//
//  XSocketEngine.h
//  E_APP
//
//  Created by Ezra on 2017/6/16.
//  Copyright © 2017年 Ezra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSocketEngine : NSObject

@property (nonatomic, strong) NSString *message;
@property (nonatomic, assign) BOOL isConnect;


-(NSString *) doRequest:(NSString *)  request;



@end
