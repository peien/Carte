//
//  KHHActivityViewController.h
//  Carte
//
//  Created by CJK on 13-3-25.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHHActivityViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;

- (void)imDoIn:(NSString *)text;

@end
