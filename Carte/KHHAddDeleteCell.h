//
//  KHHAddDeleteCell.h
//  Carte
//
//  Created by CJK on 13-3-27.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface KHHAddDeleteCell : UITableViewCell
@property(nonatomic,strong)Card *card;
@property(nonatomic,assign)Boolean checkOn;
@end
