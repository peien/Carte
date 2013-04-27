//
//  KHHImageUtil.m
//  Carte
//
//  Created by CJK on 13-4-23.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHImageUtil.h"
#import "SDImageCache.h"
#import "SDWebImageDecoder.h"

@implementation KHHImageUtil
{
    NSString *_diskCachePath;
}
+ (KHHImageUtil *)sharedUtil
{
    static KHHImageUtil *_sharedImageUtil = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedImageUtil = [[KHHImageUtil alloc] init];
        
    });
    
    return _sharedImageUtil;
}

- (id)init
{
    return [self initWithNamespace:@"default"];
}

- (id)initWithNamespace:(NSString *)ns
{
    if ((self = [super init]))
    {
        NSString *fullNamespace = [@"com.hackemist.SDWebImageCache." stringByAppendingString:ns];       
        
        // Init the disk cache
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        _diskCachePath = [paths[0] stringByAppendingPathComponent:fullNamespace];
    }
    
    return self;
}


- (NSString *)cachePathForKey:(NSString *)key
{
    const char *str = [key UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return [_diskCachePath stringByAppendingPathComponent:filename];
}


- (UIImage *)imageFromUrl:(NSURL *)url
{
    NSString *key = [url absoluteString];
    return [UIImage decodedImageWithImage:SDScaledImageForPath(key, [NSData dataWithContentsOfFile:[self cachePathForKey:key]])];

}
@end
