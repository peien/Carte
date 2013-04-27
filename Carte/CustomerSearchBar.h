//
//  CustomerSearchBar.h
//  EnterpriseCheckWork
//
//  Created by CJK on 13-2-27.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerSearchBar : UISearchBar
@property(nonatomic,strong) void(^showGroup)();
@end
