//
//  KHHImageUtil.h
//  Carte
//
//  Created by CJK on 13-4-23.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <mach/mach.h>
#import <mach/mach_host.h>

@interface KHHImageUtil : NSObject
+ (KHHImageUtil *)sharedUtil;
- (UIImage *)imageFromUrl:(NSURL *)url;
@end
