//
//  KHHSwapCardViewController.m
//  Carte
//
//  Created by CJK on 13-3-14.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHSwapCardViewController.h"
#import "KHHUser.h"
#import "KHHSendToViewController.h"
#import "MBProgressHUD.h"
#import "NetClient+ToPaths.h"
#import "KHHContactViewController.h"
#import "KHHCardImageFullLanc.h"
#import "UIImageView+WebCache.h"
#import "NetClient+ToPaths.h"
#import "NetClient+SyncAll.h"
#import <AudioToolbox/AudioToolbox.h>
#import "KHHCardFullWithImageView.h"

@interface KHHSwapCardViewController ()
{
    KHHCardImageView *_cardView;
    KHHCardImageFullLanc *_cardFull;
    KHHCardFullWithImageView *_cardImage;
    CLLocationManager *_localM;
    CLLocation *_currentLocation;
    UIImageView *_imageUtil;
    
    MBProgressHUD *_hud;
    
    NSTimer *timer; int _second;int _countNet;
    
    //buttons
    UIButton *_sendBtn;
    UIButton *_shakBtn;
    CFAbsoluteTime _shakeTime;
    
}

@end

@implementation KHHSwapCardViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
       
        _cardView = [[KHHCardImageView alloc]initWithFrame:CGRectMake(20, 37, 280, 180)];
        _cardView.isResponChange = YES;
        _cardView.rectUp = CGRectMake(20, -180, 280, 180);
        _cardView.rectRight = CGRectMake(330, 37, 280, 180);
       
        _cardFull = [[KHHCardImageFullLanc alloc]initWithFrame:CGRectMake(0, 0, 320, 320.0*5.0/3.0)];
        _cardFull.rectInTab0 = CGRectMake(20, 37, 280, 180);
        _cardFull.isHomeLeft = YES;
        _cardFull.toGoFull = NO;
        [_cardFull transform];
        _cardFull.isResponChange = NO;
        _cardFull.rectUp = CGRectMake(20, -180, 280, 180);
        _cardFull.rectRight = CGRectMake(330, 37, 280, 180);
        
        _cardImage = [[KHHCardFullWithImageView alloc]init];
        _cardImage.frame = CGRectMake(20, 37, 280, 168);
      //  _cardImage.cardFull = _cardFull;
        _imageUtil = [[UIImageView alloc]init];
        
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setImage:[UIImage imageNamed:@"exch_0"] forState:UIControlStateNormal];
        [_sendBtn setImage:[UIImage imageNamed:@"exch_0"] forState:UIControlStateHighlighted];
        [_sendBtn addTarget:self action:@selector(goSend) forControlEvents:UIControlEventTouchUpInside];
        _sendBtn.frame = CGRectMake(60, 220, 75, 75);
        
        _shakBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shakBtn setImage:[UIImage imageNamed:@"exch_1"] forState:UIControlStateNormal];
        [_shakBtn setImage:[UIImage imageNamed:@"exch_1"] forState:UIControlStateHighlighted];
        [_shakBtn addTarget:self action:@selector(exchangeCard) forControlEvents:UIControlEventTouchUpInside];
        _shakBtn.frame = CGRectMake(180, 220, 75, 75);
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
       
        if (CFAbsoluteTimeGetCurrent() - _shakeTime<2.0) {
            return;
        }else if (CFAbsoluteTimeGetCurrent() - _shakeTime < 20.0f){
            [self doInSlefAlert:@"请不要频繁交换名片" message:nil];
            return;
        }
        _shakeTime = CFAbsoluteTimeGetCurrent();
        [self exchangeCard];
    }
}

- (void)exchangeCard
{    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    [self getLocationForExChange];
}

