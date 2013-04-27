//
//  KHHAddDeleteCell.m
//  Carte
//
//  Created by CJK on 13-3-27.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHAddDeleteCell.h"
#import "InterCustomer.h"
#import "KHHHeadImageView.h"

@implementation KHHAddDeleteCell
{
    KHHHeadImageView *_imageView;
    UILabel *_nameLabel;
    UILabel *_phoneOrCompanyLabel;
    UILabel *_jobLabel;
    UIImageView *_checkOnImage;
    
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
        
        _checkOnImage = [[UIImageView alloc]initWithFrame:CGRectMake(270, 20, 30, 30)];
        
    }
    return self;
}

- (void)setCheckOn:(Boolean)checkOn
{
    _checkOn = checkOn;
    if (_checkOn) {
        _checkOnImage.image = [UIImage imageNamed:@"Checkbox_checked"];
        return;
    }
    _checkOnImage.image = [UIImage imageNamed:@"Checkbox_unchecked"];
}

- (void)setCard:(Card *)card
{
    _imageView = [[KHHHeadImageView alloc]initWithUrl:card.logoUrl];
    _nameLabel.text = card.name;
    _jobLabel.text = card.job?[NSString stringWithFormat:@"(%@)",card.job]:@"";
    
    _phoneOrCompanyLabel.text = card.company;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView addSubview:_imageView];
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_jobLabel];
    [self.contentView addSubview:_phoneOrCompanyLabel];
    [self.contentView addSubview:_checkOnImage];
    
}@end
