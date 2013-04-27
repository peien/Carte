//
//  KHHCardImageFullLanc.m
//  Carte
//
//  Created by CJK on 13-3-14.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHCardImageFullLanc.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"
#import "CardTemplateDetail.h"

@implementation KHHCardImageFullLanc
{
    CGPoint _oldPos;
    CGPoint _newPos;
    CGPoint goUpPos;
    
    CATransform3D combinedTransform;

    //for grogress
    Boolean _isAniming,_isFull;
    
    //for move
    NSTimeInterval begin;
    NSTimeInterval end;
    
    CGPoint locationBegin;
    CGPoint locationEnd;
}

- (void)setCard:(Card *)card
{
    _card = card;
    _inputTemplate = card.cardTemplate;
    _inputTemplateDetail = _inputTemplate.detail;
}

- (void)setInputTemplate:(CardTemplate *)inputTemplate
{   
     _inputTemplate = inputTemplate;
    
     _inputTemplateDetail = _inputTemplate.detail;
}

- (void)setInputTemplateDetail:(CardTemplateDetail *)inputTemplateDetail
{
    _inputTemplateDetail = inputTemplateDetail;
}

- (void)setCgimage:(CGImageRef)cgimage
{
    _cgimage = cgimage;
   
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isHomeLeft = YES;
        CALayer *l = self.layer;
        [l setMasksToBounds:YES];
        [l setCornerRadius:16.0];
    }
    return self;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[touches allObjects] objectAtIndex:0];
    begin = touch.timestamp;
    locationBegin = [touch locationInView:self.superview];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_touchAction) {
        _touchAction();
        return;
    }
    if (_toGoFull) {
        if (_animing) {
            return;
        }
        if (_isFull) {
            [self fromFull];
            return;
        }
        if (!_isFull) {
            [self goFull];
        }
        return;
    }
    
    
    UITouch *touch = [[touches allObjects] objectAtIndex:0];
    locationEnd = [touch locationInView:self.superview];
    end = touch.timestamp;
    if (end-begin<1.0&&locationEnd.y-locationBegin.y<-20) {
        if (_isResponChange&&!_isResponChangeSave) {
            if (_shoudGetLocationAndGoUp) {
                _shoudGetLocationAndGoUp();
                return;
            }
            [self goUp];
            return;
        }
    }
    
    if (end-begin<1.0&&locationEnd.x-locationBegin.x>20) {
        if (_isResponChange&&_isResponChangeSave) {
            if (_shoudReloadContact) {
                _shoudReloadContact();
            }
            [self goRight];
            return;
        }
    }
    
    
}

- (void)setIsHomeLeft:(Boolean)isHomeLeft
{
    _isHomeLeft = isHomeLeft;
    [self setNeedsDisplay];
}

- (void)goUp
{
    if(_animing||_toFull)return;
    
    
    goUpPos = CGPointMake(_oldPos.x, _rectUp.size.height/2.0+_rectUp.origin.y-_rectInTab0.origin.y-_rectInTab0.size.height/2.0+_oldPos.y );
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"position"];
    animation2.removedOnCompletion = NO;
    animation2.duration=0.5;
	animation2.fillMode=kCAFillModeForwards;
    animation2.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation2.delegate = self;
    
    animation2.fromValue = [NSValue valueWithCGPoint:_oldPos];
    animation2.toValue = [NSValue valueWithCGPoint:goUpPos];
    [self.layer addAnimation:animation2 forKey:@"AnimGoUp"];
    
   
}

- (void)goDown
{
    
    //    _oldPos = self.layer.position;
    //    goUpPos = CGPointMake(_oldPos.x, _rectUp.size.height/2.0+_rectUp.origin.y-_rectInTab0.origin.y-_rectInTab0.size.height/2.0+_oldPos.y );
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"position"];
    animation2.removedOnCompletion = NO;
    animation2.duration=0.5;
	animation2.fillMode=kCAFillModeForwards;
    animation2.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation2.delegate = self;
    
    animation2.fromValue = [NSValue valueWithCGPoint:goUpPos];
    animation2.toValue = [NSValue valueWithCGPoint:_oldPos];
    [self.layer addAnimation:animation2 forKey:@"AnimGoDown"];
    
    
}

