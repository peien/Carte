//
//  KHHCardFullWithImageView.m
//  Carte
//
//  Created by CJK on 13-4-23.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHCardFullWithImageView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"

@implementation KHHCardFullWithImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CALayer *l = self.layer;
        [l setMasksToBounds:YES];
        [l setCornerRadius:6.0];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_touchAction) {
        _touchAction();
    }
}

- (void)setStrUrl:(NSString *)strUrl
{
    [self setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:[UIImage imageNamed:@"chenQE05.jpg"]];
    
}

- (void)setImage:(UIImage *)image
{
    NSLog(@"image");
    [super setImage:[self addText:image text:@"tele"]];    
}

-(UIImage *)addText:(UIImage *)img text:(NSString *)someText{
	int w = self.frame.size.width*2;
	int h = self.frame.size.height*2;
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGContextTranslateCTM(context, 0.0, h);
    CGContextScaleCTM(context, 1.0, -1.0);
    UIGraphicsPushContext(context);	
	CGContextSetTextDrawingMode(context, kCGTextFill);
    
    NSArray *arr1Pro = [[NSArray alloc]initWithObjects:[self ifNil:_card.name],[self ifNil:_card.job ],[self ifNil:_card.company],[self mobile0],[self tele0],[self address],[self ifNil:_card.qq],[self ifNil:_card.web], nil];
    NSDictionary *dicPro = _detail.dicStyles;
    
    NSArray *arr2Pro = [[NSArray alloc]initWithObjects:dicPro[@"name"],dicPro[@"title"],dicPro[@"company"],dicPro[@"mobile"],dicPro[@"telephone"],dicPro[@"address"],dicPro[@"qq"],dicPro[@"web"],nil];

    for (int i=0; i< [arr2Pro count]; i++) {
        TemplateItemStyle *stylePro = arr2Pro[i];
        [[UIColor colorWithCIColor:stylePro.color] setFill];
        if ([stylePro.fontName isEqualToString:@"bold"]||[stylePro.fontName isEqualToString:@"normal"]) {
            CGPoint pointPro = CGPointMake(((float)stylePro.leftValue/2.0)*(w/280.0),((float)stylePro.topValue/2.0)*(h/168.0));
            [arr1Pro[i] drawAtPoint:pointPro withFont:[UIFont systemFontOfSize:((float)stylePro.fontSizeValue/1.7)*(h/168.0)]];
        }
    }
    
	CGImageRef imgCombined = CGBitmapContextCreateImage(context);
	
	CGContextRelease(context);
	CGColorSpaceRelease(colorSpace);
	
	UIImage *retImage = [UIImage imageWithCGImage:imgCombined];
	CGImageRelease(imgCombined);
	UIGraphicsPopContext();
	return retImage;
}

- (NSString *)mobile0
{
    if (_card.mobile0) {
        return [NSString stringWithFormat:@"手机:%@",[self ifNil:_card.mobile0]];
    }
    return @"";

}

- (NSString *)tele0
{
    if (_card.tele0) {
        return [NSString stringWithFormat:@"电话:%@",[self ifNil:_card.tele0]];
    }
    return @"";

}

- (NSString *)address
{
    return [NSString stringWithFormat:@"%@ %@ %@",[self ifNil:_card.address.province],[self ifNil:_card.address.city],[self ifNil:_card.address.detailStreet]];
}

- (NSString *)ifNil:(NSString *)str
{
    if (!str) {
        return @"";
    }
    return str;
}


@end
