//
//  KHHEditCardCell.h
//  Carte
//
//  Created by CJK on 13-3-13.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHHEditCardCell : UITableViewCell
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *value;
@property(nonatomic,strong)NSString *worn;
@property(nonatomic,strong)NSString *placeholder;
@property(nonatomic,assign)Boolean valueEnable;
@property(nonatomic,assign)int tagValue;
@property(nonatomic,strong)id<UITextFieldDelegate> delegate;
@property(nonatomic,assign) UIKeyboardType boardType;
@end
