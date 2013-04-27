//
//  NetClient+Account.m
//  Carte
//
//  Created by CJK on 13-3-25.
//  Copyright (c) 2013年 cjk. All rights reserved.
//
#import "NetClient+ToPaths.h"
#import "NetClient+Account.h"
#import "KHHUser.h"
#import "Card.h"
#import "CardTemplateDetail.h"


@implementation NetClient (Account)

- (void)doRegister:(NSDictionary *)parameters success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure
{
    [self doInselfPath:@"post" methodPath:@"account/register" parameters:parameters success:^(NSMutableDictionary *responseDict) {
        if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:0]]) {
            [KHHUser shareInstance].userId = [NSString stringWithFormat:@"%@",responseDict[@"id"]];
            if (success) {
                success(responseDict);
                return;
            }
            
        }
    } failure:^(NSMutableDictionary *responseDict) {
        if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:-2]]) {
            responseDict[@"note"] = @"帐号已存在";
           
        }
        if (failure) {
            failure(responseDict);
        }
    }];
}


- (void)doLogin:(NSDictionary *)parameters success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure
{
    [self doInselfPath:@"post" methodPath:@"account/login" parameters:parameters success:^(NSMutableDictionary *responseDict) {
        if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:0]]) {
            [KHHUser shareInstance].userId = [NSString stringWithFormat:@"%@",responseDict[@"id"]];
            [KHHUser shareInstance].sessionId = [NSString stringWithFormat:@"%@",responseDict[@"sessionId"]];
            [[KHHData sharedData] cleanContext];
            
            if (success) {
                success(responseDict);
                return;
            }
            
        }
    } failure:^(NSMutableDictionary *responseDict) {
        if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:-3]]) {
            responseDict[@"note"] = @"帐号不存在";            
        }
        if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:-4]]) {
            responseDict[@"note"] = @"密码错误";
        }
        if (failure) {
            failure(responseDict);
        }
    }];
}

- (void)doFindPwd:(NSDictionary *)parameters success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure
{
    [self doInselfPath:@"put" methodPath:@"account/forgetPwd" parameters:parameters success:^(NSMutableDictionary *responseDict) {
        if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:0]]) {            
            if (success) {
                success(responseDict);
                return;
            }            
        }
    } failure:^(NSMutableDictionary *responseDict) {
        if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:-1]]) {
            responseDict[@"note"] = @"帐号没注册";
        }
        if (failure) {
            failure(responseDict);
        }
    }];

}

- (void)doGetMyCard:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure
{
   
    [self doInselfPath:@"get" methodPath:@"mobile/card" parameters:nil success:^(NSMutableDictionary *responseDict) {
        if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:0]]) {
            NSMutableDictionary *responseDict1 = responseDict;
            void(^success2)(NSMutableDictionary *responseDict) = ^(NSMutableDictionary *responseDict){
                
                [Card saveFromJsonMyCard:responseDict1[@"content"][0]];
                if (success) {
                    success(responseDict);                    
                }
            };
            
            if (![CardTemplate objectByID:responseDict[@"content"][0][@"template"][@"id"] createIfNone:NO] ) {
                
                [self doSyncTemplateById:responseDict[@"content"][0][@"template"][@"id"] success:success2 failure:failure];
                return;
            }
            success2(responseDict);
                       
        }
    } failure:^(NSMutableDictionary *responseDict) {
        if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:-1]]) {
            responseDict[@"note"] = @"服务器忙，请稍后再试";
        }
        if (failure) {
            failure(responseDict);
        }
    }];
}

- (void)doSyncTemplateById:(NSNumber *)templateId success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure
{
    
    [self doInselfPath:@"get" methodPath:[NSString stringWithFormat:@"mobile/template/%@",templateId] parameters:nil success:^(NSMutableDictionary *responseDict) {
        if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:0]]) {
           CardTemplate *cardTemp = [CardTemplate saveFromJson:responseDict[@"content"][0]];
            if (!cardTemp.detail&&![responseDict[@"content"][0][@"templateDetailGroup"] isEqual:@""]) {
                [self doInselfPath:@"get" methodPath:[NSString stringWithFormat:@"mobile/tdgroup/%@",responseDict[@"content"][0][@"templateDetailGroup"][@"id"]] parameters:nil success:^(NSMutableDictionary *responseDict2) {
                    cardTemp.detail = [CardTemplateDetail saveFromJson:responseDict2[@"content"][0]];
                    [[KHHData sharedData]saveContext];
                    if (success) {
                        success(responseDict);
                    }
                } failure:failure];                
                return;
            }
            [[KHHData sharedData]saveContext];
            if (success) {
                success(responseDict);
            }
            return;
        }
        if (failure) {
            failure(responseDict);
        }
        
    } failure:^(NSMutableDictionary *responseDict) {
        if (failure) {
            failure(responseDict);
        }
    }];
}

@end
