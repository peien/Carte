//
//  KHHSearDisplayController.m
//  Carte
//
//  Created by CJK on 13-4-1.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHSearDisplayController.h"

@implementation KHHSearDisplayController
- (void)setActive:(BOOL)visible animated:(BOOL)animated
{
    [super setActive: visible animated: animated];
    
    [self.searchContentsController.navigationController setNavigationBarHidden: NO animated: NO];
}

@end
