//
//  GroupCell.m
//  EnterpriseCheckWork
//
//  Created by CJK on 13-2-26.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "GroupCell.h"

@implementation GroupCell
{
    UILabel *_label;
    UIImageView *_imageView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        _label = [[UILabel alloc]init];
        _label.backgroundColor = [UIColor clearColor];
        _label.font = [UIFont systemFontOfSize:10.0];
        _label.textAlignment = NSTextAlignmentCenter;
//        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [_button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//        [_button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//        [_button setBackgroundImage:[UIImage imageNamed:@"left_btn_bg"] forState:UIControlStateNormal];
//        [_button setBackgroundImage:[UIImage imageNamed:@"left_btn_bg_selected"] forState:UIControlStateNormal];
        _label.frame = CGRectMake(0, 0, 75, 40);
        
        _imageView = [[UIImageView alloc]init];
        _imageView.image = [[UIImage imageNamed:@"left_btn_bg"]stretchableImageWithLeftCapWidth:1 topCapHeight:1];
        _imageView.frame =  CGRectMake(0, 0, 75, 40);
       
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
    
    [super setSelected:selected animated:animated];
    
    if (selected) {
        _label.textColor = [UIColor redColor];
        return;
    }
    _label.textColor = [UIColor blackColor];
    // Configure the view for the selected state
}

- (void)setGroup:(Group *)group
{
    _group = group;
    
    _label.text = _group.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView addSubview:_imageView];
    [self.contentView addSubview:_label];
   
}

@end