- (void)goSend
{
    KHHSendToViewController *sendViewConPro = [[KHHSendToViewController alloc]initWithNibName:@"KHHSendToViewController" bundle:nil];
    sendViewConPro.theCard = _card;
    [self.navigationController pushViewController:sendViewConPro animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:_cardImage];
    _cardView.delegate = self;
    KHHSwapCardViewController *weakself = self;
    
    _cardFull.shoudGetLocationAndGoUp = ^(){
        [weakself getLocationForExChange];
    };
    [self.view addSubview:_shakBtn];
    [self.view addSubview:_sendBtn];
   // _cardFull.rectInTabFull = CGRectMake(0, 0,320, self.view.frame.size.height-44-50);
  //  self.barRightStr = @"发送至...";
    //Card *weakCard = _card;
//    self.barRightAction = ^(){
//        KHHSendToViewController *sendViewConPro = [[KHHSendToViewController alloc]initWithNibName:@"KHHSendToViewController" bundle:nil];
//        sendViewConPro.theCard = weakCard;
//        [weakself.navigationController pushViewController:sendViewConPro animated:YES];
//    };
	
//    _btnChange = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    _btnChange.frame = CGRectMake(20, 260, 80, 40);   
//    [_btnChange setTitle:@"交换" forState:UIControlStateNormal];
//    [_btnChange addTarget:self action:@selector(goChange) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_btnChange];
//    
//    _tellLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 230, 200, 20)];
//    _tellLabel.backgroundColor = [UIColor clearColor];
//    _tellLabel.text = @"上划交换名片";
//    _tellLabel.alpha = 0.7;
//    [self.view addSubview:_tellLabel];
}



- (void)goSave
{
    [_cardFull goRight];
}

- (void)refresh
{
    _card = [Card mycard];
    
//    _cardFull.cgimage = [UIImage imageNamed:@"chenQE05.jpg"].CGImage;
//    _cardFull.isHomeLeft = YES;
//    _cardFull.card = [Card mycard];
//    _cardFull.inputTemplate = _cardFull.card.cardTemplate;
//    KHHCardImageFullLanc *weakCardFull = _cardFull;
//    NSLog(@"%@",_cardFull.inputTemplate.imageUrl);
    _cardImage.strUrl = _card.cardTemplate.imageUrl;
//    [_cardImage setImageWithURL:[NSURL URLWithString:_cardFull.inputTemplate.imageUrl] placeholderImage:nil];
//    [_cardImage setImageWithURL:[NSURL URLWithString:_cardFull.inputTemplate.imageUrl] placeholderImage:[UIImage imageNamed:@"chenQE05.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
//        
//    }];
    

}

- (void)doInitWithUser
{
    _card = [Card mycard];   
    
//    _cardFull.cgimage = [UIImage imageNamed:@"chenQE05.jpg"].CGImage;
//    _cardFull.isHomeLeft = YES;
//    _cardFull.card = [Card mycard];
//    _cardFull.inputTemplate = _cardFull.card.cardTemplate;
  //  KHHCardImageFullLanc *weakCardFull = _cardFull;
    _cardImage.card = _card;
    _cardImage.detail = _card.cardTemplate.detail;
    _cardImage.strUrl = _card.cardTemplate.imageUrl;
//      [_cardImage setImageWithURL:[NSURL URLWithString:_cardFull.inputTemplate.imageUrl] placeholderImage:[UIImage imageNamed:@"chenQE05.jpg"]];
//    [_cardImage setImageWithURL:[NSURL URLWithString:_cardFull.inputTemplate.imageUrl] placeholderImage:[UIImage imageNamed:@"chenQE05.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
//        
//    }];
//    [_imageUtil setImageWithURL:[NSURL URLWithString:_cardFull.inputTemplate.imageUrl] placeholderImage:[UIImage imageNamed:@"chenQE05.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
//        weakCardFull.cgimage = image.CGImage;
//        [weakCardFull setNeedsDisplay];
//    }];
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
         [self doInSlefAlert:@"获取联系人总数失败" message:responseDict[@"note"]];
    }];

    
}

