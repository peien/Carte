//
//  NetClient+Template.h
//  Carte
//
//  Created by CJK on 13-4-3.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "NetClient.h"

@interface NetClient (Template)
- (void)doSyncTemplate:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure;
@end
