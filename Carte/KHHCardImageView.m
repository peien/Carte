//
//  KHHCardImageView.m
//  Carte
//
//  Created by CJK on 13-3-12.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHCardImageView.h"
#import <QuartzCore/QuartzCore.h>
#import "KHHUser.h"
#import "UIImageView+WebCache.h"

@implementation KHHCardImageView
{
    CGPoint _oldPos;
    CGPoint _newPos;
    CGPoint goUpPos;
    
    UIImageView *_imageViewForNet;
    
    
    //for move
    NSTimeInterval begin;
    NSTimeInterval end;
    
    CGPoint locationBegin;
    CGPoint locationEnd;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]){
        CALayer *l = self.layer;
        [l setMasksToBounds:YES];
        [l setCornerRadius:6.0];
        _rectInTab0 = self.frame;
        _imageViewForNet = [[UIImageView alloc]init];
    }
    return self;
}

- (void)setCard:(Card *)card
{
    _card = card;    
    _inputTemplate = _card.cardTemplate;
    _inputImage = _inputTemplate.image;
   
    KHHCardImageView *weakSelf = self;
    if (_inputTemplate.imageUrl) {
        [_imageViewForNet setImageWithURL:[NSURL URLWithString:_inputTemplate.imageUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            weakSelf.inputImage = image;
            [weakSelf setNeedsDisplay];
        }];
    }
    
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CALayer *l = self.layer;
        [l setMasksToBounds:YES];
        [l setCornerRadius:6.0];
        _rectInTab0 = frame;
        _imageViewForNet = [[UIImageView alloc]init];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[touches allObjects] objectAtIndex:0];
    begin = touch.timestamp;
    locationBegin = [touch locationInView:touch.view];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[touches allObjects] objectAtIndex:0];
    locationEnd = [touch locationInView:touch.view];
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
    
    if (_delegate && [_delegate respondsToSelector:@selector(touchInImg:)]) {
        [_delegate touchInImg:self];
    }
}

- (void)drawRect:(CGRect)rect
{
    
    if (_inputImage) {
        [_inputImage drawInRect:rect];
    }
    
    NSArray *arr1Pro = [[NSArray alloc]initWithObjects:[self ifNil:_card.name],[self ifNil:_card.job ],[self ifNil:_card.company],[NSString stringWithFormat:@"Mobile:%@",[self ifNil:_card.mobile0]],[NSString stringWithFormat:@"tele:%@",[self ifNil:_card.tele0]],[NSString stringWithFormat:@"%@ %@ %@",[self ifNil:_card.address.province],[self ifNil:_card.address.city],[self ifNil:_card.address.detailStreet]],[self ifNil:_card.qq],[self ifNil:_card.web], nil];
    NSDictionary *dicPro = _inputTemplate.dicStyles;
    NSArray *arr2Pro = [[NSArray alloc]initWithObjects:dicPro[@"name"],dicPro[@"title"],dicPro[@"company"],dicPro[@"mobile"],dicPro[@"telephone"],dicPro[@"address"],dicPro[@"qq"],dicPro[@"web"],nil];
    
    for (int i=0; i< [arr2Pro count]; i++) {
        TemplateItemStyle *stylePro = arr2Pro[i];
        [[UIColor colorWithCIColor:stylePro.color] setFill];
        if ([stylePro.fontName isEqualToString:@"bold"]) {
            CGPoint pointPro = CGPointMake(((float)stylePro.leftValue/2.0)*(rect.size.width/280.0), ((float)stylePro.topValue/2.5)*(rect.size.height/180.0));
            [arr1Pro[i] drawAtPoint:pointPro withFont:[UIFont systemFontOfSize:((float)stylePro.fontSizeValue/2.0)*(rect.size.width/280.0)]];
        }
    }
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    _cgImage = CGBitmapContextCreateImage(ctx);
    UIGraphicsPushContext(ctx);
}


#pragma mark - anim

- (NSString *)ifNil:(NSString *)str
{
    if (!str) {
        return @"";
    }
    return str;
}

- (void)doTouch
{
    _toFull?[self fromFull]:[self goFull];
}

