//
//  KHHCardImageView.h
//  Carte
//
//  Created by CJK on 13-3-12.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"
@protocol KHHCardImageViewDelegate <NSObject>
@optional
- (void)touchInImg:(UIView *)view;
- (void)coverToTab;
- (void)touchToChange;
@end

@interface KHHCardImageView : UIView
@property(nonatomic,strong)Card *card;
@property(nonatomic,strong)id<KHHCardImageViewDelegate> delegate;
@property(nonatomic,assign)CGImageRef cgImage;

//for input
@property(nonatomic,strong)UIImage *inputImage;
@property(nonatomic,strong)CardTemplate *inputTemplate;

//for inputAnim
@property(nonatomic,assign)Boolean isResponChange;
@property(nonatomic,assign)Boolean isResponChangeSave;

//for anim
@property(nonatomic,assign)CGRect rectInTab0;
@property(nonatomic,assign)CGRect rectInTab1;
@property(nonatomic,assign)CGRect rectInTabFull;
@property(nonatomic,assign)CGRect rectUp;
@property(nonatomic,assign)CGRect rectRight;
@property(nonatomic,assign)Boolean animing;
@property(nonatomic,assign)Boolean toFull;
//for table
@property(nonatomic,assign)NSIndexPath *indexPath;

@property(nonatomic,strong)void(^upFinish)();
@property(nonatomic,strong)void(^rightFinish)();
@property(nonatomic,strong)void(^shoudGetLocationAndGoUp)();
@property(nonatomic,strong)void(^shoudReloadContact)();
- (void)doTouch;
- (void)goUp;
- (void)goDown;
- (void)goRight;
@end
