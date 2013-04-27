//
//  CustomerTable.h
//  EnterpriseCheckWork
//
//  Created by CJK on 13-2-27.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerCell.h"
#import "AddCustomerCell.h"

@interface CustomerTable : UITableView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *arrCustomerList;
@property(nonatomic,assign)Boolean isCoWorker;
@property(nonatomic,strong)id<CustomerCellDelegate> customerCellDelegate;
@property(nonatomic,strong)id<AddCustomerCellDelegate> addCustomerCellDelegate;
@end
