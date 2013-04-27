//
//  GroupCell.h
//  EnterpriseCheckWork
//
//  Created by CJK on 13-2-26.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"
@protocol GroupCellDelegate <NSObject>
@optional
- (void)oneTouchGroup:(Group *)interGroup;
- (void)towTouchGroup:(Group *)interGroup;
@end

@interface GroupCell : UITableViewCell

@property(nonatomic,strong)Group *group;
@property(nonatomic,strong)id<GroupCellDelegate> delegate;
@end
