//
//  KHHHeadImageView.m
//  Carte
//
//  Created by CJK on 13-3-13.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHHeadImageView.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>

@implementation KHHHeadImageView


- (id)initWithUrl:(NSString *)urlStr
{
    self = [super initWithFrame:CGRectMake(3, 7, 50, 47)];
    if (self) {
        
        [self setUserInteractionEnabled:YES];
        KHHHeadImageView *weakSelf = self;
        [self setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"logopic.png"] options:SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            [weakSelf.layer setMasksToBounds:YES];
            [weakSelf.layer setCornerRadius:6.0];
        }];
        
        
    }
    return self;
}



- (void)setImage:(UIImage *)image
{
    [super setImage:image];
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:6.0];
}


@end
