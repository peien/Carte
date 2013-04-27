//
//  KHHBrowseTempSameTable.h
//  Carte
//
//  Created by CJK on 13-4-11.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardTemplateDetail.h"
#import "Card.h"

@interface KHHBrowseTempSameTable : UITableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UIImage *imageTemp;
@property (nonatomic,strong)Card *card;
@property (nonatomic,strong)void(^getTempDetail)(CardTemplateDetail *detail);
@end
