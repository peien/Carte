//
//  KHHMyCardViewController.m
//  Carte
//
//  Created by CJK on 13-3-12.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHMyCardViewController.h"
#import "KHHEditCardViewController.h"
#import "KHHCardImageFullLanc.h"
#import <QuartzCore/QuartzCore.h>
#import "KHHUser.h"
#import "KHHMainTabViewController.h"
#import "UIImageView+WebCache.h"
#import "NetClient+SyncAll.h"
#import "KHHContactViewController.h"
#import "NetClient+ToPaths.h"

@interface KHHMyCardViewController ()
{
    KHHCardImageView *_cardView;
    KHHCardImageFullLanc *_cardFull;
    
    UIScrollView *_scroll;
    KHHCardImageFullLanc *_cardImageViewFull;
    Boolean _isInSelf;
    UIImageView *_imageUtil;
}
@end

@implementation KHHMyCardViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(changeFrames:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:nil];
        _cardView = [[KHHCardImageView alloc]initWithFrame:CGRectMake(20, 37, 280, 180)];
        _cardFull = [[KHHCardImageFullLanc alloc]initWithFrame:CGRectMake(0, 0, 320, 320.0*5.0/3.0)];
        _cardFull.isHomeLeft = YES;
        _cardFull.toGoFull = NO;
         [_cardFull transform];
        _imageUtil = [[UIImageView alloc]init];
        _scroll = [[UIScrollView alloc]init];
    }
    return self;
}

-(void)changeFrames:(NSNotification *)notification{
    return;
    //    float width=[[UIScreen mainScreen]bounds].size.width*[[UIScreen mainScreen] scale];
    //    float height=[[UIScreen mainScreen]bounds].size.height*[[UIScreen mainScreen] scale];
    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait
        || [[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortraitUpsideDown) {
        NSLog(@">>>portrait");
        if (_cardImageViewFull) {
            [_cardImageViewFull removeFromSuperview];
        }
        // self.frame=CGRectMake(0, 0, height, width);
    }else{
        if (!_isInSelf) {
            return;
        }
        if (!_cardImageViewFull) {
            //            float width = self.view.frame.size.height*5.0/7.0;
            //            float height = self.view.frame.size.height;
            _cardImageViewFull = [[KHHCardImageFullLanc alloc] initWithFrame:CGRectMake(0, 20,320, 320.0*5.0/3.0)];
            _cardImageViewFull.cgimage = _cardView.cgImage;
            
            // _cardImageViewFull.image = [UIImage imageWithCGImage:_cardView.cgImage scale:1.0 orientation:UIImageOrientationLeftMirrored];
        }
        if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft){
            _cardImageViewFull.isHomeLeft = YES;
        }else{
            _cardImageViewFull.isHomeLeft = NO;
        }
        if(![_cardImageViewFull superview]){
            [self.navigationController.tabBarController.view addSubview:_cardImageViewFull];
        }
        
        
        //[_cardView goFull];
        NSLog(@">>>landscape");
        //  self.frame=CGRectMake(0, 0, width, height);
    }
}

- (void)doInitWithUser
{
    _card = [Card mycard];
    _cardView.card = _card;
    [_cardView setNeedsDisplay];
    
    _cardFull.cgimage = [UIImage imageNamed:@"chenQE05.jpg"].CGImage;
    _cardFull.isHomeLeft = YES;
    _cardFull.card = [Card mycard];
    _cardFull.inputTemplate = _cardFull.card.cardTemplate;
    KHHCardImageFullLanc *weakCardFull = _cardFull;
   [_imageUtil setImageWithURL:[NSURL URLWithString:_cardFull.inputTemplate.imageUrl] placeholderImage:[UIImage imageNamed:@"chenQE05.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
       weakCardFull.cgimage = image.CGImage;
       [weakCardFull setNeedsDisplay];
   }];
   [[NetClient sharedClient] doInselfPath:@"get" methodPath:@"mobile/contact/count" parameters:nil success:^(NSMutableDictionary *responseDict) {
       if ([responseDict[@"count"] integerValue] - [Card numCard]<=0) {
           return;
       }
       
       if ([KHHUser shareInstance].agreeSync) {
           [self doInSlefSyncAll];
       }else{
          
           UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"同步确认" message:[NSString stringWithFormat:@"你有%d个联系人需要同步，允许同步吗？",[responseDict[@"count"] integerValue] - [Card numCard]] delegate:self cancelButtonTitle:@"不允许" otherButtonTitles:@"好的", nil];
           alert.tag = 200;
           [alert show];
       }

   } failure:^(NSMutableDictionary *responseDict) {
      // [self doInSlefAlert:@"获取联系人总数失败" message:responseDict[@"note"]];
   }];
    
    Card *weakCard = _card;
    KHHMyCardViewController *weakSelf = self;
    self.barRightAction = ^(){
        KHHEditCardViewController *editCardViewConPro = [[KHHEditCardViewController alloc]init];
        editCardViewConPro.card = weakCard;
        editCardViewConPro.editSave = ^(){
            [((KHHMainTabViewController *)weakSelf.parentViewController.parentViewController) doRefreshMyCard];
        };
        [weakSelf.navigationController pushViewController:editCardViewConPro animated:YES];
    };
    
}

