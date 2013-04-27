//
//  KHHBrowseTemplateSameImage.m
//  Carte
//
//  Created by CJK on 13-4-11.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHBrowseTemplateSameImage.h"


@interface KHHBrowseTemplateSameImage ()

@end

@implementation KHHBrowseTemplateSameImage
{
    UITableView *_table;
    NSMutableArray *_arrTempalte;
}

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
	[self initArr];
    _table.frame = CGRectMake(0, 0, 320, self.view.frame.size.height-44);
    [self.view addSubview:_table];
}

- (void)initArr
{
    _arrTempalte = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
