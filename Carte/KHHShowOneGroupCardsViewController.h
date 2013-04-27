//
//  KHHShowOneGroupCardsViewController.h
//  Carte
//
//  Created by CJK on 13-3-25.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHViewController.h"
#import "KHHCardImageView.h"

#import "Group+ForView.h"

@interface KHHShowOneGroupCardsViewController : KHHViewController<UITableViewDataSource,UITableViewDelegate,KHHCardImageViewDelegate>
@property(nonatomic,strong)Group *group;
@end