- (void)doInSlefSyncAll
{
    KHHSwapCardViewController *weakSelf = self;
    [[NetClient sharedClient] doSyncAllGroup:^(NSMutableDictionary *responseDict) {
        [((KHHContactViewController *)((UINavigationController *)weakSelf.parentViewController.parentViewController.childViewControllers[1]).childViewControllers[0]) groudReload];
        
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BMKit delegate
- (void)getLocationForExChange
{
    _localM = [[CLLocationManager alloc] init];
    if (_localM && [CLLocationManager locationServicesEnabled]) {
        _localM.delegate = self;
        _localM.distanceFilter = 100;
        _localM.desiredAccuracy = kCLLocationAccuracyBest;
        [_localM startUpdatingLocation];
        _hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        _hud.labelText = @"获取位置";
    }else {
        _localM = nil;
    }
    
}

#pragma mark - BMKit delegate
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    _hud.labelText = @"交换名片";
    _currentLocation = newLocation;
    [manager stopUpdatingLocation];
   // KHHSwapCardViewController *weakself = self;
    
    [self changeNet];
    [self startTimer];
//    _cardFull.upFinish = ^(){
//        [weakself changeNet];
//        [weakself startTimer];
//    };
//    [_cardFull goUp];
    
    
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    [_hud hide:YES];
    if (error.code == kCLErrorDenied) {
        [manager stopUpdatingHeading];
        [manager stopUpdatingLocation];
        
        [[[UIAlertView alloc]initWithTitle:@"获取位置失败" message:@"未打开定位服务" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
        
    }else if (error.code == kCLErrorHeadingFailure) {
        
    }
//    KHHCardImageView *weakCardView = _cardView;
//    _cardView.upFinish = ^(){
//        [weakCardView goDown];
//    };
    
}

#pragma mark - image delegate
- (void)touchInImg
{
    [_cardView doTouch];
    
}

- (void)touchToChange
{
    
       
}

#pragma mark - change net
- (void)changeNet
{
    NSLog(@"%f",_currentLocation.coordinate.latitude);
    NSLog(@"%f",_currentLocation.coordinate.longitude);
    _countNet=1;
    [[NetClient sharedClient] doShake:_card coordinate:_currentLocation.coordinate success:^(NSMutableDictionary *responseDict) {
        
        [_hud hide:YES];
        if (responseDict[@"card"]) {
//            _cardFull.card = responseDict[@"card"];
//            
//            _cardFull.inputTemplate = _cardFull.card.cardTemplate;
//            _cardFull.cgimage = _cardFull.card.cardTemplate.image.CGImage;
//            [_cardFull setNeedsDisplay];
          //   KHHCardImageView *weakCardView = _cardView;
            KHHCardImageFullLanc *weakCardFull = _cardFull;
 //           UIButton *weakBtn = _btnChange;
  //          [_btnChange setTitle:@"保存" forState:UIControlStateNormal];
         //   _cardFull.isResponChangeSave = YES;
            KHHSwapCardViewController *weakSelf = self;
            Card *weakCard = _card;
   //         UILabel *weakTellLabel = _tellLabel;
            UIImageView *weakImageUtil = _imageUtil;
            _cardFull.rightFinish = ^(){
                [((KHHContactViewController *)((UINavigationController *)weakSelf.parentViewController.parentViewController.childViewControllers[2]).childViewControllers[0]) doInitWithUser];
                weakCardFull.card = weakCard;
                weakCardFull.inputTemplate = weakCard.cardTemplate;
                [weakImageUtil setImageWithURL:[NSURL URLWithString:weakCard.cardTemplate.imageUrl] placeholderImage:[UIImage imageNamed:@"chenQE05.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    weakCardFull.cgimage = image.CGImage;
                    [weakCardFull setNeedsDisplay];
                }];                
                [weakCardFull goDown];
                weakCardFull.isResponChangeSave = NO;
             //   [weakBtn setTitle:@"交换" forState:UIControlStateNormal];
        //        weakTellLabel.text = @"上划交换名片";
            };
        }
     //   _tellLabel.text = @"右划保存";
     //   [_cardFull goDown];
        [self stopTimer];
    } failure:^(NSMutableDictionary *responseDict) {
        if (_countNet == 0) {
            return;
        }
        _countNet -= 1;
        [_hud hide:YES];
     //   [_cardFull goDown];
        [self stopTimer];
         [[[UIAlertView alloc]initWithTitle:@"交换失败" message:responseDict[@"note"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
    }];
}

#pragma mark - start timer
- (void)startTimer
{
    _second = 11;
    if (!timer) {
        timer = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                 target: self
                                               selector: @selector(handleTimer)
                                               userInfo: nil
                                                repeats: YES];
    }
}

- (void)handleTimer
{
    if (_second <=0) {
        if (_countNet == 0) {
            return;
        }
        _countNet-=1;
        
        [_hud hide:YES];
        [_cardFull goDown];
        [self stopTimer];
        [[[UIAlertView alloc]initWithTitle:@"交换失败" message:@"没有与其交换的名片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
        return;
    }
    _second -= 1;
    _hud.labelText = [NSString stringWithFormat:@"交换名片...%d",_second];
    
}

- (void)stopTimer
{
    if (timer) {
        
        [timer invalidate];
        timer = nil;
    }
}

@end
