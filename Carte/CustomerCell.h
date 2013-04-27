//
//  CustomerCell.h
//  EnterpriseCheckWork
//
//  Created by CJK on 13-2-27.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@class CustomerCell;
@protocol CustomerCellDelegate <NSObject>
@optional
- (void)showPopVp:(CustomerCell *)customerCell;
- (void)showDetail:(CustomerCell *)customerCell;
@end


@interface CustomerCell : UITableViewCell

@property(nonatomic,strong)Card *card;
@property(nonatomic,assign)Boolean isCoWorker;
@property(nonatomic,strong)id<CustomerCellDelegate> delegate;

@end
