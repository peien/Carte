//
//  AddCustomerCell.h
//  EnterpriseCheckWork
//
//  Created by CJK on 13-2-27.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddCustomerCellDelegate <NSObject>
@optional
- (void)addNew;
@end
@interface AddCustomerCell : UITableViewCell
@property(nonatomic,strong)id<AddCustomerCellDelegate> delegate;
@end
