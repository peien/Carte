//
//  NetClient+ToPaths.h
//  Carte
//
//  Created by CJK on 13-3-25.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "NetClient.h"

@interface NetClient (ToPaths)

- (void)doInselfPath:(NSString *)method methodPath:(NSString *)methodPath parameters:(NSDictionary *)parameters success:(void (^)(NSMutableDictionary *))success failure:(void (^)(NSMutableDictionary *))failure;


- (void)doInselfPath:(NSString *)method methodPath:(NSString *)methodPath parameters:(NSDictionary *)parameters success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure arrImageDic:(NSArray *)arrImageDic multipart:(Boolean)multipart;

- (void)multipart:(NSString *)method methodPath:(NSString *)methodPath parameters:(NSDictionary *)parameters success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure;

- (void)multipart:(NSString *)method methodPath:(NSString *)methodPath parameters:(NSDictionary *)parameters success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure arrImageDic:(NSArray *)arrImageDic;
@end
