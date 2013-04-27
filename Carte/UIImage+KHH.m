//
//  UIImage+KHH.m
//  CardBook
//
//  Created by Sun Ming on 12-10-12.
//  Copyright (c) 2012年 Kinghanhong. All rights reserved.
//

#import "UIImage+KHH.h"


@implementation UIImage (KHH)
+ (UIImage *)imageNamed:(NSString *)name capInsets:(UIEdgeInsets)insets {
    return [[UIImage imageNamed:name] resizableImageWithCapInsets:insets];
}
- (NSData *)resizedImageDataForKHHUpload {
    UIImage *resizedImage = [self resizedImageToFitInSize:CGSizeMake(640, 480) scaleIfSmaller:NO];
    NSData *imageData = UIImageJPEGRepresentation(resizedImage, 0.5);    
    return imageData;
}
@end
