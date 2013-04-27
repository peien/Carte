//
//  KHHBrowseTempDetfaultCell.h
//  Carte
//
//  Created by CJK on 13-4-11.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardTemplateDetail.h"
#import "Card.h"
#import "Group.h"

@interface KHHBrowseTempDetfaultCell : UITableViewCell
@property(nonatomic,strong)Card *card0;
@property(nonatomic,strong)Card *card1;
@property(nonatomic,strong)CardTemplateDetail *detail0;
@property(nonatomic,strong)CardTemplateDetail *detail1;

@property(nonatomic,strong)UIImage *imageTemp0;
@property(nonatomic,strong)UIImage *imageTemp1;

@property(nonatomic,strong)NSString *lable0Str;
@property(nonatomic,strong)NSString *lable1Str;

@property(nonatomic,strong)void(^touchAction0)();
@property(nonatomic,strong)void(^touchAction1)();

- (void)needDisPlay0;
- (void)needDisPlay1;
@end
