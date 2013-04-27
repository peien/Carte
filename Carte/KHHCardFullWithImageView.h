//
//  KHHCardFullWithImageView.h
//  Carte
//
//  Created by CJK on 13-4-23.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"
#import "CardTemplateDetail.h"

@interface KHHCardFullWithImageView : UIImageView
@property(nonatomic,strong)Card *card;
@property(nonatomic,strong)CardTemplateDetail *detail;
@property(nonatomic,strong)NSString *strUrl;

@property(nonatomic,strong)void(^touchAction)();
@end
