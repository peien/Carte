//
//  NetClient+Shake.m
//  Carte
//
//  Created by CJK on 13-4-3.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "NetClient+Shake.h"
#import "NetClient+ToPaths.h"
#import "NetClient+Card.h"

@implementation NetClient (Shake)
- (void)doShake:(Card *)card coordinate:(CLLocationCoordinate2D)coordinate success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure
{
    NSMutableDictionary *dicParam = [[NSMutableDictionary alloc]initWithCapacity:5];
    dicParam[@"longitude"] = [NSNumber numberWithDouble:coordinate.longitude];
    dicParam[@"latitude"] = [NSNumber numberWithDouble:coordinate.latitude];
    dicParam[@"cardId"] = card.id;
    dicParam[@"invalidTime"] = [NSNumber numberWithInt:10000];
    [self doInselfPath:@"post" methodPath:@"mobile/card/shake" parameters:dicParam success:^(NSMutableDictionary *responseDict) {
        [self doSyncCardById:responseDict[@"sendCardId"] success:success failure:failure isContact:YES];
    } failure:^(NSMutableDictionary *responseDict) {
        if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:-14]]) {
            responseDict[@"note"] = @"没有经纬度值";
        }
        if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:-21]]) {
            responseDict[@"note"] = @"没有与其交换的名片";
        }
        if(failure){
            failure(responseDict);
        }
    }];
}
@end
