//
//  KHHStartUpViewController.h
//  Carte
//
//  Created by CJK on 13-3-22.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHHStartUpViewController : UIViewController

- (void)changeFromView:(int)from toView:(int)to isLeft:(Boolean)isLeft;
- (void)activityText:(NSString *)text;
- (void)changeToMain;

- (void)logout;
@end
