//
//  NetClient+Card.h
//  Carte
//
//  Created by CJK on 13-3-29.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "NetClient.h"
#import "Card+NetParam.h"

@interface NetClient (Card)
- (void)doUpCreateCard:(Card *)card success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure;

- (void)doUpCreateCard:(Card *)card dicDetail:(NSDictionary *)dicDetail success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure arrImageDic:(NSArray *)arrImageDic;

- (void)doDelete:(Card *)card success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure;

- (void)doMoveCard:(NSString *)type cardIds:(NSString *)cardIds groupId:(NSString *)groupId success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure;


- (void)doSyncCard:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure;
- (void)doSyncCardById:(NSNumber *)cardId success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure;
- (void)doSyncCardById:(NSNumber *)cardId success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure isContact:(Boolean)isContact;


@end
