//
//  KHHMyCardEditViewController.m
//  Carte
//
//  Created by CJK on 13-4-18.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHMyCardEditViewController.h"
#import "MBProgressHUD.h"
#import "Card+ForEditView.h"
#import "Card+NetParam.h"
#import "KHHMainTabViewController.h"

@interface KHHMyCardEditViewController ()

@end

@implementation KHHMyCardEditViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
         self.isForMyCard = YES;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {       
       self.isForMyCard = YES;
    }
    return self;
}

- (void)viewDidLoad
{
     self.card = [Card mycard];
    
    [super viewDidLoad];
    KHHMyCardEditViewController *weakSelf = self;
    self.editSave = ^(){
        [((KHHMainTabViewController*)weakSelf.parentViewController.parentViewController) doRefreshMyCard];
    };
    self.barLeftStr = @"";
	
}

-(void)viewDidDisappear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = NO;
    
}


@end
