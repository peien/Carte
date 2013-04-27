//
//  KHHLoginCell.m
//  Carte
//
//  Created by CJK on 13-3-21.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHLoginCell.h"

@implementation KHHLoginCell
{
    UITextField *_field;
    UILabel *_lableAlert;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont systemFontOfSize:15.0];        
        _field = [[UITextField alloc]initWithFrame:CGRectMake(90, 14, 200, 30)];
        _field.font = [UIFont systemFontOfSize:12.0];
        _field.autocapitalizationType = UITextAutocapitalizationTypeNone;
        
        _lableAlert = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 200, 10)];
        _lableAlert.font = [UIFont systemFontOfSize:9.0];
        _lableAlert.backgroundColor = [UIColor clearColor];
        _lableAlert.textColor = [UIColor redColor];
    }
    return self;
}

- (void)setTag:(int)tag
{
    _field.tag = tag;
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate
{
    _field.delegate = delegate;
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType
{
    _field.keyboardType = keyboardType;
    
}

- (void)setSecureTextEntry:(Boolean)secureTextEntry
{
    _field.secureTextEntry = secureTextEntry;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _field.placeholder = placeholder;
}

- (void)setAlertText:(NSString *)alertText
{
    _lableAlert.text = alertText;
}

- (void)setValue:(NSString *)value
{
    _field.text = value;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView addSubview:_field];
    [self.contentView addSubview:_lableAlert];
}

@end
