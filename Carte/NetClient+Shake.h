//
//  NetClient+Shake.h
//  Carte
//
//  Created by CJK on 13-4-3.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "NetClient.h"
#import <CoreLocation/CoreLocation.h>
#import "Card.h"

@interface NetClient (Shake)
- (void)doShake:(Card *)card coordinate:(CLLocationCoordinate2D)coordinate success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure;
@end