- (void)goRight
{
    CGPoint rightPos = CGPointMake(_rectRight.origin.x+_rectRight.size.width/2,_oldPos.y );
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"position"];
    animation2.removedOnCompletion = NO;
    animation2.duration=0.5;
	animation2.fillMode=kCAFillModeForwards;
    animation2.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation2.delegate = self;
    
    animation2.fromValue = [NSValue valueWithCGPoint:_oldPos];
    animation2.toValue = [NSValue valueWithCGPoint:rightPos];
    [self.layer addAnimation:animation2 forKey:@"AnimGoRight"];
}


- (void)goFull
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
  //  CATransform3D rotateTransform = CATransform3DMakeRotation(M_PI/2, 0, 0, -1);
    
    [anim setFromValue:[NSValue valueWithCATransform3D:combinedTransform]]; //放在3D坐标系中最正的位置
   // CATransform3D combinedTransform1 = CATransform3DConcat(combinedTransform, rotateTransform);
    [anim setToValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]];
    [anim setDuration:0.5f];
    anim.fillMode=kCAFillModeForwards;
    anim.delegate = self;
    [self.layer addAnimation:anim forKey:@"goFull"];
    _isFull = YES;
    self.layer.transform = CATransform3DIdentity;
}

- (void)fromFull
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    //  CATransform3D rotateTransform = CATransform3DMakeRotation(M_PI/2, 0, 0, -1);
    
    [anim setFromValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]]; //放在3D坐标系中最正的位置
    // CATransform3D combinedTransform1 = CATransform3DConcat(combinedTransform, rotateTransform);
    [anim setToValue:[NSValue valueWithCATransform3D:combinedTransform]];
    [anim setDuration:0.5f];
    anim.fillMode=kCAFillModeForwards;
    anim.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.delegate = self;
    
    [self.layer addAnimation:anim forKey:@"fromFull"];
    _isFull = NO;
    self.layer.transform = combinedTransform;
}

- (void)animationDidStart:(CAAnimation *)anim
{
    _animing = YES;
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    _animing = NO;
    if (flag) {
        
        if (anim == [self.layer animationForKey:@"goFull"]) {
            _isFull = YES;
            return;
        }
        if (anim == [self.layer animationForKey:@"fromFull"]) {
            _isFull = NO;
            return;
        }
        if (anim == [self.layer animationForKey:@"AnimGoUp"]) {
            if (_upFinish) {
                _upFinish();
            }
            return;
        }
        
    }
    
}

- (void)transform
{
    [self transform:NO];
}

- (void)transform:(Boolean)animation
{
    if (_oldPos.x == 0) {
        _oldPos = CGPointMake(self.frame.size.width/2.0+self.frame.origin.x, self.frame.size.height/2.0+self.frame.origin.y);
    }
    
    if (_rectFrom.origin.x == 0) {
        _rectFrom = CGRectMake(20, 20, 280, 168);
    }   
    
    _newPos = CGPointMake(_rectFrom.size.width/2.0+_rectFrom.origin.x, _rectFrom.size.height/2.0+_rectFrom.origin.y);
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D rotateTransform = CATransform3DMakeRotation(M_PI/2, 0, 0, -1);
 //   280/(460+88-44-50) 180/320
    CATransform3D scaleTransform = CATransform3DMakeScale(_rectFrom.size.width/(float)(320.0*5.0/3.0), _rectFrom.size.height/320.0, 1);
    CATransform3D positionTransform = CATransform3DMakeTranslation(_newPos.x-_oldPos.x, _newPos.y-_oldPos.y, 0); //位置移动
 //   positionTransform.m34 = 1.0;
   
     combinedTransform = CATransform3DConcat(rotateTransform, scaleTransform); //Concat就是combine的意思
    combinedTransform = CATransform3DConcat(combinedTransform, positionTransform);
    
    // CATransform3D transform = CATransform3DIdentity;
   
    [anim setFromValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]]; //放在3D坐标系中最正的位置
    [anim setToValue:[NSValue valueWithCATransform3D:combinedTransform]];
    [anim setDuration:1.0f];
    if (animation) {
        [self.layer addAnimation:anim forKey:nil];
    }   
    self.layer.transform = combinedTransform;
    //self.layer.sublayerTransform = transform;
