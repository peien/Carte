//
//  AGHeadImageViewController.h
//  Carte
//
//  Created by CJK on 13-3-20.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AGHeadImageView.h"
#import "KHHViewController.h"

@interface AGHeadImageViewController : KHHViewController
{
    AGHeadImageView *simpleImageEditorView;
}
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)void(^saveToCard)(NSData *data);
@end
