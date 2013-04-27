//
//  NetClient+SyncAll.m
//  Carte
//
//  Created by CJK on 13-4-10.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "NetClient+SyncAll.h"
#import "NetClient+ToPaths.h"
#import "Group.h"
#import "SyncMark.h"
#import "CardTemplateDetail.h"
#import "CardTemplate.h"
#import "Card.h"
#import "NetClient+Account.h"

@implementation NetClient (SyncAll)
- (void)doSyncAllTemplate:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure
{
    NSString *methodPath;
    if (![SyncMark valueByKey:@"SyncMarkTimeTemp"]) {
        methodPath = @"mobile/template/sync";
    }else{
        methodPath = [NSString stringWithFormat:@"mobile/template/sync/%@",[SyncMark valueByKey:@"SyncMarkTimeTemp"]];
    }    
    [self doInselfPath:@"get" methodPath:methodPath parameters:nil success:^(NSMutableDictionary *responseDict) {
        if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:0]]) {
            [SyncMark UpdateKey:@"SyncMarkTimeTemp" value:[NSString stringWithFormat:@"%@",responseDict[@"sysTime"]]];
            for (NSDictionary *dicPro in responseDict[@"content"]) {
                [CardTemplate saveFromJson:dicPro];
            }
            [[KHHData sharedData]saveContext];
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

- (void)doSyncAllTemplateDetail:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure
{
    NSString *methodPath;
    if (![SyncMark valueByKey:@"SyncMarkTimeTempDetail"]) {
        methodPath = @"mobile/tdgroup/sync";
    }else{
        methodPath = [NSString stringWithFormat:@"mobile/tdgroup/sync/%@",[SyncMark valueByKey:@"SyncMarkTimeTempDetail"]];
    }
    
    [self doInselfPath:@"get" methodPath:methodPath parameters:nil success:^(NSMutableDictionary *responseDict) {
        if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:0]]) {
            [SyncMark UpdateKey:@"SyncMarkTimeTempDetail" value:[NSString stringWithFormat:@"%@",responseDict[@"sysTime"]]];            
            for (NSDictionary *dicPro in responseDict[@"content"]) {
                [CardTemplateDetail saveFromJson:dicPro];               
            }
            [[KHHData sharedData]saveContext];
            
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

- (void)doSyncAllCard:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure
{
    NSString *methodPath;
    if (![SyncMark valueByKey:@"SyncMarkTimeCard"]) {
        methodPath = @"mobile/contact/y/50";
    }else{
        methodPath = [NSString stringWithFormat:@"mobile/contact/y/50/%@/%@",[SyncMark valueByKey:@"SyncMarkCardId"],[SyncMark valueByKey:@"SyncMarkTimeCard"]];
    }
    
    [self doInselfPath:@"get" methodPath:methodPath parameters:nil success:^(NSMutableDictionary *responseDict) {
        if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:0]]) {
            [SyncMark UpdateKey:@"SyncMarkTimeCard" value:[NSString stringWithFormat:@"%@",responseDict[@"sysTime"]]];
            if (responseDict[@"lastId"]&&![responseDict[@"lastId"] isEqual:@""]) {
                [SyncMark UpdateKey:@"SyncMarkCardId" value:[NSString stringWithFormat:@"%@",responseDict[@"lastId"]]];
            }
            for (NSDictionary *dicPro in responseDict[@"content"]) {
                Card *cardPro = [Card saveFromJson:dicPro];
                if (!cardPro.cardTemplate) {
                    [self doSyncTemplateById:dicPro[@"sendCard"][@"template"][@"id"] success:nil failure:nil];
                }
            }
            [[KHHData sharedData]saveContext];
            if ([responseDict[@"count"] integerValue]<50) {
                if (success) {
                    success(responseDict);
                    return;
                }
            }else{
                [self doSyncAllCard:success failure:failure];
            }
            
        
        }
    } failure:^(NSMutableDictionary *responseDict) {
        if (failure) {
            failure(responseDict);
        }
    }];
}

- (void)doSyncAllGroup:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure
{
    [self doInselfPath:@"get" methodPath:@"mobile/group/list" parameters:nil success:^(NSMutableDictionary *responseDict) {
        if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:0]]) {
            [Group clearType2];
            [Group saveFromJson:responseDict[@"content"]];
            [[KHHData sharedData] saveContext];
            if (success) {
                success(responseDict);
            }
        }
    } failure:^(NSMutableDictionary *responseDict) {
        if (failure) {
            failure(responseDict);
        }
    }];
}

@end
