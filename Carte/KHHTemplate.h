//
//  KHHTemplate.h
//  Carte
//
//  Created by CJK on 13-3-12.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface KHHTemplateItemStyle : NSObject
@property(nonatomic,strong)NSString *id;

@property(nonatomic,assign)int top;
@property(nonatomic,assign)int left;
@property(nonatomic,assign)int fontSize;
@property(nonatomic,strong)NSString *fontName;
@property(nonatomic,strong)UIColor *color;

@end

@interface KHHTemplate : NSObject
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *imageUrl;

@property(nonatomic,strong)KHHTemplateItemStyle *styleName;
@property(nonatomic,strong)KHHTemplateItemStyle *styleJob;
@property(nonatomic,strong)KHHTemplateItemStyle *styleMobile;
@property(nonatomic,strong)KHHTemplateItemStyle *styleEmail;
@property(nonatomic,strong)KHHTemplateItemStyle *styleCompany;
@property(nonatomic,strong)KHHTemplateItemStyle *styleAddress;
@property(nonatomic,strong)KHHTemplateItemStyle *styleTelephone;
@property(nonatomic,strong)KHHTemplateItemStyle *styleFax;
//@property(nonatomic,strong)KHHTemplateItemStyle *styleLogo;
//for local
@property(nonatomic,strong)UIImage *image;

- (void)doInitForTest;
@end


