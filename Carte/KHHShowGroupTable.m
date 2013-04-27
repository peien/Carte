//
//  KHHShowGroupTable.m
//  Carte
//
//  Created by CJK on 13-4-12.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHShowGroupTable.h"

#import "UIImageView+WebCache.h"
#import "KHHBrowseTempDetfaultCell.h"
#import "KHHCardFullWithImageView.h"

@implementation KHHShowGroupTable
{
    NSMutableArray *_arrTempalte;
    NSMutableArray *_arrCardImage;
    NSMutableArray *_arrLabelTitle;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _arrTempalte = [[NSMutableArray alloc]init];
        [_arrTempalte addObjectsFromArray:[Group allGroups]];
        _arrCardImage = [[NSMutableArray alloc]initWithCapacity:[_arrTempalte count]];
        for (int i=0; i<[_arrTempalte count]; i++) {
            KHHCardFullWithImageView *cardImage = [[KHHCardFullWithImageView alloc]init];
            cardImage.frame = i%2==0?CGRectMake(10, 10, 280/2.0, 168/2.0):CGRectMake(170, 10, 280/2.0, 168/2.0);
            [_arrCardImage addObject:cardImage];
        }
        
        _arrLabelTitle = [[NSMutableArray alloc]initWithCapacity:[_arrTempalte count]];
        for (int i=0; i<[_arrTempalte count]; i++) {
            UILabel *labelTitle = [[UILabel alloc]init];
            labelTitle.frame = i%2==0?CGRectMake(10, 90, 280/2.0, 30):CGRectMake(170, 90, 280/2.0, 30);
            labelTitle.text = ((Group *)_arrTempalte[i]).name;
            labelTitle.textAlignment = UITextAlignmentCenter;
            labelTitle.font = [UIFont systemFontOfSize:12.0];
            labelTitle.backgroundColor = [UIColor clearColor];
            [_arrLabelTitle addObject:labelTitle];
        }

    }
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrTempalte count]/2 + ([_arrTempalte count]%2==0?0:1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellTemplate = @"cellTemplate";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTemplate];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTemplate];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
   
    [self removeAllSub:cell.contentView]; 
   
    KHHCardFullWithImageView *cardImage = _arrCardImage[indexPath.row*2];
    if (((Group *)_arrTempalte[indexPath.row]).typeValue == type_group_all) {
        if ([[Group allGroupCard] count]==0) {
            cardImage.image =[UIImage imageNamed:@"null.jpg"];
             
        }else{
             cardImage.card = [Group allGroupCard][0];
            cardImage.detail = cardImage.card.cardTemplate.detail;
            cardImage.strUrl = cardImage.card.cardTemplate.imageUrl;
        }       
    }else if ([[((Group *)_arrTempalte[indexPath.row*2]).card allObjects] count] >0) {
        cardImage.card = [((Group *)_arrTempalte[indexPath.row*2]).card allObjects][0];
        cardImage.detail = cardImage.card.cardTemplate.detail;
        cardImage.strUrl = cardImage.card.cardTemplate.imageUrl;
       
    }else{
        cardImage.image =[UIImage imageNamed:@"null.jpg"];
    }
    cardImage.touchAction = ^(){
        if (_touchAction) {
            _touchAction(((Group *)_arrTempalte[indexPath.row*2]));
        }
    };
    [cell.contentView addSubview:cardImage];
    [cell.contentView addSubview:_arrLabelTitle[indexPath.row*2]];
    if ([_arrTempalte count]-1<indexPath.row*2+1) {
        return cell;
    }
    KHHCardFullWithImageView *cardImage1 = _arrCardImage[indexPath.row*2+1];
        if ([[((Group *)_arrTempalte[indexPath.row*2+1]).card allObjects] count] >0) {
            cardImage1.card = [((Group *)_arrTempalte[indexPath.row*2+1]).card allObjects][0];
            cardImage1.detail = cardImage.card.cardTemplate.detail;
            cardImage1.strUrl = cardImage.card.cardTemplate.imageUrl;            
           
        }else{
            cardImage1.image = [UIImage imageNamed:@"null.jpg"];
        }

    cardImage1.touchAction = ^(){
        if (_touchAction) {
            _touchAction(((Group *)_arrTempalte[indexPath.row*2+1]));
        }
    };
    [cell.contentView addSubview:cardImage1];
    [cell.contentView addSubview:_arrLabelTitle[indexPath.row*2+1]];
    return cell;
}

- (void)removeAllSub:(UIView *)view
{
    for (UIView *subView in [view subviews]) {
        [subView removeFromSuperview];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}


@end
