//
//  AGHeadImageViewController.m
//  Carte
//
//  Created by CJK on 13-3-20.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "AGHeadImageViewController.h"
#import "AGHeadImageView.h"

@interface AGHeadImageViewController ()
{
    UIButton * rotateLeftButton;
    UIButton *rotateRightButton;
}

@end

@implementation AGHeadImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        simpleImageEditorView = [[AGHeadImageView alloc] init];
        //        simpleImageEditorView = [[AGSimpleImageEditorView alloc] init];
        //        simpleImageEditorView.image = [UIImage imageNamed:@"apple.jpg"];
        simpleImageEditorView.borderWidth = 1.f;
        simpleImageEditorView.borderColor = [UIColor darkGrayColor];
        simpleImageEditorView.ratioViewBorderWidth = 3.f;
        
        
        rotateRightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [rotateRightButton setTitle:@"->" forState:UIControlStateNormal];
        [rotateRightButton addTarget:self action:@selector(rotateRight:) forControlEvents:UIControlEventTouchUpInside];
       
        
        rotateLeftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [rotateLeftButton setTitle:@"<-" forState:UIControlStateNormal];
        [rotateLeftButton addTarget:self action:@selector(rotateLeft:) forControlEvents:UIControlEventTouchUpInside];
        
        simpleImageEditorView.frame = CGRectMake(20, 0, 280, self.view.frame.size.height-44-60);
        [self.view addSubview:simpleImageEditorView];
        rotateLeftButton.frame = CGRectMake(20.f, self.view.frame.size.height-44-50, 40.f, 44.f);
        rotateRightButton.frame = CGRectMake(320 - 20.f - 40.f, self.view.frame.size.height-44-50, 40.f, 44.f);
        [self.view addSubview:rotateLeftButton];
        [self.view addSubview:rotateRightButton];
        
       
        
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    if (!image) {
        return;
    }
   _image = image;
    simpleImageEditorView.image = image;
    simpleImageEditorView.ratio = 1.0;
    //[self.view addSubview:simpleImageEditorView];
}

- (void)rotateLeft:(id)sender
{
    [simpleImageEditorView rotateLeft];
}

- (void)rotateRight:(id)sender
{
    [simpleImageEditorView rotateRight];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.barLeftStr = @"返回";
    self.barRightStr = @"使用";
    AGHeadImageViewController *weakSelf = self;
    self.barRightAction = ^(){
        [weakSelf saveImage];
        [self.navigationController popViewControllerAnimated:YES];
    };
    //simpleImageEditorView.frame =
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveImage
{
    NSData *data = UIImageJPEGRepresentation(simpleImageEditorView.output, 1);
    if (_saveToCard) {
        _saveToCard(data);
    }
}

@end
