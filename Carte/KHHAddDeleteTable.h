//
//  KHHAddDeleteTable.h
//  Carte
//
//  Created by CJK on 13-3-27.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"

@interface KHHAddDeleteTable : UITableView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)Group *group;
@property(nonatomic,strong)NSMutableArray *arrSelectCard;
@property(nonatomic,strong)void(^changeNum)();
@end
