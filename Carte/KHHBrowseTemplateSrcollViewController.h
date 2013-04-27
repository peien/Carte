//
//  KHHBrowseTemplateSrcollViewController.h
//  Carte
//
//  Created by CJK on 13-3-15.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHViewController.h"
#import "KHHCardImageView.h"
@interface KHHBrowseTemplateSrcollViewController : KHHViewController<KHHCardImageViewDelegate>
@property(nonatomic,strong)void(^selectOne)(CardTemplate *templateSelect);
@property(nonatomic,strong)Card *card;
@end
