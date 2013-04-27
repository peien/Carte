//
//  KHHCardImageFullLanc.h
//  Carte
//
//  Created by CJK on 13-3-14.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

enum type_rect_transto {
    type_rect_transto_280 = 1,
    type_rect_transto_120,
};

#import <UIKit/UIKit.h>
#import "KHHCardImageView.h"

@interface KHHCardImageFullLanc : UIView
@property(nonatomic,assign)CGImageRef cgimage;
@property(nonatomic,assign)Boolean isHomeLeft;

//for anim
@property(nonatomic,assign)CGRect rectInTab0;
@property(nonatomic,assign)CGRect rectInTab1;
@property(nonatomic,assign)CGRect rectInTabFull;
@property(nonatomic,assign)CGRect rectUp;
@property(nonatomic,assign)CGRect rectFrom;
@property(nonatomic,assign)Boolean animing;
@property(nonatomic,assign)Boolean toFull;

//for template
@property(nonatomic,strong)CardTemplate *inputTemplate;
@property(nonatomic,strong)CardTemplateDetail *inputTemplateDetail;
@property(nonatomic,strong)Card *card;



- (void)transform;
- (void)transform:(Boolean)animation;
- (void)goFull;
- (void)fromFull;

@property(nonatomic,strong)void(^touchAction)();

@property(nonatomic,strong)void(^upFinish)();
@property(nonatomic,strong)void(^rightFinish)();
@property(nonatomic,strong)void(^shoudGetLocationAndGoUp)();
@property(nonatomic,strong)void(^shoudReloadContact)();

//for inputAnim
@property(nonatomic,assign)Boolean isResponChange;
@property(nonatomic,assign)Boolean isResponChangeSave;
@property(nonatomic,assign)CGRect rectRight;
@property(nonatomic,assign)Boolean toGoFull;
- (void)goUp;
- (void)goDown;
- (void)goRight;
@end
