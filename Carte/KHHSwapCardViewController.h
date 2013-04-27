//
//  KHHSwapCardViewController.h
//  Carte
//
//  Created by CJK on 13-3-14.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHHCardImageView.h"
#import "KHHViewController.h"
#import "Card.h"
#import "NetClient+Shake.h"

@interface KHHSwapCardViewController : KHHViewController<KHHCardImageViewDelegate,CLLocationManagerDelegate>
@property(nonatomic,strong)Card *card;
@end