//    CABasicAnimation *zAnimtrans = [CABasicAnimation animationWithKeyPath:@"transform"];
//    zAnimtrans.duration = 1.0;
//    zAnimtrans.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    zAnimtrans.fillMode=kCAFillModeForwards;
//            zAnimtrans.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//            zAnimtrans.toValue = [NSValue valueWithCATransform3D:positionTransform];
//    [self.layer addAnimation:zAnimtrans forKey:@"zAnimtrans"];
//    CGAffineTransform rotationTransform = CGAffineTransformMakeRotation(-1 * M_PI / 2);
//    self.transform = rotationTransform;
}

- (void)drawRect:(CGRect)rect
{
   
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, 0.0, rect.size.height);
    CGContextScaleCTM(ctx, 1.0, -1.0);
    CGContextScaleCTM(ctx, rect.size.width/rect.size.height, rect.size.height/rect.size.width);
    
    if (_isHomeLeft) {
        CGContextTranslateCTM (ctx, 0, rect.size.width);
    }else{
        CGContextTranslateCTM (ctx, rect.size.height, 0);
    }
    
    CGContextRotateCTM (ctx, _isHomeLeft?degreesToRadians(-90.):degreesToRadians(90.));
     [[UIColor clearColor]setFill];
    //CGContextDrawImage(ctx, rect ,_cgimage);
   
//    UIGraphicsPushContext(ctx);
//    UIGraphicsPopContext();
//    ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, 0.0, rect.size.height);
    CGContextScaleCTM(ctx, 1.0, -1.0);
    CGContextScaleCTM(ctx, rect.size.width/rect.size.height, rect.size.height/rect.size.width);
    [[UIColor orangeColor]setFill];
    NSArray *arr1Pro = [[NSArray alloc]initWithObjects:[self ifNil:_card.name],[self ifNil:_card.job ],[self ifNil:_card.company],[NSString stringWithFormat:@"Mobile:%@",[self ifNil:_card.mobile0]],[NSString stringWithFormat:@"tele:%@",[self ifNil:_card.tele0]],[NSString stringWithFormat:@"%@ %@ %@",[self ifNil:_card.address.province],[self ifNil:_card.address.city],[self ifNil:_card.address.detailStreet]],[self ifNil:_card.qq],[self ifNil:_card.web], nil];
    NSDictionary *dicPro = _inputTemplateDetail.dicStyles;
    NSArray *arr2Pro = [[NSArray alloc]initWithObjects:dicPro[@"name"],dicPro[@"title"],dicPro[@"company"],dicPro[@"mobile"],dicPro[@"telephone"],dicPro[@"address"],dicPro[@"qq"],dicPro[@"web"],nil];
    
    for (int i=0; i< [arr2Pro count]; i++) {
        TemplateItemStyle *stylePro = arr2Pro[i];
        [[UIColor orangeColor] setFill]; //[[UIColor colorWithCIColor:stylePro.color] setFill];
        if ([stylePro.fontName isEqualToString:@"bold"]) {
            CGPoint pointPro = CGPointMake(((float)stylePro.leftValue/0.9)*(rect.size.width/280.0), ((float)stylePro.topValue/3.2)*(rect.size.height/168.0));
            [arr1Pro[i] drawAtPoint:pointPro withFont:[UIFont systemFontOfSize:((float)stylePro.fontSizeValue/1.8)*(rect.size.height/168.0)]];
        }
    }
       
    UIGraphicsPushContext(ctx);
   
}

- (NSString *)ifNil:(NSString *)str
{
    if (!str) {
        return @"";
    }
    return str;
}


@end
