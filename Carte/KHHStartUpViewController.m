//
//  KHHStartUpViewController.m
//  Carte
//
//  Created by CJK on 13-3-22.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHStartUpViewController.h"
#import "KHHMainTabViewController.h"
#import "KHHUser.h"
#import "KHHLoginViewController.h"
#import "KHHActivityViewController.h"
#import "Card.h"
#import "KHHMyCardViewController.h"
#import "NaviViewControllerToUse.h"

@interface KHHStartUpViewController ()
{
    UIViewController *viewConProAccount;
    UIViewController *viewConProMainTab;
    KHHActivityViewController *activityViewConPro;
    UIStoryboard *mainStoryboard;
}

@end

@implementation KHHStartUpViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

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
	if (![KHHUser shareInstance].sessionId||![Card mycard]) {
        [self doInSelfAddViewCons];
        return;
    }
    viewConProMainTab = [self viewConFromId:@"MainTab"];
    [self subToInitWithUser];
    [self addChildViewController:viewConProMainTab];    
    [self.view addSubview:viewConProMainTab.view];
    
}

- (void)subToInitWithUser
{
    
    for (NaviViewControllerToUse *naviPro in viewConProMainTab.childViewControllers) {
        [((KHHViewController *)naviPro.childViewControllers[0]) doInitWithUser];
    }    

}

- (void)doInSelfAddViewCons
{
    if (activityViewConPro) {
        [activityViewConPro.view removeFromSuperview];
        [activityViewConPro removeFromParentViewController];
        activityViewConPro = nil;
    }
    
    if (!activityViewConPro) {
        activityViewConPro = (KHHActivityViewController *)[self viewConFromId:@"ActivityViewCon"] ;
        [self addChildViewController:activityViewConPro];
        [self.view addSubview:activityViewConPro.view];
    }
    
    if (viewConProAccount) {
        [viewConProAccount.view removeFromSuperview];
        [viewConProAccount removeFromParentViewController];
        viewConProAccount = nil;
    }
    
    if (!viewConProAccount) {
        viewConProAccount = [self viewConFromId:@"AccountViewCon"];
        [self addChildViewController:viewConProAccount];
        [self.view addSubview:viewConProAccount.view];
    }
    
    if (viewConProMainTab) {
        [viewConProMainTab.view removeFromSuperview];
         [viewConProMainTab removeFromParentViewController];
        viewConProMainTab = nil;
    }   
    if (!viewConProMainTab) {
        viewConProMainTab = [self viewConFromId:@"MainTab"];
        [self addChildViewController:viewConProMainTab];
        [self.view addSubview:viewConProMainTab.view];
    }    
    [self.view addSubview:viewConProAccount.view];
    
}

- (void)changeToMain
{
    [activityViewConPro willMoveToParentViewController:nil];
    [viewConProAccount willMoveToParentViewController:nil];
    [UIView animateWithDuration: 1.0
                     animations:^{
                         activityViewConPro.view.alpha = 0.0;
                         viewConProMainTab.view.alpha = 1.0;
                         //[self setChildHidden];
                     }
                     completion:^(BOOL finished) {
                         [activityViewConPro.view removeFromSuperview];
                         [viewConProAccount.view removeFromSuperview];
                         
                         [activityViewConPro removeFromParentViewController];
                         activityViewConPro = nil;
                         [viewConProAccount removeFromParentViewController];
                         viewConProAccount = nil;
                         [viewConProMainTab didMoveToParentViewController:self];                     
                         [self subToInitWithUser];
                     }];
}

- (void)changeFromView:(int)from toView:(int)to isLeft:(Boolean)isLeft
{
    [self transitionFromViewController:self.childViewControllers[from] toViewController:self.childViewControllers[to] duration:0.5 options:isLeft?UIViewAnimationOptionTransitionFlipFromLeft:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
}

- (void)activityText:(NSString *)text
{
    [activityViewConPro imDoIn:text];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)viewConFromId:(NSString *)indentifier
{
    if (!mainStoryboard) {
        mainStoryboard = [UIStoryboard storyboardWithName:@"Carte" bundle: nil];
    }    
    return [mainStoryboard instantiateViewControllerWithIdentifier:indentifier];
}


- (void)logout
{
    [KHHUser shareInstance].sessionId = nil;
    [KHHUser shareInstance].userId = nil;
    [KHHUser shareInstance].card = nil;
    [[KHHData sharedData] cleanContext];
    [self doInSelfAddViewCons];   
    
    [self transitionFromViewController:viewConProMainTab toViewController:viewConProAccount duration:0.5 options:UIViewAnimationOptionTransitionCurlDown animations:nil completion:nil];
      [self.view addSubview:viewConProMainTab.view];
      [self.view addSubview:viewConProAccount.view];
}
@end
