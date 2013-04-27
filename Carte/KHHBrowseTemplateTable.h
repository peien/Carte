//
//  KHHBrowseTemplateTable.h
//  Carte
//
//  Created by CJK on 13-4-19.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"
#import "CardTemplate.h"

@interface KHHBrowseTemplateTable : UITableView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)Card *card;
@property(nonatomic,strong)void(^touchAction)(CardTemplate *cardTemplate);
@end
