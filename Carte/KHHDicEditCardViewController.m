//
//  KHHDicEditCardViewController.m
//  Carte
//
//  Created by CJK on 13-3-18.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHDicEditCardViewController.h"
#import "Card.h"


@interface KHHDicEditCardViewController ()
{
    NSMutableArray *_arrSection0;
    NSMutableArray *_arrSection1;
    NSMutableArray *_arrSection2;
    NSMutableArray *_arrSection3;
    Card *_card;
}


@end

@implementation KHHDicEditCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initDics
{
    NSMutableDictionary *dicPhone = [[NSMutableDictionary alloc]initWithCapacity:6];
    dicPhone[@"title"] = @"手机";
    //dicPhone[@"value"] = self;
    dicPhone[@"placeholder"] = @"请输入手机号";
    dicPhone[@"keyboardType"] = [NSNumber numberWithInt:UIKeyboardTypeNumberPad];
    dicPhone[@"tag"] = [NSNumber numberWithInt:UIKeyboardTypeNumberPad];
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

@end
