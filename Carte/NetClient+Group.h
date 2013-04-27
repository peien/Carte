//
//  NetClient+Group.h
//  Carte
//
//  Created by CJK on 13-3-27.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "NetClient.h"

@interface NetClient (Group)
- (void)doAddGroup:(NSDictionary *)parameters success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure;
- (void)doDeleteGroup:(NSString *)groupId success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure;
- (void)doModifyGroup:(NSDictionary *)parameters success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure;
- (void)doSyncGroup:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure;

- (void)doSycnGroupCard:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure;
@end
