//
//  ParamForEditecard.m
//  CardBook
//
//  Created by CJK on 13-1-11.
//  Copyright (c) 2013年 Kinghanhong. All rights reserved.
//

#import "ParamForEditecard.h"

@implementation ParamForEditecard

- (id)init
{
    if (self = [super init]) {
       _editingStyle = UITableViewCellEditingStyleNone;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder
{
    self = [super init];
    if (self) {
        _title = title;
        _placeholder = placeholder;
        _editingStyle = UITableViewCellEditingStyleNone;
        _boardType = UIKeyboardTypeDefault;
    }
    return self;
}
@end
