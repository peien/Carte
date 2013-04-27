//
//  KHHAddDeleteTable.m
//  Carte
//
//  Created by CJK on 13-3-27.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHAddDeleteTable.h"
#import "KHHAddDeleteCell.h"

@implementation KHHAddDeleteTable
{
    NSMutableArray *_arrCardDic;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initArr];
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (void)initArr
{
    _arrCardDic = [[NSMutableArray alloc]init];
    
}

- (NSMutableArray *)arrSelectCard
{
    NSMutableArray *arrPro = [[NSMutableArray alloc]init];
    for (NSDictionary * dicPro in _arrCardDic) {
        if ([dicPro[@"checkOn"] isEqualToString:@"YES"]) {
            [arrPro addObject:dicPro[@"card"]];
        }
    }
    return arrPro;
}

- (void)setGroup:(Group *)group
{
    _group = group;
    for (Card *card in _group.card) {
        NSMutableDictionary *dicPro = [[NSMutableDictionary alloc]initWithCapacity:2];
        dicPro[@"card"] = card;
        dicPro[@"checkOn"] = @"NO";
        [_arrCardDic addObject:dicPro];
    }
}

#pragma mark - tableview dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrCardDic count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    static NSString *cellID = @"CustomerCell";
    KHHAddDeleteCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[KHHAddDeleteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.card = _arrCardDic[indexPath.row][@"card"];
    cell.checkOn = [_arrCardDic[indexPath.row][@"checkOn"] isEqualToString:@"YES"];
    return cell;
    
}

#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    _arrCardDic[indexPath.row][@"checkOn"] = [_arrCardDic[indexPath.row][@"checkOn"] isEqualToString:@"YES"]?@"NO":@"YES";
   [self reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationNone];
    if (_changeNum) {
        _changeNum();
    }
}

@end
