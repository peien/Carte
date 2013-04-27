//
//  KHHBrowseTempDetfaultCell.m
//  Carte
//
//  Created by CJK on 13-4-11.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHBrowseTempDetfaultCell.h"
#import "KHHCardFullWithImageView.h"

@implementation KHHBrowseTempDetfaultCell

{
    KHHCardFullWithImageView *_cardFull0;
    KHHCardFullWithImageView *_cardFull1;
    UILabel *_lable0;
    UILabel *_lable1;
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self doInSelfCardFull0];
        [self doInSelfCardFull1];
    }
    return self;
}

- (void)doInSelfCardFull0
{
    if (!_cardFull0) {
        _cardFull0 = [[KHHCardFullWithImageView alloc]initWithFrame: CGRectMake(10, 10, 280/2.0, 168/2.0)];
    }
}
- (void)doInSelfCardFull1
{
    if (!_cardFull1) {
        _cardFull1 = [[KHHCardFullWithImageView alloc]initWithFrame:CGRectMake(170, 10, 280/2.0, 168/2.0)];
    }
}
- (void)setCard0:(Card *)card0
{
    [self doInSelfCardFull0];
    _card0 = card0;
    _cardFull0.card = card0;
   
    
}

- (void)setCard1:(Card *)card1
{
    [self doInSelfCardFull1];
    _card1 = card1;
    _cardFull1.card = card1;
    
}

- (void)setDetail0:(CardTemplateDetail *)detail0
{
   [self doInSelfCardFull0];
   
}

- (void)setDetail1:(CardTemplateDetail *)detail1
{
    [self doInSelfCardFull1];
    
}

- (void)setImageTemp0:(UIImage *)imageTemp0
{
    [self doInSelfCardFull0];
    
}

- (void)setImageTemp1:(UIImage *)imageTemp1
{
    [self doInSelfCardFull1];
    
}



- (void)setLable0Str:(NSString *)lable0Str
{
    if (!_lable0) {
        _lable0 = [[UILabel alloc]initWithFrame:CGRectMake(20, 110, 120, 20)];
        [self doInSlefInitLable:_lable0];
    }
    _lable0.text = lable0Str;
}

- (void)doInSlefInitLable:(UILabel *)label
{
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12.0];
    label.textAlignment = NSTextAlignmentCenter;
}

- (void)setLable1Str:(NSString *)lable1Str
{
    if (!_lable1) {
        _lable1 = [[UILabel alloc]initWithFrame:CGRectMake(180, 110, 120, 20)];
        [self doInSlefInitLable:_lable1];
    }
    _lable1.text = lable1Str;
}

- (void)setTouchAction0:(void (^)())touchAction0
{
    _cardFull0.touchAction = touchAction0;
}

- (void)setTouchAction1:(void (^)())touchAction1
{
    _cardFull1.touchAction = touchAction1;
}

- (void)needDisPlay1
{    
    if (_cardFull1) {
        [_cardFull1 setNeedsDisplay];
    }
}

- (void)needDisPlay0
{
    if (_cardFull0) {
        [_cardFull0 setNeedsDisplay];
    }
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_cardFull0) {
        [self.contentView addSubview:_cardFull0];
    }
    if (_cardFull1) {
        [self.contentView addSubview:_cardFull1];
    }
    if (_lable0) {
        [self.contentView addSubview:_lable0];
    }
    if (_lable1) {
        [self.contentView addSubview:_lable1];
    }
}

@end
