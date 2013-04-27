//
//  KHHRegisterViewController.h
//  Carte
//
//  Created by CJK on 13-3-22.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHViewController.h"

@interface KHHRegisterViewController : KHHViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)void(^changeToActivityView)();
@end
