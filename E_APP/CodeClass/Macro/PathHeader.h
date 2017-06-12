//
//  PathHeader.h
//  Faith in life
//
//  Created by allan on 16/7/21.
//  Copyright © 2016年 Xinnuo. All rights reserved.
//

#ifndef PathHeader_h
#define PathHeader_h

#define UserPhoto [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"selfPhoto.jpg"]

#define startOpened [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"firstOpenFile"]


#endif /* PathHeader_h */
