//
//  KHHBrowseTemplateSrcollViewController.m
//  Carte
//
//  Created by CJK on 13-3-15.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHBrowseTemplateSrcollViewController.h"
#import "KHHUser.h"
@interface KHHBrowseTemplateSrcollViewController ()
{
    UIScrollView *_scroll;
    NSMutableArray *_arrTempalte;
    KHHCardImageView *cardViewPro;
    UIImage *imagePro;
}

@end

@implementation KHHBrowseTemplateSrcollViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _scroll = [[UIScrollView alloc]initWithFrame:CGRectZero];
        _scroll.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.barLeftStr = @"返回";
    self.barRightStr = @"更多";
    __block KHHBrowseTemplateSrcollViewController *weakSelf = self;
    KHHCardImageView *weakCardView = cardViewPro;
    UIImage *weakImagePro = imagePro;
    self.barRightAction = ^(){
        if ([weakSelf.barRightStr isEqual:@"更多"]) {
            return;
        }
        if (weakSelf.selectOne) {
            weakCardView.inputTemplate.image = weakImagePro;
            weakSelf.selectOne(weakCardView.inputTemplate);
        }
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    _scroll.frame = CGRectMake(0, 0, 320, self.view.frame.size.height-44);
    [self initArr];
    for (UIView *view in _arrTempalte) {
        [_scroll addSubview:view];
    }
    UIView *viewPro = [_arrTempalte lastObject];
    _scroll.contentSize = CGSizeMake(320, viewPro.frame.origin.y+viewPro.frame.size.height+30);
    [self.view addSubview:_scroll];
	// Do any additional setup after loading the view.
}
- (void)initArr
{
    _arrTempalte = [[NSMutableArray alloc]initWithCapacity:20];
    for (int i=0; i<8; i++) {
        KHHCardImageView *imageViewPro = [[KHHCardImageView alloc]initWithFrame:CGRectMake((i%2)*150+20, 100*(i/2)+10, 120, 120*9/14)];
        imageViewPro.card = _card;
       // imageViewPro.inputTemplate = ((CardTemplate *)[CardTemplate guTLTemplate:i]) ;
       // imageViewPro.inputTemplate.image = ((CardTemplate *)[CardTemplate guTLTemplate:i]).image ;
        imageViewPro.inputImage = ((CardTemplate *)[CardTemplate guTLTemplate:i]).image;
        imageViewPro.rectInTabFull = CGRectMake(0, 100*(i/2)+20,320, 460+88-44-50);
        
        imageViewPro.delegate = self;
        [_arrTempalte addObject:imageViewPro];
    }
    for (int i=0; i<7; i++) {
        //int sizeArr = [_arrTempalte count];
        KHHCardImageView *imageViewPro2 = [[KHHCardImageView alloc]initWithFrame:CGRectMake(((i+8)%2)*150+20, 100*((i+8)/2)+10, 120, 120*9/14)];
        imageViewPro2.card = _card;
       // imageViewPro2.inputTemplate = ((CardTemplate *)[CardTemplate chenQETemplate:i]) ;
       // imageViewPro2.inputTemplate.image = ((CardTemplate *)[CardTemplate chenQETemplate:i]).image ;
        imageViewPro2.inputImage = ((CardTemplate *)[CardTemplate chenQETemplate:i]).image;
        imageViewPro2.rectInTabFull = CGRectMake(0, 100*((i+8)/2)+20-400,320, 460+88-44-50);
        imageViewPro2.delegate = self;
        [_arrTempalte addObject:imageViewPro2];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchInImg:(UIView *)view
{
    //UITableViewCell *cell;
    
    if (cardViewPro&&cardViewPro.toFull) {
        if (cardViewPro.animing) {
            return;
        } 
        if ([cardViewPro isEqual:view]) {
            [cardViewPro doTouch];           
            self.barRightStr = @"更多";
            return;
        }
        [cardViewPro doTouch];
    }
    if (cardViewPro&&cardViewPro.animing) {
        return;
    }
    cardViewPro = (KHHCardImageView *)view;
    imagePro = cardViewPro.inputImage;
    [_scroll bringSubviewToFront:cardViewPro];
    
    [cardViewPro doTouch];
    self.barRightStr = @"使用";
}


@end
