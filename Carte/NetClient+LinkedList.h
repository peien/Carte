//
//  NetClient+LinkedList.h
//  Carte
//
//  Created by CJK on 13-4-10.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "NetClient.h"

@interface NetClient (LinkedList)
- (void)syncCardById:(NSNumber *)cardId success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure;

@end