- (void)refresh
{
    _card = [Card mycard];
    _cardView.card = _card;
    [_cardView setNeedsDisplay];
    
    _cardFull.cgimage = [UIImage imageNamed:@"chenQE05.jpg"].CGImage;
    _cardFull.isHomeLeft = YES;
    _cardFull.card = [Card mycard];
    _cardFull.inputTemplate = _cardFull.card.cardTemplate;
    KHHCardImageFullLanc *weakCardFull = _cardFull;
    NSLog(@"_cardFull.inputTemplate.imageUrl%@",_cardFull.inputTemplate.imageUrl);
    [_imageUtil setImageWithURL:[NSURL URLWithString:_cardFull.inputTemplate.imageUrl] placeholderImage:[UIImage imageNamed:@"chenQE05.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        weakCardFull.cgimage = image.CGImage;
        [weakCardFull setNeedsDisplay];
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 200) {
        if (buttonIndex == 0) {
            [KHHUser shareInstance].agreeSync = NO;
        }else{
            [KHHUser shareInstance].agreeSync = YES;
            [self doInSlefSyncAll];
        }
    }
}

- (void)doInSlefSyncAll
{
    KHHMyCardViewController *weakSelf = self;
    [[NetClient sharedClient] doSyncAllGroup:^(NSMutableDictionary *responseDict) {
        [((KHHContactViewController *)((UINavigationController *)weakSelf.parentViewController.parentViewController.childViewControllers[2]).childViewControllers[0]) groudReload];
        
        [[NetClient sharedClient] doSyncAllTemplateDetail:^(NSMutableDictionary *responseDict) {
            [[NetClient sharedClient] doSyncAllTemplate:^(NSMutableDictionary *responseDict) {
                [[NetClient sharedClient] doSyncAllCard:^(NSMutableDictionary *responseDict) {
                   
                } failure:^(NSMutableDictionary *responseDict) {
                    [self doInSlefAlert:@"同步联系人失败" message:responseDict[@"note"]];
                }];
            } failure:^(NSMutableDictionary *responseDict) {
                [self doInSlefAlert:@"同步模板失败" message:responseDict[@"note"]];
            }];
        } failure:^(NSMutableDictionary *responseDict) {
            [self doInSlefAlert:@"同步模板详细信息失败" message:responseDict[@"note"]];
        }];
    } failure:^(NSMutableDictionary *responseDict) {
        [self doInSlefAlert:@"同步分组失败" message:responseDict[@"note"]];
        
    }];
}

- (void)doInSlefAlert:(NSString *)title message:(NSString *)message
{
    [[[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _scroll.frame = CGRectMake(0, 0, 320, self.view.frame.size.height-44-50);
    _scroll.contentSize = CGSizeMake(320, 460+88-44-50);
    [self.view addSubview:_scroll];
    [_scroll addSubview:_cardFull];
    _cardView.delegate = self;
    _cardView.rectInTabFull = CGRectMake(0, 0,320, 460+88-44-50);
    // _cardView.isResponChange = YES;
    //  _cardView.rectUp = CGRectMake(20, -300, 280, 180);
    self.barLeftStr = @"同步";
    self.barRightStr = @"编辑";
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    _isInSelf = NO;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _isInSelf = YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
}


#pragma mark - image delegate
- (void)touchInImg:(UIView *)view
{
    [_cardView doTouch];
    
}

- (void)touchToChange
{
    // [_cardView goUp];
}

- (void)coverToTab
{
    _cardView.frame = _cardView.rectInTab1;
    [self.navigationController.tabBarController.view addSubview:_cardView];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    if (flag) {
        // [self.view addSubview:_cardImageViewFull];
        //        [self.navigationController.tabBarController.view addSubview:_cardImageViewFull];
        //        [_cardView.layer removeAllAnimations];
        //        _cardView.frame = _cardView.rectInTab0;
        //       [self.view addSubview:_cardView];
    }
}

@end
