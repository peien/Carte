//
//  KHHViewController.m
//  Carte
//
//  Created by CJK on 13-3-14.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHViewController.h"

@interface KHHViewController ()

@end

@implementation KHHViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
	// Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBarLeftStr:(NSString *)barLeftStr
{
    _barLeftStr = barLeftStr;
    if (barLeftStr&&![barLeftStr isEqualToString:@""]) {
       
        self.navigationItem.leftBarButtonItem = [self doInBarGive:barLeftStr isLeft:YES];
        return;
    }
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)setBarRightStr:(NSString *)barRightStr
{
    _barRightStr = barRightStr;
    if (barRightStr&&![barRightStr isEqualToString:@""]) {
        //设置navigate bar
        
        self.navigationItem.rightBarButtonItem = [self doInBarGive:barRightStr isLeft:NO];
        return;
    }
    self.navigationController.navigationItem.rightBarButtonItem = nil;
}

- (UIBarButtonItem *)doInBarGive:(NSString *)barTitle isLeft:(Boolean)isLeft
{
    UIBarButtonItem *bar = isLeft?[[UIBarButtonItem alloc] initWithTitle:barTitle style:UIButtonTypeCustom target:self action:@selector(actionForLeft)]:[[UIBarButtonItem alloc] initWithTitle:barTitle style:UIButtonTypeCustom target:self action:@selector(actionForRight)];  
    
    [bar setBackgroundImage:[UIImage imageNamed:@"titlebtn_normal"]  forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    return bar;
}

- (void)actionForLeft
{
    if (_barLeftAction) {
        _barLeftAction();
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)actionForRight
{
    if (_barRightAction) {
        _barRightAction();
    }
}

-(void)viewDidDisappear:(BOOL)animated
{    
    self.hidesBottomBarWhenPushed = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    
    self.hidesBottomBarWhenPushed = YES;
}

- (void)doInitWithUser
{
}

- (void)refresh
{
    
}

@end
