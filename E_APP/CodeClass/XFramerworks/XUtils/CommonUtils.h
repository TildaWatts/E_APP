//
//  CommonUtils.h
//  Faith in life
//
//  Created by alexanxiong on 16/5/12.
//  Copyright © 2016年 alexanxiong. All rights reserved.
//

#ifndef CommonUtils_h
#define CommonUtils_h


@interface CommonUtils: NSObject

+ (int)         getUniqueID;
+ (NSString*)   int2NString:(int) i;
+(NSString*)    long2NString:(long) i;


+ (NSString*)   getString:(NSDictionary*) dic key:(NSString*) key;
+ (int)         getInt:(NSDictionary*) dic key:(NSString*) key;
+ (double)      getDouble:(NSDictionary*) dic key:(NSString*) key;
+ (BOOL)        getBool:(NSDictionary*) dic key:(NSString*) key;


+ (NSDictionary*) getDic:(NSDictionary*) dic key:(NSString*) key;
+ (NSArray *)     getArray:(NSDictionary *) dic key:(NSString *)key;

+(NSString *)     URLDecodedString:(NSString *)str ;
+(NSData*)        getChunkedData:(NSData*)     data;

@end

#endif /* CommonUtils_h */
