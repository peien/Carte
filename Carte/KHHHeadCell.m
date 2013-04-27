//
//  KHHHeadCell.m
//  Carte
//
//  Created by CJK on 13-3-13.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "KHHHeadCell.h"
#import "KHHHeadImageView.h"

@implementation KHHHeadCell
{
    KHHHeadImageView *_headImage;
    UITextField *_filedName;
    UITextField *_filedJob;
    
    UIFont *_font;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle =  UITableViewCellSelectionStyleNone;
        
        _headImage = [[KHHHeadImageView alloc]initWithUrl:@""];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTapAction)];
        [_headImage addGestureRecognizer:singleTap];
//        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//        toolbar.barStyle = UIBarStyleBlackTranslucent;
        
        _font = [UIFont systemFontOfSize:13];
        _filedName = [[UITextField alloc]init];
        _filedName.font = _font;
        _filedName.placeholder = @"请输入姓名";
        _filedName.frame = CGRectMake(60, 8, 80, 20);
        _filedName.autocapitalizationType = UITextAutocapitalizationTypeNone;
       // _filedName.inputAccessoryView = toolbar;
        
        //_filedName.keyboardAppearance = UIKeyboardAppearanceAlert;
        _filedName.keyboardType = UIKeyboardTypeNamePhonePad;
        _filedJob = [[UITextField alloc]init];
        _filedJob.font = _font;
        _filedJob.placeholder = @"请输入职位";
        _filedJob.frame = CGRectMake(60, 35, 80, 20);
        _filedJob.autocapitalizationType = UITextAutocapitalizationTypeNone;
       // _filedJob.keyboardAppearance = UIKeyboardAppearanceAlert;
        _filedJob.keyboardType = UIKeyboardTypeNamePhonePad;
        
       
        
    }
    return self;
}

- (void)singleTapAction
{
    if ([_pickDelegate respondsToSelector:@selector(pickImage)]) {
        [_pickDelegate pickImage];
    }
}

- (void)setHeadImg:(UIImage *)headImg
{
    _headImage.image = headImg;
    
}

- (void)becameFirstRes
{
    [_filedName becomeFirstResponder];
}

- (void)setTagJob:(int)tagJob
{
    _tagJob = tagJob;
    _filedJob.tag = tagJob;
}

- (void)setTagName:(int)tagName
{
    _tagName = tagName;
    _filedName.tag = tagName;
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate
{
    _filedName.delegate = delegate;
    _filedJob.delegate = delegate;
}

- (void)setTextName:(NSString *)textName
{
    _filedName.text = textName;
}

- (void)setTextJob:(NSString *)textJob
{
    _filedJob.text = textJob;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView addSubview:_headImage];
    [self.contentView addSubview:_filedName];
    [self.contentView addSubview:_filedJob];
}

@end