- (void)goFull
{
    // [_delegate coverToTab];
    if(_animing)return;
    //初始化 GroupAnimation
    CAAnimationGroup *m_pGroupAnimation    = [CAAnimationGroup animation];
    m_pGroupAnimation.removedOnCompletion = NO;
    m_pGroupAnimation.duration=0.5;
	m_pGroupAnimation.fillMode=kCAFillModeForwards;
    m_pGroupAnimation.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    m_pGroupAnimation.delegate = self;
    
//  CGAffineTransform rotationTransform = CGAffineTransformMakeRotation(1 * M_PI / 2);
//  self.transform = rotationTransform;

//    CATransform3D sublayerTransform = CATransform3DIdentity;
//    // Set perspective
//    sublayerTransform.m34 = 1.0;
//    sublayerTransform = CATransform3DTranslate(sublayerTransform,0.0,0.0,10.0);
//    [self.layer setSublayerTransform:sublayerTransform];
    
    //创建子 Animation z旋转
    CABasicAnimation *rotaAnim=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotaAnim.toValue= [NSNumber numberWithFloat:M_PI/2];
    
    //创建子 Animation x放大
    CABasicAnimation *xAnimScale = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    xAnimScale.toValue = [NSNumber numberWithFloat: (_rectInTabFull.size.height/_rectInTab0.size.width)];
    
    //创建子 Animation Y放大
    CABasicAnimation *yAnimScale = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    yAnimScale.toValue = [NSNumber numberWithFloat: (_rectInTabFull.size.width/_rectInTab0.size.height)];
    
    //创建子 Animation position
    _oldPos = self.layer.position;
    _newPos = CGPointMake(_rectInTabFull.size.width/2.0+_rectInTabFull.origin.x - _rectInTab0.size.width/2.0-_rectInTab0.origin.x+_oldPos.x, _rectInTabFull.size.height/2.0+_rectInTabFull.origin.y - _rectInTab0.size.height/2.0-_rectInTab0.origin.y+_oldPos.y );
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"position"];
    
    animation2.fromValue = [NSValue valueWithCGPoint:_oldPos];
    animation2.toValue = [NSValue valueWithCGPoint:_newPos];
    
    //执行动画 xAnimScale,yAnimScale,
    m_pGroupAnimation.animations = [NSArray arrayWithObjects:rotaAnim,animation2,xAnimScale,yAnimScale,nil];
    [self.layer addAnimation:m_pGroupAnimation forKey:@"zAnimTo"];
}

- (void)fromFull
{
    if(_animing)return;
    //初始化 GroupAnimation
    CAAnimationGroup *m_pGroupAnimation    = [CAAnimationGroup animation];
    m_pGroupAnimation.removedOnCompletion = NO;
    m_pGroupAnimation.duration=0.5;
	m_pGroupAnimation.fillMode=kCAFillModeForwards;
    m_pGroupAnimation.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    m_pGroupAnimation.delegate = self;
    
    //创建子 Animation z旋转
    CABasicAnimation *rotaAnim=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotaAnim.fromValue = [NSNumber numberWithFloat:M_PI/2];
    rotaAnim.toValue= [NSNumber numberWithFloat:0.0];
    
    //创建子 Animation x放大
    CABasicAnimation *xAnimScale = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    xAnimScale.fromValue = [NSNumber numberWithFloat: (_rectInTabFull.size.height/_rectInTab0.size.width)];
    xAnimScale.toValue = [NSNumber numberWithFloat:1.0];
    
    //创建子 Animation Y放大
    CABasicAnimation *yAnimScale = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    yAnimScale.fromValue = [NSNumber numberWithFloat: (_rectInTabFull.size.width/_rectInTab0.size.height)];
    yAnimScale.toValue = [NSNumber numberWithFloat:1.0];
    
    //创建子 Animation position
    
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"position"];
    
    animation2.fromValue = [NSValue valueWithCGPoint:_newPos];
    animation2.toValue = [NSValue valueWithCGPoint:_oldPos];
    
    //执行动画 xAnimScale,yAnimScale,
    m_pGroupAnimation.animations = [NSArray arrayWithObjects:rotaAnim,animation2,xAnimScale,yAnimScale,nil];
    [self.layer addAnimation:m_pGroupAnimation forKey:@"zAnimFrom"];
    
}

- (void)goUp
{
    if(_animing||_toFull)return;
    
    _oldPos = self.layer.position;
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
    
    if (_delegate && [_delegate respondsToSelector:@selector(touchToChange)]) {
        [_delegate touchToChange];
    }
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

- (void)animationDidStart:(CAAnimation *)anim
{
    _animing = YES;
    if (anim == [self.layer animationForKey:@"zAnimTo"]) {
        
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    _animing = NO;
    if (flag) {
        if (anim == [self.layer animationForKey:@"zAnimTo"]) {
            _toFull = YES;
            return;
        }
        if (anim == [self.layer animationForKey:@"zAnimFrom"]) {
            _toFull = NO;
            return;
        }
        
        if (anim == [self.layer animationForKey:@"AnimGoUp"]) {
            if (_upFinish) {
                _upFinish();
            }
            return;
        }
        
        if (anim == [self.layer animationForKey:@"AnimGoRight"]) {
            if (_rightFinish) {
                _rightFinish();
            }
            return;
        }
    }
}

@end
