//
//  XUri.h
//  Faith in life
//
//  Created by alexanxiong on 16/10/18.
//  Copyright © 2016年 Xinnuo. All rights reserved.
//

#ifndef XUri_h
#define XUri_h

@interface XUri : NSObject

+(XUri*) parseFromString:(NSString*) urlStr;

@property(nonatomic, copy) NSString *raw_str;

@property(nonatomic, copy) NSString *scheme;
@property(nonatomic, copy) NSString *host;

@property(nonatomic, strong) NSArray<NSString*>* paths;
@property(nonatomic, strong) NSMutableDictionary* querys;

@end

#endif /* XUri_h */
