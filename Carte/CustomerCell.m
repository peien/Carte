//
//  CustomerCell.m
//  EnterpriseCheckWork
//
//  Created by CJK on 13-2-27.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "CustomerCell.h"
#import "KHHHeadImageView.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>

@implementation CustomerCell
{
    KHHHeadImageView *_imageView;
    UIImageView *_newView;
    UILabel *_nameLabel;
    UILabel *_phoneOrCompanyLabel;
    UILabel *_jobLabel;
    
    NSTimeInterval begin;
    NSTimeInterval end;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = [UIFont systemFontOfSize:14.0];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.frame = CGRectMake(63, 7, 78, 24);
        
        _jobLabel = [[UILabel alloc]init];
        _jobLabel.backgroundColor = [UIColor clearColor];
        _jobLabel.font = [UIFont systemFontOfSize:8.0];
        _jobLabel.textAlignment = NSTextAlignmentLeft;
        _jobLabel.frame = CGRectMake(175, 11, 125, 16);
        
        _phoneOrCompanyLabel = [[UILabel alloc]init];
        _phoneOrCompanyLabel.backgroundColor = [UIColor clearColor];
        _phoneOrCompanyLabel.font = [UIFont systemFontOfSize:7.0];
        _phoneOrCompanyLabel.textAlignment = NSTextAlignmentLeft;
        _phoneOrCompanyLabel.frame = CGRectMake(63, 34, 249, 20);
        
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [[touches allObjects] objectAtIndex:0];
    begin = touch.timestamp;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [[touches allObjects] objectAtIndex:0];   
    CGPoint location = [touch locationInView:touch.view];
    if (location.x<53.0) {
        if(_delegate&&[_delegate respondsToSelector:@selector(showPopVp:)]) {
            [_delegate showPopVp:self];
        }
        return;
    }
    
    if (end!=0&&touch.timestamp-end<=0.3) {
        return;
    }
    end = touch.timestamp;
    if(end - begin>=0.3){
        if(_delegate&&[_delegate respondsToSelector:@selector(showPopVp:)]) {
            [_delegate showPopVp:self];
        }        
    }else{
        if (_delegate&&[_delegate respondsToSelector:@selector(showDetail:)]) {
            [_delegate showDetail:self];
        }
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{

    [super setSelected:selected animated:animated];
}

- (void)setCard:(Card *)card
{
    
    _card = card;
    if (!_imageView) {
        _imageView = [[KHHHeadImageView alloc]initWithUrl:card.logoUrl];
    }else{
        KHHHeadImageView* weakImage = _imageView;
         [_imageView setImageWithURL:[NSURL URLWithString:card.logoUrl] placeholderImage:[UIImage imageNamed:@"logopic.png"] options:SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            [weakImage.layer setMasksToBounds:YES];
            [weakImage.layer setCornerRadius:6.0];
        }];
    }
   
    if (!_card.viewedValue) {
        if (!_newView) {
            _newView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"newIcon"]];
            _newView.frame = CGRectMake(3, 38, 50, 17);
        }
    }
   
    
    _nameLabel.text = card.name;
    _jobLabel.text = card.job?[NSString stringWithFormat:@"(%@)",card.job]:@"";
    if (_isCoWorker) {
        _phoneOrCompanyLabel.text = card.mobile0;
        return;
    }
    _phoneOrCompanyLabel.text = card.company;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView addSubview:_imageView];
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_jobLabel];
    [self.contentView addSubview:_phoneOrCompanyLabel];
    if (_newView) {
        if (_card.viewedValue) {
            [_newView removeFromSuperview];
        }
    }
    if (!_card.viewedValue) {
        [self addSubview:_newView];
    }
    
}

@end
