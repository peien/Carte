//
//  KHHActivityViewController.m
//  Carte
//
//  Created by CJK on 13-3-25.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHActivityViewController.h"

@interface KHHActivityViewController ()

@end

@implementation KHHActivityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imDoIn:(NSString *)text
{
    if (![_activity isAnimating]) {
        [_activity startAnimating];
    }
    _textLabel.text = text;
    
}

- (void)viewDidUnload {
    [self setTextLabel:nil];
    [self setActivity:nil];
    [super viewDidUnload];
}
@end
