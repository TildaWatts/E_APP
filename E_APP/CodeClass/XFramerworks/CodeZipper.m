
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wbuiltin-macro-redefined"
#define __FILE__ "CodeZipper"
#pragma clang diagnostic pop

//
//  CodeZipper.m
//  QQMSFContact
//
//  Created by Vincent on 21/8/15.
//
//

NSTimeInterval CZ_getCurrentLocalTime()
{
    return [[NSDate date] timeIntervalSince1970];
}

NSString* CZ_GetLocalizedStr(NSString* str)
{
    return [[NSBundle mainBundle] localizedStringForKey:str value:@"" table:nil];
}

BOOL CZ_StringEqualToString(NSString *const string1, NSString *const string2) {
    return [string1 isEqualToString:string2];
}

BOOL CZ_IsEmptyString(NSString *const string)
{
    if( string == nil)
        return YES;
    return CZ_StringEqualToString(string, @"");
}



NSString *CZ_NSString_stringWithFormat(NSString *format, ...)
{
    va_list args;
    va_start(args, format);
    NSString *ret = [[NSString alloc] initWithFormat:format arguments:args] ;
    va_end(args);
    return ret;
}

NSString *CZ_NewUTF8StringWithData(NSData *data)
{
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}




