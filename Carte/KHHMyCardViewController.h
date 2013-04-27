//
//  KHHMyCardViewController.h
//  Carte
//
//  Created by CJK on 13-3-12.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHHCardImageView.h"
#import "Card.h"
#import "KHHViewController.h"

@interface KHHMyCardViewController : KHHViewController<KHHCardImageViewDelegate>
@property(nonatomic,strong)Card *card;

@end
