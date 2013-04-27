//
//  KHHCardViewController.h
//  Carte
//
//  Created by CJK on 13-3-26.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHViewController.h"
#import "Card+ShowDetail.h"
#import "KHHCardImageView.h"

@interface KHHCardViewController : KHHViewController<UITableViewDataSource,UITableViewDelegate,KHHCardImageViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)Card *card;
@property(nonatomic,strong)void(^editSave)();
@end
