//
//  KHHAddDelMemViewController.h
//  Carte
//
//  Created by CJK on 13-3-26.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHViewController.h"
#import "Group.h"
#import "KHHSearDisplayController.h"

@interface KHHAddDelMemViewController : KHHViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
@property(nonatomic,strong)Group *group;
@property(nonatomic,strong)Group *toGroup;
@property(nonatomic,strong)void(^editSave)();
@end
