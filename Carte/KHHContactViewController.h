//
//  KHHContactViewController.h
//  Carte
//
//  Created by CJK on 13-3-14.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupTable.h"
#import "CustomerTable.h"
#import "AddGroupView.h"
#import "KHHViewController.h"

@interface KHHContactViewController : KHHViewController<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate,GroupCellDelegate,CustomerCellDelegate,AddCustomerCellDelegate,AddGroupViewDelegate,UIActionSheetDelegate>
- (void)groudReload;
@end
