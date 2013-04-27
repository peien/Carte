//
//  KHHViewController.h
//  Carte
//
//  Created by CJK on 13-3-14.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHHViewController : UIViewController
@property(nonatomic,strong)NSString *barLeftStr;
@property(nonatomic,strong)NSString *barRightStr;
@property(nonatomic,strong)void(^barLeftAction)();
@property(nonatomic,strong)void(^barRightAction)();

- (void)doInitWithUser;
- (void)refresh;
@end
