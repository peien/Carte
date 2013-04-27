//
//  KHHLoginViewController.h
//  Carte
//
//  Created by CJK on 13-3-21.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHViewController.h"

@interface KHHLoginViewController : KHHViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)void(^loginSuccess)();
- (void)letMeAotu;
@end
