//
//  NetClient+Group.m
//  Carte
//
//  Created by CJK on 13-3-27.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "NetClient+Group.h"
#import "NetClient+ToPaths.h"
#import "Group.h"

@implementation NetClient (Group)

- (void)doModifyGroup:(NSDictionary *)parameters success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure
{
    [self doInselfPath:@"post" methodPath:@"mobile/group/update" parameters:parameters success:^(NSMutableDictionary *responseDict) {
        if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:0]]) {
            [self doSyncGroup:success failure:failure];
        }
    } failure:^(NSMutableDictionary *responseDict) {
        if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:-5]]) {
            responseDict[@"note"] = @"分组名已存在";
        }
        if (failure) {
            failure(responseDict);
        }
    }];
}

- (void)doAddGroup:(NSDictionary *)parameters success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure
{
    [self doInselfPath:@"post" methodPath:@"mobile/group" parameters:parameters success:^(NSMutableDictionary *responseDict) {
        if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:0]]) {            
            [self doSyncGroup:success failure:failure];
        }
    } failure:^(NSMutableDictionary *responseDict) {
        if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:-5]]) {
            responseDict[@"note"] = @"分组名已存在";            
        }
        if (failure) {
            failure(responseDict);
        }
    }];
}

- (void)doDeleteGroup:(NSString *)groupId success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure
{
    [self doInselfPath:@"delete" methodPath:[NSString stringWithFormat:@"mobile/group/%@",groupId] parameters:nil success:^(NSMutableDictionary *responseDict) {
        if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:0]]) {
            [self doSyncGroup:success failure:failure];
        }
    } failure:^(NSMutableDictionary *responseDict) {
        
        if (failure) {
            failure(responseDict);
        }
    }];
}

- (void)doSyncGroup:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure
{
    [self doInselfPath:@"get" methodPath:@"mobile/group/list" parameters:nil success:^(NSMutableDictionary *responseDict) {
        if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:0]]) {
            [Group clearType2];
            [Group saveFromJson:responseDict[@"content"]];
            [self doSycnGroupCard:success failure:failure];            
        }
    } failure:^(NSMutableDictionary *responseDict) {        
        if (failure) {
            failure(responseDict);
        }
    }];
}


- (void)doSycnGroupCard:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure
{
    [self doInselfPath:@"get" methodPath:@"mobile/group/contact" parameters:nil success:^(NSMutableDictionary *responseDict) {
        if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:0]]) {
            [Group saveGroupCard:responseDict[@"cardGroupList"]];            
            if (success) {
                success(responseDict);
                return;
            }
        }
    } failure:^(NSMutableDictionary *responseDict) {
        if (failure) {
            failure(responseDict);
        }
    }];
}


@end
