//
//  KHHShowOneGroupCardsViewController.m
//  Carte
//
//  Created by CJK on 13-3-25.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHShowOneGroupCardsViewController.h"

#import "UIImageView+WebCache.h"
#import "KHHCardFullWithImageView.h"

@interface KHHShowOneGroupCardsViewController ()
{
    UITableView *_table;
    NSMutableArray *_arrTempalte;
    NSMutableArray *_arrCardImage;
}

@end

@implementation KHHShowOneGroupCardsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.dataSource = self;
        _table.delegate = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.barLeftStr = @"返回";
    _table.frame = CGRectMake(0, 0, 320, self.view.frame.size.height-44);
    if ([_arrTempalte count] == 0) {        
        [self.view addSubview: [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"null.jpg"]]];
    }else{
         [self.view addSubview:_table];
    }
   
    
}

- (void)setGroup:(Group *)group
{
    _group = group;
    _arrTempalte = [[NSMutableArray alloc]initWithCapacity:20];
    if (_group.typeValue == type_group_all) {
        [_arrTempalte addObjectsFromArray:[Group allGroupCard]];
    }else{
        [_arrTempalte addObjectsFromArray:[_group.card allObjects]];
    }
    _arrCardImage = [[NSMutableArray alloc] initWithCapacity:[_arrTempalte count]];
    for (int i=0; i<[_arrTempalte count]; i++) {
        Card *cardPro = _arrTempalte[i];
        KHHCardFullWithImageView *cardImage = [[KHHCardFullWithImageView alloc]init];       
        cardImage.frame = CGRectMake(20, 37, 280, 168);
        cardImage.card = cardPro;
        cardImage.detail = cardPro.cardTemplate.detail;
        cardImage.strUrl = cardPro.cardTemplate.imageUrl;
        [_arrCardImage addObject:cardImage];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_arrTempalte count];
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
    [cell.contentView addSubview:_arrCardImage[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
}

- (void)removeAllSub:(UIView *)view
{
    for (UIView *subView in [view subviews]) {
        [subView removeFromSuperview];
    }
}


@end
