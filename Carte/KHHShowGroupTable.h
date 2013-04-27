//
//  KHHShowGroupTable.h
//  Carte
//
//  Created by CJK on 13-4-12.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group+ForView.h"

@interface KHHShowGroupTable : UITableView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)void(^touchAction)(Group *group);
@end
