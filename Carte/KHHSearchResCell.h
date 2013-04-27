//
//  KHHSearchResCell.h
//  Carte
//
//  Created by CJK on 13-3-31.
//  Copyright (c) 2013年 cjk. All rights reserved.
//
enum type_search {
    type_search_nomal = 1,
    type_search_check,
    
};
#import <UIKit/UIKit.h>
#import "Card.h"
@interface KHHSearchResCell : UITableViewCell
@property(nonatomic,strong)Card *card;
@property(nonatomic,assign)Boolean checkon;
@property(nonatomic,assign)enum type_search type_search;
@end
