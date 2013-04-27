//
//  NetClient+Template.m
//  Carte
//
//  Created by CJK on 13-4-3.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "NetClient+Template.h"
#import "NetClient+ToPaths.h"
#import "SyncMark.h"
#import "CardTemplate.h"
#import "KHHData.h"
#import "NetClient+SyncAll.h"
@implementation NetClient (Template)
- (void)doSyncTemplate:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure
{
    NSString *methodPath;
    if (![SyncMark valueByKey:@"SyncMarkTimeTemplate"]) {
        methodPath = @"mobile/template/sync";
    }else{
        methodPath = [NSString stringWithFormat:@"mobile/template/sync/%@",[SyncMark valueByKey:@"SyncMarkTimeTemplate"]];
    }
    
    [self doSyncAllTemplateDetail:^(NSMutableDictionary *responseDict) {
        [self doInselfPath:@"get" methodPath:methodPath parameters:nil success:^(NSMutableDictionary *responseDict) {            
            if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:0]]) {
                [SyncMark UpdateKey:@"SyncMarkTimeTemplate" value:[NSString stringWithFormat:@"%@",responseDict[@"sysTime"]]];
                
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
    } failure:^(NSMutableDictionary *responseDict) {
        if (failure) {
            failure(responseDict);
        }
    }];
    

}
@end
