//
//  KHHWebViewController.m
//  Carte
//
//  Created by CJK on 13-4-22.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHWebViewController.h"
#import "NetClient+ToPaths.h"
@interface KHHWebViewController ()
{
    UIWebView *_webView;
}

@end

@implementation KHHWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _webView = [[UIWebView alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _webView.frame = CGRectMake(0, 0, 320, self.view.frame.size.height-44);
    [self.view addSubview:_webView];
    NSURL *url = [[NetClient sharedClient] currentServerUrl];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:req];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
