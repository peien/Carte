//
//  KHHCardDetailHeadCell.m
//  Carte
//
//  Created by CJK on 13-3-26.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHCardDetailHeadCell.h"
#import "KHHHeadImageView.h"

@implementation KHHCardDetailHeadCell
{
    KHHHeadImageView *_headImage;
    UILabel *_labelName;
    UILabel *_labelJob;
    
    UIFont *_font;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headImage = [[KHHHeadImageView alloc]initWithUrl:@""];
        
        _font = [UIFont systemFontOfSize:13];
        _labelName = [[UILabel alloc]init];
        _labelName.font = _font;        
        _labelName.frame = CGRectMake(60, 8, 80, 20);
        _labelName.backgroundColor = [UIColor clearColor];
        
        _labelJob = [[UILabel alloc]init];
        _labelJob.font = _font;        
        _labelJob.frame = CGRectMake(60, 35, 80, 20);
        _labelJob.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setTextName:(NSString *)textName
{
     _labelName.text = textName;
}

- (void)setTextJob:(NSString *)textJob
{
    _labelJob.text = textJob;
}

- (void)setHeadLogoImage:(UIImage *)headLogoImage
{
    _headImage.image = headLogoImage;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView addSubview:_headImage];
    [self.contentView addSubview:_labelName];
    [self.contentView addSubview:_labelJob];
}

@end
