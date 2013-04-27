//
//  KHHAlertSelectDetail.m
//  Carte
//
//  Created by CJK on 13-4-22.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHAlertSelectDetail.h"


@implementation KHHAlertSelectDetail
{
    KHHBrowseTempSameTable *_table;
    UIButton *btn;
    UILabel *labelTitle;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _table = [[KHHBrowseTempSameTable alloc]init];
        _table.frame = CGRectMake(0, 30, 320, frame.size.height-60);
        
        btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(0, frame.size.height-30, 320, 30);
        [btn setTitle:@"取消" forState:0];
        [btn setTitle:@"取消" forState:1];
        
        [btn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        
        labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
        labelTitle.textAlignment = NSTextAlignmentCenter;
        labelTitle.text = @"选择排版";
        [self addSubview:labelTitle];
        [self addSubview:_table];
        [self addSubview:btn];
    }
    return self;
}

- (void)setCard:(Card *)card
{
    _table.card = card;
    
}

- (void)setImageTemp:(UIImage *)imageTemp
{
    _table.imageTemp = imageTemp;
}

- (void)setGetTempDetail:(void (^)(CardTemplateDetail *))getTempDetail
{
    _table.getTempDetail = getTempDetail;
}

- (void)cancel
{
    [UIView animateWithDuration: 0.3
                     animations:^{
                         self.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

@end
