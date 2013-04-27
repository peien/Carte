//
//  KHHCardDetailCell.m
//  Carte
//
//  Created by CJK on 13-3-26.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHCardDetailCell.h"
#import "KHHHeadImageView.h"

@implementation KHHCardDetailCell
{
    UILabel *_labelName;
    UILabel *_labelValue;
    
    UIFont *_font;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _font = [UIFont systemFontOfSize:13];
        
        _labelName = [[UILabel alloc]initWithFrame:CGRectMake(19, 11, 50, 20)];
        _labelName.backgroundColor = [UIColor clearColor];
        _labelName.font = [UIFont systemFontOfSize:12];
        _labelValue = [[UILabel alloc]initWithFrame:CGRectMake(70, 13, 200, 20)];
        _labelValue.font = _font;
        _labelValue.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setName:(NSString *)name
{
    _labelName.text = name;
}

- (void)setValue:(NSString *)value
{
    _labelValue.text = value;
}


- (void)layoutSubviews
{
    [super layoutSubviews];    
    [self.contentView addSubview:_labelName];
    [self.contentView addSubview:_labelValue];
}


@end
