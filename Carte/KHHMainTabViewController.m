//
//  KHHMainTabViewController.m
//  Carte
//
//  Created by CJK on 13-3-12.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHMainTabViewController.h"
#import "KHHUser.h"
#import "KHHLoginViewController.h"
#import "NaviViewControllerToUse.h"

@interface KHHMainTabViewController ()

@end

@implementation KHHMainTabViewController

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
//    CGRect frame = CGRectMake(0,0,320,49);
//    UIView *v = [[UIView alloc] initWithFrame:frame];
//    // 以图片为平铺的颜色模板，初始化颜色
//    UIImage *img = [UIImage imageNamed:@"tabbar.jpg"];
//    
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:img];
//    imageView.frame = frame;
//    UIColor *color = [[UIColor alloc] initWithPatternImage:img];
//    // 设置视图背景色
//    v.backgroundColor = color;
//    [self.tabBar insertSubview:imageView atIndex:1];
//    self.tabBar.opaque = YES;
	// Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doRefreshMyCard
{
    for(NaviViewControllerToUse *naviViewConPro in self.childViewControllers)
    {
        [(KHHViewController *)naviViewConPro.childViewControllers[0] refresh];
    }
    
}

- (void)doRefreshMyCardInLogin
{
    for(NaviViewControllerToUse *naviViewConPro in self.childViewControllers)
    {
        [(KHHViewController *)naviViewConPro.childViewControllers[0] doInitWithUser];
    }
}

@end
