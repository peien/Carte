//
//  MyKeyChainHelper.h
//  KeyChainDemo
//
//  Created by 倪敏杰 on 12-7-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyKeyChainHelper : NSObject

+ (void) saveUserName:(NSString*)userName 
      userNameService:(NSString*)userNameService 
             psaaword:(NSString*)pwd 
      psaawordService:(NSString*)pwdService;

+ (void) deleteWithUserNameService:(NSString*)userNameService 
                   psaawordService:(NSString*)pwdService;

+ (NSString*) getUserNameWithService:(NSString*)userNameService;

+ (NSString*) getPasswordWithService:(NSString*)pwdService;

+ (void) saveSessionId:(NSString*)sessionId
      sessionIdService:(NSString*)sessionIdService;
+ (NSString*) getSessionIdWithService:(NSString*)sessionIdService;
+ (void) deleteWithSessionIdService:(NSString*)sessionIdService;


+ (void) saveUserName:(NSString*)userName
      userNameService:(NSString*)userNameService;
+ (void) savePsaaword:(NSString*)pwd
      psaawordService:(NSString*)pwdService;

@end
