//
//  ModifyViewController.h
//  LoveCard
//
//  Created by gh w on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHHViewController.h"

@interface ModifyViewController : KHHViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *theTable;
@end
