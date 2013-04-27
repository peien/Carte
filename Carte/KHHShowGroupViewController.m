//
//  KHHShowGroupViewController.m
//  Carte
//
//  Created by CJK on 13-3-25.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHShowGroupViewController.h"
#import "KHHShowOneGroupCardsViewController.h"
#import "KHHShowGroupTable.h"

@interface KHHShowGroupViewController ()
{
    KHHShowGroupTable *_table;
    NSMutableArray *_arrTempalte;

}

@end

@implementation KHHShowGroupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _table = [[KHHShowGroupTable alloc]initWithFrame:CGRectZero];
        
        KHHShowGroupViewController *weakSelf = self;
        _table.touchAction = ^(Group *group){
            KHHShowOneGroupCardsViewController *groupCardViewConPro = [[KHHShowOneGroupCardsViewController alloc]init];
            groupCardViewConPro.group = group;
            [weakSelf.navigationController pushViewController:groupCardViewConPro animated:YES];
        };
    }
    return self;
}

-(void)viewDidDisappear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	self.barLeftStr = @"返回";
    _table.frame = CGRectMake(0, 0, 320, self.view.frame.size.height-44);
   
    [self.view addSubview:_table];
}

@end
