//
//  KHHLoginCell.h
//  Carte
//
//  Created by CJK on 13-3-21.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHHLoginCell : UITableViewCell
@property(nonatomic,strong)NSString *placeholder;
@property(nonatomic,assign)UIKeyboardType keyboardType;
@property(nonatomic,assign)Boolean secureTextEntry;
@property(nonatomic,assign)int tag;
@property(nonatomic,strong)id<UITextFieldDelegate> delegate;
@property(nonatomic,strong)NSString *value;

@property(nonatomic,strong)NSString *alertText;

@end
