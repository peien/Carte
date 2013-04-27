//
//  AddGroupView.m
//  EnterpriseCheckWork
//
//  Created by CJK on 13-3-5.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "AddGroupView.h"

@implementation AddGroupView
{
    UIButton *_button;
    UIImageView *_bgImg;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _bgImg.image = [[UIImage imageNamed:@"left_bg2" ] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
        [self addSubview:_bgImg];
        
        _button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [_button setImage:[UIImage imageNamed:@"addGroupIcon"] forState:UIControlStateNormal];
        [_button setImage:[UIImage imageNamed:@"addGroupIcon"] forState:UIControlStateHighlighted];
        [_button addTarget:self action:@selector(addGroupAction) forControlEvents:UIControlEventTouchUpInside];
         [self addSubview:_button];
    }
    return self;
}

- (void)addGroupAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(addGroupAction)]) {
        [_delegate addGroupAction];
    }
}


@end
