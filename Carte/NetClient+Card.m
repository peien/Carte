//
//  NetClient+Card.m
//  Carte
//
//  Created by CJK on 13-3-29.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "NetClient+Card.h"
#import "NetClient+ToPaths.h"
#import "SyncMark.h"
#import "NetClient+Account.h"
#import "NetClient+Group.h"

@implementation NetClient (Card)

- (void)doUpCreateCard:(Card *)card success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure
{
    [self doUpCreateCard:card dicDetail:nil success:success failure:failure arrImageDic:nil];
}

- (void)doUpCreateCard:(Card *)card dicDetail:(NSDictionary *)dicDetail success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure arrImageDic:(NSArray *)arrImageDic
{
    NSString *strMethod = @"post";
    NSString *strMethodPath = card.idValue!=0?@"mobile/card/update":@"mobile/card/private";
    NSMutableDictionary *dicParam = card.idValue!=0?[card netParam0ForEdit]:[card netParam1ForNew];
    if (dicDetail) {
        [dicParam removeObjectForKey:@"template.id"];
        dicParam[@"template.templateDetailGroup.id"] = dicDetail[@"detailId"];
    }
    [self multipart:strMethod methodPath:strMethodPath parameters:dicParam success:^(NSMutableDictionary *responseDict) {
        card.id = responseDict[@"id"];
        if(card.typeValue == type_card_my){
            [self doGetMyCard:success failure:failure];
            return;
        }            
        [self doSyncCardById:card.id success:success failure:failure];
    } failure:^(NSMutableDictionary *responseDict) {
        if (failure) {
            failure(responseDict);
        }
    } arrImageDic:arrImageDic];
}


- (void)doDelete:(Card *)card success:(void (^)(NSMutableDictionary *))success failure:(void (^)(NSMutableDictionary *))failure
{   
    [self doInselfPath:@"delete" methodPath:[NSString stringWithFormat:@"mobile/card/%@",card.id]  parameters:nil success:^(NSMutableDictionary *responseDict) {
        [self doSyncCardById:card.id success:success failure:failure];
    } failure:^(NSMutableDictionary *responseDict) {
        if (failure) {
            failure(responseDict);
        }
    }] ;
}

- (void)doMoveCard:(NSString *)type cardIds:(NSString *)cardIds groupId:(NSString *)groupId success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure
{
    NSString *methodPath = [NSString stringWithFormat:@"mobile/group/contact?type=%@",type];
    NSMutableDictionary *dicParam = [[NSMutableDictionary alloc]initWithCapacity:2];
    dicParam[@"groupId"] = groupId;
    dicParam[@"cardIds"] = cardIds;
    [self doInselfPath:@"post" methodPath:methodPath  parameters:dicParam success:^(NSMutableDictionary *responseDict) {
        [self doSyncGroup:success failure:failure];       
    } failure:^(NSMutableDictionary *responseDict) {
        if (failure) {
            failure(responseDict);
        }
    }] ;
}

- (void)doSyncCardById:(NSNumber *)cardId success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure
{
    [self doSyncCardById:cardId success:success failure:failure isContact:NO];
}

- (void)doSyncCardById:(NSNumber *)cardId success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure isContact:(Boolean)isContact
{
    NSString *methodPath;
    if (!isContact) {
        methodPath = [NSString stringWithFormat:@"mobile/card/%@",cardId];
    }else{
        methodPath = [NSString stringWithFormat:@"mobile/contact/card/%@",cardId];

    }
    [self doInselfPath:@"get" methodPath:methodPath parameters:nil success:^(NSMutableDictionary *responseDict) {
        if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:0]]) {            
            for (NSDictionary *dicPro in responseDict[@"content"]) {
                Card *cardPro = [Card saveFromJson:dicPro];
                if (!cardPro) {
                    if (success) {
                        success(responseDict);
                    }
                    return;
                }
                responseDict[@"card"] = cardPro;
                if (![CardTemplate objectByID:dicPro[@"template"][@"id"] createIfNone:NO]) {
                    [self doSyncTemplateById:dicPro[@"template"][@"id"] success:^(NSMutableDictionary *responseDict){
                        cardPro.cardTemplate = [CardTemplate objectByID:dicPro[@"template"][@"id"] createIfNone:NO];
                        [[KHHData sharedData]saveContext];
                        responseDict[@"card"] = cardPro;
                        if (success) {
                            success(responseDict);                            
                        }
                    } failure:failure];
                   
                    return;
                }
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

- (void)doSyncCard:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure
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
                    [self doSyncTemplateById:dicPro[@"template"][@"id"] success:nil failure:nil];
                }
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



@end
