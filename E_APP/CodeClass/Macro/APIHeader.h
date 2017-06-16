//
//  APIHeader.h
//  Faith in life
//
//  Created by allan on 16/3/15.
//  Copyright © 2016年 allan. All rights reserved.
//

#ifndef APIHeader_h
#define APIHeader_h

//#define DEBUG_SERVER

#ifdef DEBUG_SERVER
#define Usuite  @"http://192.168.1.11/app/x1"
#define Usuites @"https://192.168.1.11/app/x1"
#else
//#define Usuite  @"http://appmgr.jwoquxoc.com/frontApi/getAboutUs"
//#define Usuites  @"http://appmgr.jwoquxoc.com/frontApi/getAboutUs"
#define Usuite  @"http://api.jisuapi.com/zidian/word"
#define Usuites  @"http://api.jisuapi.com/zidian/word"
#define SocketUsuites @"wss://api.chbtc.com:9999/websocket"


#endif

//外网上传统一使用如下API
#define Upload  @"http://app.xinnuo.info/app/upload"
#define UsuiteUpload  @"http://app.xinnuo.info/app/upload2"

#define GetUploadImage @"http://app.xindun.org/appv2/getImg"


//刷脸公安比对网址

#define STFaceDetectiveUrl @"http://api.cloud.linkface.cn/identity/selfie_idnumber_verification"
#define STFaceDetectiveUrl1 @"http://api.cloud.linkface.cn/identity/historical_selfie_verification"

#endif
