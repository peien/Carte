//
//  KHHSearchResCell.m
//  Carte
//
//  Created by CJK on 13-3-31.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHSearchResCell.h"

@implementation KHHSearchResCell
{
    UILabel *_labelName;
    UILabel *_labelCompany;
    UILabel *_labelPhone;
    UIImageView *_checkOnImage;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _labelName = [[UILabel alloc]init];
        _labelName.backgroundColor = [UIColor clearColor];
        _labelName.font = [UIFont systemFontOfSize:14.0];
        _labelName.textAlignment = NSTextAlignmentLeft;
        _labelName.frame = CGRectMake(10, 7, 78, 24);
        
        _labelCompany = [[UILabel alloc]init];
        _labelCompany.backgroundColor = [UIColor clearColor];
        _labelCompany.font = [UIFont systemFontOfSize:12.0];
        _labelCompany.textAlignment = NSTextAlignmentLeft;
        _labelCompany.frame = CGRectMake(10, 30, 78, 24);
        
        _labelPhone = [[UILabel alloc]init];
        _labelPhone.backgroundColor = [UIColor clearColor];
        _labelPhone.font = [UIFont systemFontOfSize:12.0];
        _labelPhone.textAlignment = NSTextAlignmentLeft;
        _labelPhone.frame = CGRectMake(90, 7, 90, 24);
    }
    return self;
}

- (void)setCard:(Card *)card
{
    _labelName.text = card.name?card.name:@"";
    _labelCompany.text = card.company?card.company:@"";
    _labelPhone.text = card.mobile0?card.mobile0:@"";
}

- (void)setCheckon:(Boolean)checkon
{
    _checkon = checkon;
    
    if (_type_search != type_search_check) {
        return;
    }
    
    if (!_checkOnImage) {
        _checkOnImage = [[UIImageView alloc]initWithFrame:CGRectMake(270, 20, 30, 30)];
    }
    [self.contentView addSubview:_checkOnImage];
    if (_checkon) {
        _checkOnImage.image = [UIImage imageNamed:@"Checkbox_checked"];
        return;
    }
    _checkOnImage.image = [UIImage imageNamed:@"Checkbox_unchecked"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView addSubview:_labelName];
    [self.contentView addSubview:_labelCompany];
    [self.contentView addSubview:_labelPhone];    
}


@end
