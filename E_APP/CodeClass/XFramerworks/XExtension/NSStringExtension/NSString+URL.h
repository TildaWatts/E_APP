//
//  NSString+Code.h
//  Faith in life
//
//  Created by 王聪 on 16/4/19.
//  Copyright © 2016年 allan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URL)

//URLEncode
+(NSString*)encodeString:(NSString*)unencodedString;

//URLDEcode
+(NSString *)decodeString:(NSString*)encodedString;

@end
