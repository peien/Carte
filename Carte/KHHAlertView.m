//
//  KHHAlertView.m
//  Carte
//
//  Created by CJK on 13-3-27.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHAlertView.h"

@implementation KHHAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (NSMutableDictionary *)dic
{
    if (!_dic) {
        _dic = [[NSMutableDictionary alloc]initWithCapacity:3];
    }
    return _dic;
}


@end
