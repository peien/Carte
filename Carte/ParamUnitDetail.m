//
//  ParamUnitDetail.m
//  Carte
//
//  Created by CJK on 13-3-26.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "ParamUnitDetail.h"

@implementation ParamUnitDetail
- (id)initWithTitle:(NSString *)title value:(NSString *)value
{
    if (self = [super init]) {
        _title = title;
        _value = value;
    }
    return self;
}
@end
