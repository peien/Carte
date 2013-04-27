//
//  KHHBrowseTemplateTable.m
//  Carte
//
//  Created by CJK on 13-4-19.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHBrowseTemplateTable.h"
#import "CardTemplate.h"
#import "KHHBrowseTempDetfaultCell.h"
#import "UIImageView+WebCache.h"
#import "KHHCardImageFullLanc.h"
#import "KHHImageUtil.h"
#import "KHHCardFullWithImageView.h"

@implementation KHHBrowseTemplateTable
{
    NSMutableArray *_arrTempalte;
    NSMutableDictionary *_dicImageCache;
    NSMutableArray *_arrUrlForLoad;
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
        [_arrTempalte addObjectsFromArray:[CardTemplate allTemplate]];
        _arrUrlForLoad = [[NSMutableArray alloc]init];
        _dicImageCache = [[NSMutableDictionary alloc]initWithCapacity:[_arrTempalte count]];
    }
    return self;
}

- (void)setCard:(Card *)card
{
    _card = card;
    _arrCardFull = [[NSMutableArray alloc]initWithCapacity:[_arrTempalte count]];
    
    
    
    for (int i=0; i< [_arrTempalte count]; i++) {
        KHHCardFullWithImageView *_cardImage = [[KHHCardFullWithImageView alloc]init];
        CardTemplate *cardTempaltePro = _arrTempalte[i];
        _cardImage.frame = i%2==0?CGRectMake(10, 10, 280/2.0, 168/2.0):CGRectMake(170, 10, 280/2.0, 168/2.0);
        _cardImage.card = _card;
        _cardImage.detail = cardTempaltePro.detail;
        _cardImage.strUrl = cardTempaltePro.imageUrl;
        _cardImage.touchAction = ^(){
            if (_touchAction) {
                _touchAction(cardTempaltePro);
            }
        };
        [_arrCardFull addObject:_cardImage];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrTempalte count]/2 + ([_arrTempalte count]%2==0?0:1);
}

- (void)removeAllSub:(UIView *)view
{
    for (UIView *subView in [view subviews]) {
        [subView removeFromSuperview];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellTemplate";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self removeAllSub:cell.contentView];
    [cell.contentView addSubview:_arrCardFull[indexPath.row*2]];
    //cell.card0 = _card;
    //    NSString *urlStr0 =((CardTemplate *)_arrTempalte[indexPath.row*2]).imageUrl;
    //    if (urlStr0) {
    //        if (_dicImageCache[urlStr0]) {
    //            cell.imageTemp0 = _dicImageCache[urlStr0];
    //           // [cell needDisPlay0];
    //        }else{
    //            [[[UIImageView alloc]init] setImageWithURL:[NSURL URLWithString:urlStr0] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
    //                _dicImageCache[urlStr0] = image;
    //                cell.imageTemp0 = _dicImageCache[urlStr0];
    //                [cell needDisPlay0];
    //            }];
    //        }
    //    }
    //
    //    cell.detail0 = ((CardTemplate *)_arrTempalte[indexPath.row*2]).detail;
    //    cell.touchAction0 = ^(){
    //        if (_touchAction) {
    //            _touchAction(((CardTemplate *)_arrTempalte[indexPath.row*2]));
    //        }
    //    };
    if ([_arrTempalte count]-1<indexPath.row*2+1) {
        return cell;
    }
    [cell.contentView addSubview:_arrCardFull[indexPath.row*2+1]];
   
    return cell;
}

//- (UIImageView *)getImageView:(int)index
//{
//    if([_arrImageUtil[index] isEqual:@""]){
//        _arrImageUtil[index] = [[UIImageView alloc]init];
//    }
//    return _arrImageUtil[index];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

//#pragma mark - Scroll View delegate
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    //  [self performSelectorInBackground:@selector(loadCellImage) withObject:nil];
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    if (!decelerate) {
//        //  [self performSelectorInBackground:@selector(loadCellImage) withObject:nil];
//    }
//}

@end
