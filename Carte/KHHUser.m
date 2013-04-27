//
//  KHHUser.m
//  Carte
//
//  Created by CJK on 13-3-13.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHUser.h"
#import "MyKeyChainHelper.h"

@implementation KHHUser

@synthesize userId = _userId;
@synthesize sessionId = _sessionId;
@synthesize username = _username;
@synthesize password = _password;
@synthesize agreeSync = _agreeSync;

NSString * const KEY_USERNAME = @"com.khh.carte.username";
NSString * const KEY_PASSWORD = @"com.khh.carte.password";
NSString * const KEY_SESSION = @"com.khh.carte.session";


- (NSString *)userId
{
    if (!_userId) {
        _userId = [[NSUserDefaults standardUserDefaults]valueForKey:@"kUserId"];
    }
    return _userId;
}

- (void)setUserId:(NSString *)userId
{
    if (![_userId isEqualToString:userId]) {
        [[NSUserDefaults standardUserDefaults] setValue:userId forKey:@"kUserId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        _userId = userId;
    }
}


- (NSString *)sessionId
{
    if (!_sessionId) {
        _sessionId = [[NSUserDefaults standardUserDefaults]valueForKey:@"kSessionId"];
        
    }
    return _sessionId;
}

- (void)setSessionId:(NSString *)sessionId
{
    if (![_sessionId isEqualToString:sessionId]) {
        
        [[NSUserDefaults standardUserDefaults] setValue:sessionId forKey:@"kSessionId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        _sessionId = sessionId;
    }
}

- (NSString *)username
{
    if (!_username) {
        _username = [[NSUserDefaults standardUserDefaults]valueForKey:@"kUsername"];
        
    }
    return _username;
}

- (void)setUsername:(NSString *)username
{
    if (![_username isEqualToString:username]) {
        [[NSUserDefaults standardUserDefaults] setValue:username forKey:@"kUsername"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        _username = username;
    }
}

- (NSString *)password
{
    if (!_password) {
        _password = [[NSUserDefaults standardUserDefaults]valueForKey:@"kPassword"];
        
    }
    return _password;
}

- (void)setPassword:(NSString *)password
{
    if (![_password isEqualToString:password]) {
        [[NSUserDefaults standardUserDefaults] setValue:password forKey:@"kPassword"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        _password = password;
    }
}
//
//- (void)setPassword:(NSString *)password
//{
//    [MyKeyChainHelper savePsaaword:password psaawordService:KEY_PASSWORD];
//    _password = [MyKeyChainHelper getPasswordWithService:KEY_PASSWORD];
//}
//
//- (NSString *)password
//{
//    if (!_password) {
//        _password = [MyKeyChainHelper getPasswordWithService:KEY_PASSWORD];
//    }
//    return _password;
//}

- (Boolean)agreeSync
{
    return [[NSUserDefaults standardUserDefaults]boolForKey:@"kAgreeSync"];    
}

- (void)setAgreeSync:(Boolean)agreeSync
{    
    [[NSUserDefaults standardUserDefaults] setBool:agreeSync forKey:@"kAgreeSync"];
    [[NSUserDefaults standardUserDefaults] synchronize];    
}

- (Card *)card
{
    if (!_card) {
        _card = [Card mycard];
    }
    return _card;
}

+ (KHHUser *)shareInstance
{
    static KHHUser *_shareInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _shareInstance = [[self alloc] init];
    });
    
    return _shareInstance;
}

@end
