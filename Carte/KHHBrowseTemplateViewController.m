//
//  KHHBrowseTemplateViewController.m
//  Carte
//
//  Created by CJK on 13-3-15.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHBrowseTemplateViewController.h"
#import "CardTemplate.h"
#import "KHHWebViewController.h"

#import "KHHBrowseTemplateTable.h"

@interface KHHBrowseTemplateViewController ()
{
    KHHBrowseTemplateTable *_table;
}

@end

@implementation KHHBrowseTemplateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _table = [[KHHBrowseTemplateTable alloc]initWithFrame:CGRectZero];
        
        KHHBrowseTemplateViewController *weakSelf = self;
        _table.touchAction = ^(CardTemplate *cardTemplate){
            if (weakSelf.selectOne) {
                weakSelf.selectOne(cardTemplate);
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.barLeftStr = @"返回";
    self.barRightStr = @"更多";
    KHHBrowseTemplateViewController *weakSelf = self;
    self.barRightAction = ^(){
        KHHWebViewController *webViewConPro = [[KHHWebViewController alloc]init];
        [weakSelf.navigationController pushViewController:webViewConPro animated:YES];
    };
    _table.card = _card;
	_table.frame = CGRectMake(0, 0, 320, self.view.frame.size.height-44);
    [self.view addSubview:_table];
}



@end
