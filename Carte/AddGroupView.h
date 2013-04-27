//
//  AddGroupView.h
//  EnterpriseCheckWork
//
//  Created by CJK on 13-3-5.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddGroupViewDelegate <NSObject>
@optional
- (void)addGroupAction;
@end

@interface AddGroupView : UIView
@property (nonatomic,strong) id<AddGroupViewDelegate> delegate;
@end
