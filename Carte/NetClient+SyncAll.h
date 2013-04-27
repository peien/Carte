//
//  NetClient+SyncAll.h
//  Carte
//
//  Created by CJK on 13-4-10.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "NetClient.h"

@interface NetClient (SyncAll)
- (void)doSyncAllTemplate:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure;
- (void)doSyncAllTemplateDetail:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure;
- (void)doSyncAllCard:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure;
- (void)doSyncAllGroup:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure;
@end
