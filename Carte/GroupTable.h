//
//  GroupTable.h
//  EnterpriseCheckWork
//
//  Created by CJK on 13-2-26.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupCell.h"

@interface GroupTable : UITableView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *arrGroupList;
@property(nonatomic,strong)NSIndexPath *currentIndexPath;
@property(nonatomic,strong)id<GroupCellDelegate> groupActionDelegate;
@property(nonatomic,assign)int selectGroupId;

- (void)showNewContactsNum;
@end
