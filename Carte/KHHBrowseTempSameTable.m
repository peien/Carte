//
//  KHHBrowseTempSameTable.m
//  Carte
//
//  Created by CJK on 13-4-11.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHBrowseTempSameTable.h"

#import "KHHCardFullWithImageView.h"

@implementation KHHBrowseTempSameTable
{
    NSMutableArray *_arrTempalte;
    NSMutableArray *_arrCardFull;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
        _arrTempalte = [[NSMutableArray alloc]init];
        [_arrTempalte addObjectsFromArray:[CardTemplateDetail allTempDetail]];
    }
    return self;
}

- (void)setCard:(Card *)card
{
    _card = card;
    _arrCardFull = [[NSMutableArray alloc]initWithCapacity:[_arrTempalte count]];   
    
    for (int i=0; i< [_arrTempalte count]; i++) {
        KHHCardFullWithImageView *_cardImage = [[KHHCardFullWithImageView alloc]init];
        CardTemplateDetail *cardTempalteDetailPro = _arrTempalte[i];
        _cardImage.frame = CGRectMake(20, 37, 280, 168);
        _cardImage.detail = cardTempalteDetailPro; 
        _cardImage.card = _card;
        _cardImage.image = _imageTemp;        
               
        _cardImage.touchAction = ^(){
            if (_getTempDetail) {
                _getTempDetail(cardTempalteDetailPro);
            }
        };
        [_arrCardFull addObject:_cardImage];
    }
}


- (void)removeAllSub:(UIView *)view
{
    for (UIView *subView in [view subviews]) {
        [subView removeFromSuperview];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrTempalte count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellTemplate = @"cellTemplate";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTemplate];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTemplate ];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }   
    [self removeAllSub:cell.contentView];
    [cell.contentView addSubview:_arrCardFull[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}



@end
