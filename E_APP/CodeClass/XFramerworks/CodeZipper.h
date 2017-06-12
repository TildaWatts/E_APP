//
//  CodeZipper.h
//  QQMSFContact
//
//  Created by Vincent on 21/8/15.
//
//


#ifdef __cplusplus
extern "C" {
#endif
    
    NSTimeInterval CZ_getCurrentLocalTime();
    
    NSString* CZ_GetLocalizedStr(NSString* str);
    NSString *CZ_NSString_stringWithFormat(NSString *format, ...);
	BOOL CZ_IsEmptyString(NSString *const string);
    BOOL CZ_StringEqualToString(NSString *const string1, NSString *const string2);
	NSString *CZ_NewUTF8StringWithData(NSData *data);

    
#ifdef __cplusplus
}
#endif






