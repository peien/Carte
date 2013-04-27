//
//  KHHAlertSelectDetail.h
//  Carte
//
//  Created by CJK on 13-4-22.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHHBrowseTempSameTable.h"

@interface KHHAlertSelectDetail : UIView
@property (nonatomic,strong)UIImage *imageTemp;
@property (nonatomic,strong)Card *card;
@property (nonatomic,strong)void(^getTempDetail)(CardTemplateDetail *detail);
@end
