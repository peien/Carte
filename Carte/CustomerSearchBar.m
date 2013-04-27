//
//  CustomerSearchBar.m
//  EnterpriseCheckWork
//
//  Created by CJK on 13-2-27.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "CustomerSearchBar.h"

@implementation CustomerSearchBar
{
    UIButton *_showGroupsBut;
}

- (id)init{
    if (self = [super init]){
        self.frame = CGRectMake(0, 0, 320, 44);
        self.backgroundImage = [UIImage imageNamed:@"searchbar_bg_normal"];
        self.placeholder = @"请输入姓名、电话或者公司";
        _showGroupsBut = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
        [_showGroupsBut setImage:[UIImage imageNamed:@"check-normal"] forState:UIControlStateNormal];
        [_showGroupsBut setImage:[UIImage imageNamed:@"check-selected"] forState:UIControlStateHighlighted];
        [_showGroupsBut addTarget:self action:@selector(doInSelfShowGroup) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_showGroupsBut];
    }
    return self;
}

- (void)doInSelfShowGroup
{
    if (_showGroup) {
        _showGroup();
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
            UITextField *tf = (UITextField *)view;
            tf.font = [UIFont systemFontOfSize:12.0];
            CGRect rect = tf.frame;            
                    rect.size.width = 230 ;
               
                rect.origin.x = 45;
            
            
            tf.frame = rect;
        }
    }

}

@end
