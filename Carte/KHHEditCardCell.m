//
//  KHHEditCardCell.m
//  Carte
//
//  Created by CJK on 13-3-13.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHEditCardCell.h"

@implementation KHHEditCardCell
{
    UILabel *_labelName;
    UITextField *_fieldValue;
    
    UILabel *_lableWorn;
    
    UIFont *font;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         font = [UIFont systemFontOfSize:13];
        self.selectionStyle =  UITableViewCellSelectionStyleNone;
        _labelName = [[UILabel alloc]initWithFrame:CGRectMake(19, 11, 50, 20)];
        _labelName.backgroundColor = [UIColor clearColor];
        _labelName.font = [UIFont systemFontOfSize:12];
        _fieldValue = [[UITextField alloc]initWithFrame:CGRectMake(70, 13, 200, 20)];
        _fieldValue.font = font;
        _fieldValue.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _fieldValue.inputAccessoryView = nil;
        _lableWorn = [[UILabel alloc]initWithFrame:CGRectMake(22, 22, 100, 20)];
        _lableWorn.backgroundColor = [UIColor clearColor];
        _lableWorn.font = [UIFont systemFontOfSize:9.0];
        _lableWorn.textColor = [UIColor redColor];
    }
    return self;
}

- (void)setName:(NSString *)name
{
    _labelName.text = name;
}

- (void)setValue:(NSString *)value
{
    _fieldValue.text = value;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _fieldValue.placeholder = placeholder;
}

- (void)setValueEnable:(Boolean)valueEnable
{
    _fieldValue.enabled = valueEnable;
}

- (void)setTagValue:(int)tagValue
{
    _fieldValue.tag = tagValue;
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate
{
    _fieldValue.delegate = delegate;
}

- (void)setBoardType:(UIKeyboardType)boardType
{
    _fieldValue.keyboardType = boardType;
}

- (void)setWorn:(NSString *)worn
{
    _lableWorn.text = worn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView addSubview:_labelName];
    [self.contentView addSubview:_fieldValue];
    [self.contentView addSubview:_lableWorn];
}
@end
